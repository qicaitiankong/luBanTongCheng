//
//  DispatchTicketDetailViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "DispatchTicketDetailViewController.h"
#import "TakeOrderQuotePriceDetailModel.h"
#import "OrderTakingQuotePriceDetailTableViewCell.h"
#import "DispatchTicketDetailBaoJiaTableViewCell.h"
#import "DispatchTicketDetailBaoJiaTableViewSectionView.h"
#import "OwnTextView.h"
//
#import "CommunicateViewController.h"
#import "OwnPersonalInfomationViewController.h"

@interface DispatchTicketDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    DispatchTicketDetailBaoJiaTableViewSectionView *sectionView;
    //
    UIButton *popBackButt;
    UIView *baseView;
    UIView *commentPopView;
    StarView *xinxinView;
    OwnTextView *commentTextView;
    //
    ShareNetWorkState *ownWorkState;
}

@property (strong,nonatomic) TakeOrderQuotePriceDetailModel *singleModel;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@end

@implementation DispatchTicketDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [NavTools displayNav:self.navigationController];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    self.title = @"派单详情";
    
    //
    [self initOwnObjects];
    //
    [self addTableView:CGRectMake(0, 0, self.view.width, CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    
    [self getData];
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
    ownWorkState = [ShareNetWorkState ShareNetState];
}

- (void)getData{
    //
    NSLog(@"\n\n???????????????派单详情雇主版orderid=%ld \n\n",self.orderId);
        NSDictionary *paraDict = @{@"orderId":[NSNumber numberWithInteger:self.orderId]};
        [TDHttpTools getEmployerLauchPieDetail:paraDict success:^(id response) {
            NSDictionary *dict = response;
            NSLog(@"派单详情雇主版 dict=%@",dict);
            NSDictionary *dataDict = dict[@"data"];
            self.singleModel = [[TakeOrderQuotePriceDetailModel alloc] init];
            self.singleModel.personNameStr = @"我发起的订单";
            self.singleModel.logoUrlStr = [NSString getResultStrBySeverStr:dataDict[@"headImg"]];
            self.singleModel.timeStr = [NSString getResultStrBySeverStr:dataDict[@"createTime"]];
            self.singleModel.praiseStr = [NSString getResultStrBySeverStr:dataDict[@"budget"]];
            self.singleModel.detailStr = [NSString getResultStrBySeverStr:dataDict[@"remark"]];
            NSNumber *receiveNum = [NSNumber getResultNumberBySeverStr: dataDict[@"receiveNum"]];
            NSInteger receviceNum =  [receiveNum integerValue];
            self.singleModel.ticketsNumberStr =[NSString stringWithFormat:@"%ld",receviceNum];
            self.singleModel.pictureUrlStrArr = [NSArray getResultArrBySeverArr:dataDict[@"publishOrderPics"]];
            //
            NSArray *bottomDataArr = dataDict[@"receiveList"];
            if (bottomDataArr.count){
                for (int i = 0; i < bottomDataArr.count; i ++){
                    NSDictionary *botDict  =  bottomDataArr[i];
                    DispatchTicketDetailBaoJiaModel *model = [DispatchTicketDetailBaoJiaModel setModelFromDict:botDict];
                    model.modelIndex = i;
                    [self.modelArr addObject:model];
                }
            }
            self.tableView.hidden = NO;
             [self.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
   
}

- (void)payHandler{
    
}

- (void)employeerEmploy:(NSIndexPath*)path{
    DispatchTicketDetailBaoJiaModel *model = self.modelArr[path.row];
    if (NO == [model.heIsHired boolValue]){//没有被雇佣再雇佣
        [TDHttpTools EmplyeerEmploy:@{@"receiveOrderId":model.receiveOrderIdNum} success:^(id response) {
            NSLog(@"雇佣：%@",response);
            DispatchTicketDetailBaoJiaModel *model = self.modelArr[path.row];
            model.heIsHired = [NSNumber numberWithBool:YES];
            [self.tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:response[@"msg"]];
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)commentRequest{
    NSLog(@"星星数量 %ld",xinxinView.starCount);
    [TDHttpTools EmplyeerComment:@{@"orderId":[NSNumber numberWithInteger:self.orderId],@"score":[NSNumber numberWithInteger:xinxinView.starCount],@"remark":[NSString getResultStrBySeverStr:commentTextView.writeTextView.text]} success:^(id response) {
        NSLog(@"评价：%@",response);
        [SVProgressHUD showSuccessWithStatus:response[@"msg"]];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

- (void)dealButtClick:(NSInteger)flag path:(NSIndexPath*)indexPath{
    NSLog(@"path.row=%ld",indexPath.row);
    switch (flag) {
        case 0:{
            NSLog(@"查看");
            DispatchTicketDetailBaoJiaModel *model = self.modelArr[indexPath.row];
            OwnPersonalInfomationViewController *infomationVC = [[OwnPersonalInfomationViewController alloc]init];
            infomationVC.targetUserId = model.baoJiaUserIdNum;
            [self.navigationController pushViewController:infomationVC animated:YES];
        }
            break;
        case 1:{
             NSLog(@"沟通");
            CommunicateViewController *communicateVC = [[CommunicateViewController alloc]init];
            communicateVC.conversationType = 1;
            NSString *deviceID = VENDER_IDENTIFIER;
             NSString *lzhDeviceStr = @"6D74CBD6-1D81-45E0-B329-690CA31AF49C";
            if([deviceID isEqualToString:lzhDeviceStr]){
                communicateVC.targetId = @"TEST02-6D74CBD6-1D81-45E0-B329-690CA31AF49C";
                communicateVC.title = @"test02";
            }else{
                communicateVC.targetId = @"LZH-6D74CBD6-1D81-45E0-B329-690CA31AF49C";
                communicateVC.title = @"LZH";
            }
            
            [self.navigationController pushViewController:communicateVC animated:YES];
        }
            break;
        case 2:{
             NSLog(@"雇佣");
            //[self displayPopView];
            //
            [self employeerEmploy:indexPath];
        }
            break;
        case 3:{
            NSLog(@"发消息");
           
        }
            break;
        case 4:{
            NSLog(@"拨号");
        }
            break;
        case 5:{
            NSLog(@"取消");
            DispatchTicketDetailBaoJiaModel *model = self.modelArr[indexPath.row];
            model.shouldDisplayBottomView = NO;
            [self.tableView reloadData];
        }
            break;
        case 6:{
             NSLog(@"确认完成");
            [self displayCommentPopView];
        }
            break;
        case 7:{
            
            DispatchTicketDetailBaoJiaModel *model = self.modelArr[indexPath.row];
            model.beginPlaySound = YES;
            if(nil == model.soundAmrData){
                [SVProgressHUD showInfoWithStatus:@"语音下载中"];
                NSLog(@"先去下载语音去播放");
                if ([model.soundUrlStr length]){
                    [ownWorkState asynSerialDownloadMethd02:model.soundUrlStr downloadCompleteHandler:@selector(addSoundToAnswer:) target:self modelIndex:indexPath.row];
                }
            }else{
                //直接播放
                [self.tableView reloadData];
            }
        }
            break;
        default:
            break;
    }
}

- (void)addSoundToAnswer:(NSDictionary*)dict{
    int answerIndex = [dict[@"modelIndex"] intValue];
    NSData *answerSoundData = [dict[@"imageData"] copy];
    DispatchTicketDetailBaoJiaModel *answerModel = self.modelArr[answerIndex];
    answerModel.soundAmrData = answerSoundData;
    //->wav
    [answerModel getWavData];
    //
    [self.tableView reloadData];
}




//views
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    //
    sectionView = [[DispatchTicketDetailBaoJiaTableViewSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    sectionView.displayLabel.text = @"应征/报价列表";
    //
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //默认隐藏
    self.tableView.hidden = YES;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 2:
            rows = self.modelArr.count;
            break;
        default:
            break;
    }
    return rows;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *parentCell = nil;
    if (indexPath.section == 0){
        static NSString *cellFlag = @"cellFlag";
        OrderTakingQuotePriceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell){
            cell = [[OrderTakingQuotePriceDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
        }
        cell.model = self.singleModel;
        parentCell = cell;
    }else if(indexPath.section == 2){
        NSLog(@"indexPath.section == 2");
        static NSString *cellFlag = @"cellFlag2";
        DispatchTicketDetailBaoJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell){
            cell = [[DispatchTicketDetailBaoJiaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
            WS(weakSelf);
            cell.clickButtBlock = ^(NSInteger index, NSIndexPath *path) {
                 [weakSelf dealButtClick:index path:indexPath];
            };
            cell.stopVoiceBlock = ^(NSIndexPath *path) {
                DispatchTicketDetailBaoJiaModel *localModel = weakSelf.modelArr[path.row];
                localModel.beginPlaySound = NO;
                [weakSelf.tableView reloadData];
            };
        }
        cell.indexPath = indexPath;
        cell.model = self.modelArr[indexPath.row];
        parentCell = cell;
    }
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    
    if (indexPath.section == 0){
        TakeOrderQuotePriceDetailModel *model = self.singleModel;
        height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderTakingQuotePriceDetailTableViewCell class] contentViewWidth:SCREEN_WIDTH];
        NSLog(@"!!!!!!!!!HEIGHT=%lf",height);
    }else if (indexPath.section == 2){
        DispatchTicketDetailBaoJiaModel *model = self.modelArr[indexPath.row];
        height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DispatchTicketDetailBaoJiaTableViewCell class] contentViewWidth:SCREEN_WIDTH];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1){
        return sectionView.height;
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1){
        return sectionView;
    }else{
        return nil;
    }
}

//pop view
- (void)displayPopView{
    //
    if(nil ==  baseView){
            UIWindow *appWindow = APP_MAIN_WINDOW;
            popBackButt = [UIButton buttonWithType:UIButtonTypeCustom];
            popBackButt.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            popBackButt.backgroundColor = [UIColor grayColor];
            popBackButt.alpha = POP_VIEW_ALPHA;
            [appWindow addSubview:popBackButt];
            //
            baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.741, SCREEN_WIDTH * 0.741)];
            baseView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
            baseView.backgroundColor = [UIColor whiteColor];
        
            baseView.clipsToBounds = YES;
            baseView.layer.cornerRadius = baseView.width * 0.035;
            [appWindow addSubview:baseView];
            //
            UILabel *topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:1];
            topTipLabel.text = @"托管支付";
            topTipLabel.frame = CGRectMake(0, baseView.height * 0.07, baseView.width, baseView.height * 0.1);
            [baseView addSubview:topTipLabel];
            //
            UILabel *centerLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
            centerLabel.numberOfLines = 0;
            centerLabel.text = @"为保障双方权益，请先托管资金到平台，服务完全面以后，服务商获得赏金。";
            centerLabel.frame = CGRectMake(0, baseView.height * 0.18, baseView.width * 0.8, baseView.height * 0.35);
            centerLabel.center = CGPointMake(baseView.width / 2, centerLabel.centerY);
            [baseView addSubview:centerLabel];
            //
            CustomeStyleCornerButt *cancelButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, baseView.height * 0.8, baseView.width / 2, baseView.height * 0.2) backColor:[UIColor colorWithHexString:@"#F5F5F5"] cornerRadius:-1 title:@"取消" titleColor:[UIColor colorWithHexString:@"#999999"] font:[UIFont getPingFangSCMedium:16]];
            WS(weakSelf);
            cancelButt.clickButtBlock = ^{
                [weakSelf removePopView];
            };
            [baseView addSubview:cancelButt];
            //
            UIColor *payBackCol = SPECIAL_BLUE_COLOR;
            CustomeStyleCornerButt *payButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(cancelButt.right, baseView.height * 0.8, baseView.width / 2, baseView.height * 0.2) backColor:payBackCol cornerRadius:-1 title:@"支付" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:16]];
            payButt.clickButtBlock = ^{
                [weakSelf removePopView];
            };
            [baseView addSubview:payButt];
    }
}

- (void)removePopView{
    [popBackButt removeFromSuperview];
    [baseView removeFromSuperview];
    popBackButt = nil;
    baseView = nil;
}
//评级popView
- (void)displayCommentPopView{
    //
    if(nil ==  commentPopView){
        UIWindow *appWindow = APP_MAIN_WINDOW;
        popBackButt = [UIButton buttonWithType:UIButtonTypeCustom];
        popBackButt.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        popBackButt.backgroundColor = [UIColor grayColor];
        popBackButt.alpha = POP_VIEW_ALPHA;
        [appWindow addSubview:popBackButt];
        //
        commentPopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.741, SCREEN_WIDTH * 0.741)];
        commentPopView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - 150);
        commentPopView.backgroundColor = [UIColor whiteColor];
        commentPopView.clipsToBounds = YES;
        commentPopView.layer.cornerRadius = commentPopView.width * 0.035;
        [appWindow addSubview:commentPopView];
        //
        UILabel *topTipLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:16] titleColor:[UIColor colorWithHexString:@"#333333"] aligement:1];
        topTipLabel.text = @"评价";
        topTipLabel.frame = CGRectMake(0, commentPopView.height * 0.07, commentPopView.width, commentPopView.height * 0.1);
        [commentPopView addSubview:topTipLabel];
        //
        UILabel *centerLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:15] titleColor:[UIColor colorWithHexString:@"#666666"] aligement:0];
        centerLabel.text = @"满意度";
        centerLabel.frame = CGRectMake(0, topTipLabel.bottom +  commentPopView.height * 0.05, commentPopView.width * 0.8, commentPopView.height * 0.1);
        centerLabel.center = CGPointMake(commentPopView.width / 2, centerLabel.centerY);
        [commentPopView addSubview:centerLabel];
        //
         xinxinView = [[StarView alloc]initWithFrameCustomeStyle:CGRectMake(0, centerLabel.bottom + commentPopView.height * 0.05, commentPopView.width * 0.75, commentPopView.width * 0.125) starWidth:commentPopView.width * 0.107];
        xinxinView.userInteractionEnabled = YES;
        xinxinView.center = CGPointMake(commentPopView.width / 2, xinxinView.centerY);
        [xinxinView setYellowStar:4];
        [commentPopView addSubview:xinxinView];
        //
        commentTextView = [[OwnTextView alloc]initWithFrame:CGRectMake(centerLabel.left, xinxinView.bottom + commentPopView.height * 0.05, commentPopView.width - 2 * centerLabel.left, commentPopView.height * 0.215)];
        commentTextView.layer.cornerRadius = 3;
        commentTextView.clipsToBounds = YES;
        commentTextView.backgroundColor = [UIColor colorWithHexString:@"#E2E2E2"];
        commentTextView.writeTextView.backgroundColor = commentTextView.backgroundColor;
        commentTextView.writeViewPlaceHolderLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        commentTextView.writeViewPlaceHolderLabel.font = [UIFont getPingFangSCRegular:12];
        commentTextView.writeViewPlaceHolderLabel.text = @"服务等还满意吗？";
        [commentPopView addSubview:commentTextView];
        [commentTextView.writeTextView becomeFirstResponder];
        WS(weakSelf);
        commentTextView.keyBoardChangedBlock = ^(CGFloat keyBoardHeight) {
            __strong typeof(weakSelf) sslef = weakSelf;
            sslef -> commentPopView.frame = CGRectMake(sslef -> commentPopView.x, SCREEN_HEIGHT - keyBoardHeight - sslef -> commentPopView.height, sslef -> commentPopView.width, sslef -> commentPopView.height);
        };
        
        //
        CustomeStyleCornerButt *cancelButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(0, commentPopView.height * 0.85, commentPopView.width / 2, commentPopView.height * 0.15) backColor:[UIColor colorWithHexString:@"#F5F5F5"] cornerRadius:-1 title:@"取消" titleColor:[UIColor colorWithHexString:@"#999999"] font:[UIFont getPingFangSCMedium:16]];
        cancelButt.clickButtBlock = ^{
            [weakSelf removeCommentPopView];
        };
        [commentPopView addSubview:cancelButt];
        //
        UIColor *payBackCol = SPECIAL_BLUE_COLOR;
        CustomeStyleCornerButt *commitButt = [[CustomeStyleCornerButt alloc]initWithFrame:CGRectMake(cancelButt.right, commentPopView.height * 0.85, commentPopView.width / 2, commentPopView.height * 0.15) backColor:payBackCol cornerRadius:-1 title:@"提交" titleColor:[UIColor whiteColor] font:[UIFont getPingFangSCMedium:16]];
        commitButt.clickButtBlock = ^{
            [weakSelf removeCommentPopView];
            [weakSelf commentRequest];
        };
        [commentPopView addSubview:commitButt];
        //
    }
}

- (void)removeCommentPopView{
    [popBackButt removeFromSuperview];
    [commentPopView removeFromSuperview];
    popBackButt = nil;
    commentPopView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
