//
//  MQLAreaViewController.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/3.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLAreaViewController.h"

@interface MQLAreaViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintOfNavContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfLowestView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) NSString *supplementaryHeaderId;


@end

@implementation MQLAreaViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewModel = [MQLAreaViewModel new];
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
    
    self.titleLab.text = [NSString stringWithFormat:@"%@-%@", self.viewModel.dic[@"title"], @"选择地区"];
    
    //add layout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10.0;
    layout.minimumLineSpacing = 10.0;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView.collectionViewLayout = layout;
    
    self.cellIdentifier = @"MQLSecondAreaCollectionViewCell";
    UINib *cellNib = [UINib nibWithNibName:self.cellIdentifier bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:self.cellIdentifier];
    
    self.supplementaryHeaderId = @"MQLFirstAreaHeaderView";
    UINib *aupplementnib = [UINib nibWithNibName:self.supplementaryHeaderId bundle:nil];
    [self.collectionView registerNib:aupplementnib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.supplementaryHeaderId];
    
    //添加刷新头
    [self addMJRefreshNormalHeader];
}

- (void)addMJRefreshNormalHeader
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //发送请求
        [weakSelf getOfAreaList];
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

-(void)getOfAreaList{
    __weak typeof(self) weakSelf = self;
    [self.viewModel getOfAreaListSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [weakSelf.collectionView.mj_header endRefreshing];
        
        //先清除
        [weakSelf.viewModel.dataModel.areas removeAllObjects];
        
        //再新增
        TFHpple *doc = [[TFHpple alloc]initWithHTMLData:responseObject];
        NSMutableArray *array0 = [NSMutableArray array];
        NSArray *elements = [doc searchWithXPathQuery:@"//h2"];
        for (TFHppleElement *e in elements) {
            [array0 addObject:e.text];
        }

        elements = [doc searchWithXPathQuery:@"//ul"];
        for (int i = 0; i < array0.count; i++) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:array0[i] forKey:@"title"];
            
            TFHppleElement *e = elements[i];
            NSArray *subelements = [e childrenWithTagName:@"a"];
            NSMutableArray *temp = [NSMutableArray array];
            for (TFHppleElement *e in subelements){
                NSString *href = e.attributes[@"href"];
                NSString *title = e.text;
                [temp addObject:[NSDictionary dictionaryWithObjectsAndKeys:href, @"href", title, @"title", nil]];
            }
            [dic setObject:temp forKey:@"list"];
            [weakSelf.viewModel.dataModel.areas addObject:dic];
        }
        
        [weakSelf.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
}


- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.viewModel.dataModel.areas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary *dic = self.viewModel.dataModel.areas[section];
    NSArray *array = dic[@"list"];
    return array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MQLSecondAreaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    NSArray *array = self.viewModel.dataModel.areas[indexPath.section][@"list"];
    cell.dic = [array objectAtIndex:indexPath.item];
    
    __weak typeof(self) weakSelf = self;
    cell.callBack = ^(NSDictionary *dic){
        NSLog(@"%@", dic);
        MQLCNAPSViewController *vc = [[MQLCNAPSViewController alloc]initWithNibName:@"MQLCNAPSViewController" bundle:nil];
        vc.viewModel.dic = dic;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.viewModel sizeForItem];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){kScreenWidth, 44};
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        MQLFirstAreaHeaderView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:self.supplementaryHeaderId forIndexPath:indexPath];
        headerView.title = self.viewModel.dataModel.areas[indexPath.section][@"title"];
        
        return headerView;
    }
    
    
    return nil;
}



@end
