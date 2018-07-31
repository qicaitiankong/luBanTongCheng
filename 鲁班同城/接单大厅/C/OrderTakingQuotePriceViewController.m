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

@interface OrderTakingQuotePriceViewController ()<UITableViewDelegate,UITableViewDataSource>{
    TakeOrderQuotePriceSectionView *sectionView;
}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *modelArr;

@property (strong,nonatomic) TakeOrderQuotePriceModel *singleModel;

@property (strong,nonatomic) UITextField *moneyField;

@property (strong,nonatomic) UITextView *beiZhuTextView;


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
    self.title = @"报价";
    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self initOwnObjects];
    //
    [self addTableView:CGRectMake(0, 0,self.view.width,CENTER_VIEW_HEIGHT + TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    //
    [self getData];
}

- (void)initOwnObjects{
    self.modelArr = [[NSMutableArray alloc]init];
    self.singleModel = [[TakeOrderQuotePriceModel alloc] init];
    self.singleModel.imageUrls = [[NSMutableArray alloc]init];
}

- (void)getData{
    
        //msgId:用于接单成功后发过来的通知消息标记已读未读
        //NSInteger orderID = [self.orderIdStr integerValue];
        //order id 写死了1 后期改过来
        NSDictionary *paraDict = @{@"orderId":[NSNumber numberWithInteger:1],@"userId":[lzhGetAccountInfo getAccount].userID,@"msgId":[NSNumber numberWithInteger:1]};
        [TDHttpTools getCasualTakeOrderDetail:paraDict success:^(id response) {
            NSDictionary *dict = response;
            NSLog(@"接单详情零工版 dict=%@",dict);
            NSDictionary *dataDict = dict[@"data"];
            
            if ([dataDict[@"createTime"] isKindOfClass:[NSString class]]){
                NSLog(@"!!!!!!!!!!!createTime为NSString");
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
    NSDictionary *paraDict = @{@"userId":[lzhGetAccountInfo getAccount].userID,@"orderId":[NSNumber numberWithInteger:self.orderId],@"price":[NSNumber numberWithInteger:[moneyStr integerValue]],@"remark":beiZhuStr};
    [TDHttpTools CasualTakeOrder:paraDict success:^(id response) {
        NSDictionary *webDict = response;
        NSLog(@"webDict:%@",webDict);
    } failure:^(NSError *error) {
        
    }];
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
            parentCell =  [tableView dequeueReusableCellWithIdentifier:cellFlag];
            if (nil == parentCell){
                if (self.isBapJiaDetail){//报价详情
                    
                    TakeOrderQuotePriceSecondUseTableViewCell *cell = [[TakeOrderQuotePriceSecondUseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
                    cell.model = self.singleModel;
                    parentCell = cell;
                }else{//报价
                    WS(weakSelf);
                    TakeOrderQuotePriceTableViewCell *cell = [[TakeOrderQuotePriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
                    //指定控件
                    weakSelf.moneyField = cell.bottomGroupView.moneyTextfield.myTextField;
                    weakSelf.beiZhuTextView = cell.bottomGroupView.beiZhuTextView.writeTextView;
                    cell.bottomGroupView.takeOrderButt.clickButtBlock = ^{
                        [weakSelf takeOrderHandler];
                        };
                    cell.model = self.singleModel;
                    parentCell = cell;
                }
                
            }
        
    }else{
        static NSString *cellFlag = @"cellFlag02";
        TakeOrderQuotePriceQiangBiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
        if (nil == cell){
            cell = [[TakeOrderQuotePriceQiangBiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag cellHeight:SCREEN_HEIGHT * 0.12];
        }
        cell.model = self.modelArr[indexPath.row];
        parentCell = cell;
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
