//
//  OrderTakingQuotePriceDetailViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "OrderTakingQuotePriceDetailViewController.h"
#import "OrderTakingQuotePriceDetailTableViewCell.h"
#import "TakeOrderQuotePriceDetaiSectionView.h"
#import "OrderTakingQuotePriceDetailTelephoneTableViewCell.h"
#import "OrderTakingQuotePriceDetailTelephoneView.h"


#import "OrderTakingQuotePriceViewController.h"


@interface OrderTakingQuotePriceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIScrollView *baseScrollView;
    TakeOrderQuotePriceDetaiSectionView *sectionView;
    OrderTakingQuotePriceDetailTelephoneView *telephoneSectionView;
    OrderTakingQuotePriceDetailTelephoneView *addressSectionView;
    
    OrderTakingQuotePriceDetailTelephoneView *beiZhuSectionView;
    
    UILabel *tipSectionLabel;
    //
    UIButton *bottomOrderButt;
    
    UIView *bottomButtView;
}

@property (strong,nonatomic) TakeOrderQuotePriceDetailModel *singleModel;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSString *addressStr;

@property (strong,nonatomic) NSString *telephoneStr;

@property (strong,nonatomic) NSString *beiZhuStr;
//我是否被该派单雇佣
@property (assign,nonatomic) BOOL isHiredMe;
//能否确认接单和确认取消接单
@property (assign,nonatomic) BOOL canSureTakeOrder;

@end

@implementation OrderTakingQuotePriceDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
    self.title = @"接单";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initOwnObjects];
    //
     [self addTableView:CGRectMake(0, 0,self.view.width,CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT - 50) style:UITableViewStylePlain];
    [self addBottomButtView];
    
    [self getData];
}

- (void)initOwnObjects{
    self.telephoneStr = @"";
    self.addressStr = @"";
    self.beiZhuStr = @"";
    self.singleModel = [[TakeOrderQuotePriceDetailModel alloc]init];

}
//
- (void)dealOrderSate{
    NSLog(@"!!!!!!!!!self.stateFlag=%ld",self.stateFlag);
    //针对于该派单的而不是当前用户的
    switch (self.stateFlag) {
        case 0://派单中
        {
            [self updateOwnViewDisplayByOrderState:@"" bottomOrderStr:@""];
        }
            break;
        case 1:{//接单人满
            [self updateOwnViewDisplayByOrderState:@"接单人满" bottomOrderStr:@""];
        }
            break;
        case 2:{//已付款
            [self updateOwnViewDisplayByOrderState:@"" bottomOrderStr:@""];
        }
            break;
        case 3:{//已雇佣
            [self updateOwnViewDisplayByOrderState:@"" bottomOrderStr:@"接单"];
        }
            break;
        case 4:{//已退款
            [self updateOwnViewDisplayByOrderState:@"" bottomOrderStr:@""];
        }
            break;
        case 5:{//已接单
             [self updateOwnViewDisplayByOrderState:@"" bottomOrderStr:@""];
        }
            break;
        case 6:{//已完成
            [self updateOwnViewDisplayByOrderState:@"" bottomOrderStr:@""];
        }
            break;
        case 7:{//已取消
            [self updateOwnViewDisplayByOrderState:@"" bottomOrderStr:@""];
        }
            break;
        default:{
            [self updateOwnViewDisplayByOrderState:@"" bottomOrderStr:@""];
        }
            break;
    }
    [self.tableView reloadData];
}

- (void)updateOwnViewDisplayByOrderState:(NSString*)topDisplayStr bottomOrderStr:(NSString*)bottomStr{
   
    //能够确认接单
    if (self.canSureTakeOrder){
        bottomButtView.hidden = NO;
        self.tableView.frame = CGRectMake(0, 0,self.view.width,CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT - bottomButtView.height);
    }else{
        bottomButtView.hidden = YES;
        self.tableView.frame = CGRectMake(0, 0,self.view.width,CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT);
    }
    
    //如果雇主确定已经完成，并且雇佣的是我
    if (self.isHiredMe  && self.stateFlag == 6){
         sectionView.topDisplayLabel.text = @"你已经完成该派单";
        return;
    }
    //如果已经雇佣并且是我
    if (self.isHiredMe){
        sectionView.topDisplayLabel.text = @"恭喜你已被雇主选中";
    }
    
}


