//
//  OrderTakingQuotePriceViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OrderTakingQuotePriceViewController.h"
#import "TakeOrderQuotePriceTableViewCell.h"
#import "TakeOrderQuotePriceSecondUseTableViewCell.h"
#import "TakeOrderQuotePriceQiangBiaoTableViewCell.h"
#import "TakeOrderQuotePriceSectionView.h"
#import "CommitPopView.h"

@interface OrderTakingQuotePriceViewController ()<UITableViewDelegate,UITableViewDataSource,AVAudioRecorderDelegate,AVAudioPlayerDelegate>{
    TakeOrderQuotePriceSectionView *sectionView;
    //
    CommitPopView *popView;
    UIButton *popbackButt;
    RecordAndPlaySound *dealRecordPlaySound;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@property (strong,nonatomic) TakeOrderQuotePriceModel *singleModel;

@property (strong,nonatomic) UITextField *moneyField;

@property (strong,nonatomic) UITextView *beiZhuTextView;

//录制的语音信息
@property (strong,nonatomic) NSData *amrData;

@property (strong,nonatomic) NSData *wavData;

@property (assign,nonatomic) float soundTimes;
//获得报价cell所有权
@property (strong,nonatomic) TakeOrderQuotePriceTableViewCell *baoJiaCell;
//
@end

@implementation OrderTakingQuotePriceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [NavTools hiddenTabbar:self.rdv_tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [NavTools hiddenTabbar:self.rdv_tabBarController];
    //
    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self initOwnObjects];
    //
    [self addTableView:CGRectMake(0, 0,self.view.width,CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    //
    [self getData];
}

- (void)initOwnObjects{
    if(self.isBapJiaDetail){
        self.title = @"详情";
    }else{
        self.title = @"报价";
    }
    //初始化语音对象
    dealRecordPlaySound = [[RecordAndPlaySound alloc]init:self plyerDelegate:self];
    self.modelArr = [[NSMutableArray alloc]init];
    self.singleModel = [[TakeOrderQuotePriceModel alloc] init];
    self.singleModel.imageUrls = [[NSMutableArray alloc]init];
}

- (void)getData{
    
        //msgId:用于接单成功后发过来的通知消息标记已读未读
        //NSInteger orderID = [self.orderIdStr integerValue];
        //order id 写死了1 后期改过来
        NSDictionary *paraDict = @{@"orderId":[NSNumber numberWithInteger:self.orderId],@"msgId":[NSNumber numberWithInteger:1]};
        [TDHttpTools getCasualTakeOrderDetail:paraDict success:^(id response) {
            NSDictionary *dict = response;
            
            NSLog(@"接单详情零工版 dict=%@",dict);
            NSDictionary *dataDict = dict[@"data"];
            NSString *reasonStr = [NSString getResultStrBySeverStr: dataDict[@"reason"]];
            if (reasonStr.length){
                [self showPopView:reasonStr];
            }
            self.singleModel.logoUrlStr = [NSString getResultStrBySeverStr:dataDict[@"headImg"]];
            self.singleModel.timeStr = [NSString getResultStrBySeverStr:dataDict[@"createTime"]] ;
            self.singleModel.praiseStr = [NSString getResultStrBySeverStr:dataDict[@"budget"]];
            self.singleModel.personNameStr = [NSString getResultStrBySeverStr:dataDict[@"userName"]];
            self.singleModel.detailStr = [NSString getResultStrBySeverStr:dataDict[@"remark"]];
            NSNumber *receviceNum = [NSNumber getResultNumberBySeverStr:dataDict[@"receiveNum"]];
            self.singleModel.ticketsNumberStr =[receviceNum stringValue];
            //
            NSLog(@"createTime:%@",dataDict[@"createTime"]);
            //
            for(int k = 0; k < 3; k ++){
                [self.singleModel.imageUrls addObject:@"https://image.baidu.com/search/detail?"];
            }
            
            NSArray *qiangBiaoArr = dataDict[@"list"];
            for (NSDictionary *localDict in qiangBiaoArr){
                TakeOrderQuotePriceModel *localModel = [TakeOrderQuotePriceModel setModelFromDict:localDict];
                [self.modelArr addObject:localModel];
            }
            //
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
}


- (void)takeOrderHandler{
    NSString *moneyStr = [NSString getResultStrBySeverStr: self.moneyField.text];
    NSString *beiZhuStr = [NSString getResultStrBySeverStr: self.beiZhuTextView.text];
    
    if (moneyStr.length <= 0){
        [SVProgressHUD showInfoWithStatus:@"请输入金额"];
        return;
    }else{
        BOOL isZhengShu = [NSString isPureInt:moneyStr];
        if (isZhengShu){
        }else{
            [SVProgressHUD showInfoWithStatus:@"请输入整数金额"];
            return;
        }
    }
    
    NSDictionary *paraDict = @{@"orderId":[NSNumber numberWithInteger:self.orderId],@"price":[NSNumber numberWithInteger:[moneyStr integerValue]],@"voiceLength":[NSString stringWithFormat:@"%lf",self.soundTimes]};
    
    [TDHttpTools CasualScramebleTakeOrder:paraDict voiceFile:self.amrData success:^(id response) {
        NSDictionary *webDict = response;
        NSLog(@"webDict:%@",webDict);
        [SVProgressHUD showSuccessWithStatus:webDict[@"msg"]];
        //回到列零工列表刷新界面
        if (self.refreshDataAfterTakeOrderBlock){
            self.refreshDataAfterTakeOrderBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

//添加语音
- (void)clickAddSound:(PersonalInfoAddSoundButtView*)soundView{
    NSLog(@"添加语音");
    if (self.wavData == nil){
        NSLog(@"没有语音");
        [self->dealRecordPlaySound startRecord];
        //录制语音弹窗
        [LuZhiYuYinPop showPopView:^{//暂时没有做取消块
            
        } completeBlock:^{
            [LuZhiYuYinPop dismissPopView];
            [self->dealRecordPlaySound endRecord];
            self.wavData = [self->dealRecordPlaySound.WavsoundData copy];
            self.soundTimes = self->dealRecordPlaySound.recordTime;
            self.amrData = [self->dealRecordPlaySound.amrSoundData copy];
            [soundView changeToPlaySoundState];
            
            //NSLog(@"录制完成后的语音文件%@",self.amendingInfoModel.workExperienceData);
        }];
    }else{
        NSLog(@"有语音");
        [dealRecordPlaySound playSound:self.wavData];
        [BoFangYuYinOwnPop showPopView:self.soundTimes deleteBlock:^{//删除点击
            [BoFangYuYinOwnPop dismissPopView];
            [self -> dealRecordPlaySound stopPlay];
            self.amrData = nil;
            self.wavData = nil;
            self.soundTimes = 0;
            [soundView changeToAddSoundState];
        } completeBlock:^{//完成点击
            [self->dealRecordPlaySound stopPlay];
            [BoFangYuYinOwnPop dismissPopView];
            [soundView changeToPlaySoundState];
        }];
    }
}



//views
- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles{
    //
    sectionView = [[TakeOrderQuotePriceSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    sectionView.tipLabel.text = @"抢标列表";
    //
    self.tableView = [[UITableView alloc] initWithFrame:size style:styles];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    if (section == 0){
        rows = 1;
    }else{
        rows = self.modelArr.count;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *parentCell = nil;
    if (indexPath.section == 0){
        static NSString *cellFlag = @"cellFlag";
                if (self.isBapJiaDetail){//报价详情
                    TakeOrderQuotePriceSecondUseTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
                    if (nil == firstCell){
                        firstCell = [[TakeOrderQuotePriceSecondUseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
                    }
                    firstCell.model = self.singleModel;
                    parentCell = firstCell;
                }else{//报价
                    WS(weakSelf);
                    TakeOrderQuotePriceTableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
                    if (nil == secondCell){
                        secondCell = [[TakeOrderQuotePriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
                        self.baoJiaCell = secondCell;
                        //指定控件
                        weakSelf.moneyField = secondCell.bottomGroupView.moneyTextfield.myTextField;
                        weakSelf.beiZhuTextView = secondCell.bottomGroupView.beiZhuTextView.writeTextView;
                    secondCell.bottomGroupView.addSoundView.addSoundClickBlock = ^{
                            [weakSelf clickAddSound:  weakSelf.baoJiaCell.bottomGroupView.addSoundView];
                        }; secondCell.bottomGroupView.takeOrderButt.clickButtBlock = ^{
                            [weakSelf takeOrderHandler];
                        };
                    }
                    
                    secondCell.model = self.singleModel;
                    parentCell = secondCell;
                }
        
    }else{
        static NSString *cellFlag = @"cellFlag02";
        TakeOrderQuotePriceQiangBiaoTableViewCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == thirdCell){
            thirdCell = [[TakeOrderQuotePriceQiangBiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag cellHeight:SCREEN_HEIGHT * 0.12];
        }
        thirdCell.model = self.modelArr[indexPath.row];
        parentCell = thirdCell;
    }
    return parentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (indexPath.section == 0){
        TakeOrderQuotePriceModel *model = self.singleModel;
        if (self.isBapJiaDetail){
             height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[TakeOrderQuotePriceSecondUseTableViewCell class] contentViewWidth:SCREEN_WIDTH];
        }else{
             height = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[TakeOrderQuotePriceTableViewCell class] contentViewWidth:SCREEN_WIDTH];
        }
      
    }else{
        height = SCREEN_HEIGHT * 0.12;
    }
   
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return nil;
    }else{
        return sectionView;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0;
    }else{
        return sectionView.height;
    }
}
//

//弹窗
- (void)showPopView:(NSString*)messageStr{
    UIWindow *appWindow = APP_MAIN_WINDOW;
    if (nil == popView){
        popbackButt = [UIButton buttonWithType:UIButtonTypeCustom];
        popbackButt.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        popbackButt.backgroundColor = [UIColor grayColor];
        popbackButt.alpha = POP_VIEW_ALPHA;
        //[popbackButt addTarget:self action:@selector(popBackButtHandler) forControlEvents:UIControlEventTouchUpInside];
        [appWindow addSubview:popbackButt];
        popView = [[CommitPopView alloc]initWithFrame:CGRectMake(0, 0, 194, 223)];
        popView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT  / 2);
        [appWindow addSubview:popView];
        WS(weakSelf);
        popView.sureBlock = ^{
            __strong typeof(weakSelf)sself = weakSelf;
            [sself -> popbackButt setHidden:YES];
            [sself -> popView setHidden:YES];
        };
    }else{
        [popbackButt setHidden:NO];
        [popView setHidden:NO];
    }
     popView.tipLabel.text = messageStr;
}

//
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
