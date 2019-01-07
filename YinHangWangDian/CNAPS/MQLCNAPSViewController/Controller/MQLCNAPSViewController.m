//
//  MQLCNAPSViewController.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/4.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLCNAPSViewController.h"

@interface MQLCNAPSViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintOfNavContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfLowestView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSString *cellIdentifier;

@property (nonatomic, strong) NSMutableArray *filterArray;

@end

@implementation MQLCNAPSViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewModel = [MQLCNAPSViewModel new];
        _filterArray = [NSMutableArray array];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self generalInit];
}

-(void)generalInit{
    self.heightConstraintOfNavContainerView.constant = navigationBarHeight() + kStatusBarHeight;
    self.bottomConstraintOfLowestView.constant = bottomSafeAreaHeight();
    
    //add layout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10.0;
    layout.minimumLineSpacing = 10.0;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView.collectionViewLayout = layout;
    
    self.cellIdentifier = @"MQLCNAPSCollectionViewCell";
    UINib *cellNib = [UINib nibWithNibName:self.cellIdentifier bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:self.cellIdentifier];
    
    //添加刷新头
    [self addMJRefreshNormalHeader];
}

- (void)addMJRefreshNormalHeader
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //发送请求
        [weakSelf getOfCNAPSList];
    }];
    
    // 设置文字
    [header setTitle:MJRefreshStateIdleString forState:MJRefreshStateIdle];
    [header setTitle:MJRefreshStatePullingString forState:MJRefreshStatePulling];
    [header setTitle:MJRefreshStateRefreshingString forState:MJRefreshStateRefreshing];
    
    //隐藏时间标签
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    self.collectionView.mj_header = header;
    [self.collectionView.mj_header beginRefreshing];
}

- (IBAction)searchBtnClicked:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入关键字，点击确认去🔍" preferredStyle:UIAlertControllerStyleAlert];
    
    //在AlertView中添加一个输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入关键字";
    }];
    
    //添加一个确定按钮来获取AlertView中的第一个输入框
    __weak typeof(self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
        NSString *keyText = envirnmentNameTextField.text;
        
        [weakSelf.filterArray removeAllObjects];
        for (NSDictionary *dic in weakSelf.viewModel.dataModel.cnapsArray) {
            NSString *name = dic[@"name"];
            NSString *aps = dic[@"aps"];
            NSString *add = dic[@"add"];
            
            if ([name containsString:keyText] || [aps containsString:keyText] || [add containsString:keyText]) {
                [weakSelf.filterArray addObject:dic];
            }
        }
        
        [weakSelf.collectionView reloadData];
        
    }]];
    
    //添加一个取消按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //present出AlertView
    [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getOfCNAPSList{
    __weak typeof(self) weakSelf = self;
    [self.viewModel getOfCNAPSListSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [weakSelf.collectionView.mj_header endRefreshing];
        
        //先清除
        [self.viewModel.dataModel.cnapsArray removeAllObjects];
        [self.filterArray removeAllObjects];
        
        //再新增
        TFHpple *doc = [[TFHpple alloc]initWithHTMLData:responseObject];
        NSArray *elements = [doc searchWithXPathQuery:@"//li"];
        for (int i = 0; i < elements.count; i++) {
            TFHppleElement *e = elements[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            NSArray *subelements = [e childrenWithTagName:@"span"];
            TFHppleElement *e0 = subelements[0];
            TFHppleElement *e1 = subelements[1];
            TFHppleElement *e2 = subelements[2];

            if (i != 0) {
                [dic setObject:(e0.text == nil ? @"" : e0.text) forKey:@"name"];
                [dic setObject:e1.firstChild.text forKey:@"aps"];
                [dic setObject:(e2.text == nil ? @"" : e2.text)  forKey:@"add"];
                
                [weakSelf.viewModel.dataModel.cnapsArray addObject:dic];
            }
        }
        
        [weakSelf.filterArray addObjectsFromArray:weakSelf.viewModel.dataModel.cnapsArray];
        [weakSelf.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
}

//MARK:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.filterArray.count;;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MQLCNAPSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.dic = self.filterArray[indexPath.item];
    NSLog(@"%zd, %zd", indexPath.row, indexPath.item);
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.viewModel sizeForItem];
}

@end