- (void)dealTelephone{
    if ([TelephoneNumberTools isMobile:telephoneSectionView.ownRightLabel.text]){
        if (telephoneSectionView.ownRightLabel.text.length){
            NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneSectionView.ownRightLabel.text];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
            [self.view addSubview:callWebview];
        }else{
            [SVProgressHUD showInfoWithStatus:@"手机格式有问题"];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"手机格式有问题"];
    }
}


- (void)getData{

//    "isReceived": true, 当前用户有没有接过该派单
//    "isHiredMe": true, 当前用户(我)有没有被雇佣
//    "mobile": "17096177665",
//    "address": "详细地址",
//    "canReceive": false,//接单列表用到的，能否接单
//    "isHired": true,//针对该派单
//    "hiredName": "李四",
//    "state": "已雇佣",//针对该派单
   
        //msgId:用于接单成功后发过来的通知消息标记已读未读
        //NSInteger orderID = self.orderId
        //order id 写死了1 后期改过来
    
        NSDictionary *paraDict = @{@"orderId":[NSNumber numberWithInteger:self.orderId],@"userId":[lzhGetAccountInfo getAccount].userID,@"msgId":[NSNumber numberWithInteger:1]};
        //WS(weakSelf);
        [TDHttpTools getCasualTakeOrderDetail:paraDict success:^(id response) {
            
            NSDictionary *dict = response;
            NSLog(@"接单详情零工版 dict=%@",dict);
            NSDictionary *dataDict = dict[@"data"];
            NSString *headImageStr = dataDict[@"headImg"];
            if ([headImageStr isKindOfClass:[NSNull class]]){
                self.singleModel.logoUrlStr = @"";
            }else{
                self.singleModel.logoUrlStr = [dataDict[@"headImg"] copy];
            }
            self.singleModel.timeStr = [NSString getResultStrBySeverStr:dataDict[@"createTime"]] ;
            self.singleModel.praiseStr = [NSString getResultStrBySeverStr:dataDict[@"budget"]];
            self.singleModel.personNameStr = [NSString getResultStrBySeverStr:dataDict[@"userName"]];
            self.singleModel.detailStr = [NSString getResultStrBySeverStr:dataDict[@"remark"]];
            NSNumber *receviceNum = [NSNumber getResultNumberBySeverStr:dataDict[@"receiveNum"]];
            self.singleModel.ticketsNumberStr =[receviceNum stringValue];
            self.addressStr =  [NSString getResultStrBySeverStr:dataDict[@"address"]];
            self.telephoneStr = [NSString getResultStrBySeverStr:dataDict[@"mobile"]];
            self.beiZhuStr = [NSString getResultStrBySeverStr:dataDict[@"remark"]];
            self.isHiredMe = [dataDict[@"isHiredMe"] boolValue];
            self.canSureTakeOrder = [[NSNumber getResultNumberBySeverStr:dataDict[@"canEnter"]] boolValue];
            [self dealOrderSate];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
        }];
}
//确认接单
- (void)takeOrderClick{
    NSLog(@"接单");
    
    [TDHttpTools CasualSureTakeOrder:@{@"userId":[lzhGetAccountInfo getAccount].userID,@"orderId":[NSNumber numberWithInteger:self.orderId]} success:^(id response) {
        [SVProgressHUD showSuccessWithStatus:response[@"msg"]];
        if (self.refreshDataAfterTakeOrderBlock){
            self.refreshDataAfterTakeOrderBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}
//放弃接单
- (void)giveHandler{
    [TDHttpTools casualCancelTakeOrder:@{@"userId":[lzhGetAccountInfo getAccount].userID,@"orderId":[NSNumber numberWithInteger:self.orderId]} success:^(id response) {
        [SVProgressHUD showSuccessWithStatus:response[@"msg"]];
        if (self.refreshDataAfterTakeOrderBlock){
            self.refreshDataAfterTakeOrderBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}


//views
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    UIImage *backImage = [UIImage imageNamed:@"quotePriceDetailBack"];
    CGFloat imageDisplayHeight = self.view.width / (backImage.size.width / backImage.size.height);
    WS(weakSelf);
    //
    sectionView = [[TakeOrderQuotePriceDetaiSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, imageDisplayHeight + 30) backImageHeight:imageDisplayHeight image:backImage];
    sectionView.topDisplayLabel.text = @"";
    sectionView.botDisplayLabel.text = @"雇主联系方式";
    //
    tipSectionLabel = [[CustomeLzhLabel alloc]initWithCustomerParamer:[UIFont getPingFangSCMedium:13] titleColor:[UIColor whiteColor] aligement:1];
    tipSectionLabel.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    tipSectionLabel.text = @"提醒：放弃或超8小时接单将自动接受平台惩罚";
    tipSectionLabel.frame = CGRectMake(0, 0, self.view.width, 40);
    //
    telephoneSectionView = [[OrderTakingQuotePriceDetailTelephoneView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) isNeedRightButt:YES];
    telephoneSectionView.ownLeftLabel.text =@"电话：";
    telephoneSectionView.clickTelephoneBlock = ^{
        [weakSelf dealTelephone];
    };
    [telephoneSectionView.telephoneButt setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
    //
    addressSectionView = [[OrderTakingQuotePriceDetailTelephoneView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) isNeedRightButt:YES];
    addressSectionView.ownLeftLabel.text =@"地址：";
    [addressSectionView.telephoneButt setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    //
    beiZhuSectionView = [[OrderTakingQuotePriceDetailTelephoneView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) isNeedRightButt:NO];
    beiZhuSectionView.ownLeftLabel.text =@"备注：";
    //
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)addBottomButtView{
     bottomButtView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - StatusBarAndNavigationBarHeight  - 50, self.view.width, 50)];
    //默认隐藏
    bottomButtView.hidden = YES;
    [self.view addSubview:bottomButtView];
    //
    UIButton *giveButt = [UIButton buttonWithType:UIButtonTypeCustom];
    giveButt.backgroundColor = [UIColor whiteColor];
    giveButt.frame = CGRectMake(0, 0, bottomButtView.width / 2, bottomButtView.height);
    giveButt.titleLabel.font = [UIFont getPingFangSCMedium:16];
    [giveButt setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [giveButt addTarget:self action:@selector(giveHandler) forControlEvents:UIControlEventTouchUpInside];
    [giveButt setTitle:@"放弃" forState:UIControlStateNormal];
    
    [bottomButtView addSubview:giveButt];
    //
    UIView *buttLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, giveButt.width, 1)];
    buttLine.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    [giveButt addSubview:buttLine];
    //
    UIButton *orderButt = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomOrderButt = orderButt;
    orderButt.backgroundColor = [UIColor colorWithHexString:@"#FF7E00"];
    orderButt.frame = CGRectMake(giveButt.right, giveButt.top, bottomButtView.width / 2, giveButt.height);
    orderButt.titleLabel.font = [UIFont getPingFangSCMedium:16];
    [orderButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderButt addTarget:self action:@selector(takeOrderClick) forControlEvents:UIControlEventTouchUpInside];
    [orderButt setTitle:@"接单" forState:UIControlStateNormal];
    [bottomButtView addSubview:orderButt];
    
    //
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            rows = 0;
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
    }
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    
    if (indexPath.section == 0){
        TakeOrderQuotePriceDetailModel *model = self.singleModel;
        height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderTakingQuotePriceDetailTableViewCell class] contentViewWidth:SCREEN_WIDTH];
        NSLog(@"!!!!!!!!!HEIGHT=%lf",height);
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    switch (section) {
        case 0:
            break;
        case 1:
            view = sectionView;
            break;
        case 2:
            telephoneSectionView.ownRightLabel.text = self.telephoneStr;
            if(self.isHiredMe){
                telephoneSectionView.telephoneButt.hidden = NO;
            }else{
                telephoneSectionView.telephoneButt.hidden = YES;
            }
            view = telephoneSectionView;
            break;
        case 3:
            addressSectionView.telephoneButt.hidden = YES;
            addressSectionView.ownRightLabel.text = self.addressStr;
            view = addressSectionView;
            break;
        case 4:
            beiZhuSectionView.ownRightLabel.text = self.beiZhuStr;
            
            view = beiZhuSectionView;
            break;
        case 5:
            tipSectionLabel.text = @"提醒：放弃或超8小时接单将自动接受平台惩罚";
            view = tipSectionLabel;
            break;
        default:
            break;
    }
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    switch (section) {
        case 0:
            break;
        case 1:
            height = sectionView.height;
            break;
        case 2:
            height = telephoneSectionView.height;
            break;
        case 3:
            [addressSectionView adjustOwnDisplay:self.addressStr];
            height = addressSectionView.height;
            break;
        case 4:
             [beiZhuSectionView adjustOwnDisplay:self.beiZhuStr];
            height = beiZhuSectionView.height;
            break;
        case 5:
            height = tipSectionLabel.height;
            break;
        default:
            break;
    }
    return height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
