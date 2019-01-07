//
//  MQLRootViewController.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/3.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLRootViewController.h"

@interface MQLRootViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintOfNavContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfLowestView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSString *identifier;

@end

@implementation MQLRootViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewModel = [MQLRootViewModel new];
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
    self.collectionView.collectionViewLayout = layout;
    
    self.identifier = @"MQLBankCollectionViewCell";
    UINib *nib = [UINib nibWithNibName:self.identifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:self.identifier];
    
    //添加刷新头
    [self addMJRefreshNormalHeader];
}

- (void)addMJRefreshNormalHeader
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //发送请求
        [weakSelf getOfBankList];
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

-(void)getOfBankList{
    __weak typeof(self) weakSelf = self;
    [self.viewModel getOfBankListSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [weakSelf.collectionView.mj_header endRefreshing];
        
        //先清除
        [weakSelf.viewModel.dataModel.banks removeAllObjects];
        
        //再新增
        TFHpple *doc = [[TFHpple alloc]initWithHTMLData:responseObject];
        NSArray *elements = [doc searchWithXPathQuery:@"//li"];
        for (TFHppleElement *e in elements) {
            NSArray *childrens = e.children;
            for (TFHppleElement *e in childrens) {
                NSArray *childrens = e.children;
                for (TFHppleElement *e in childrens) {
                    [weakSelf.viewModel.dataModel.banks addObject:e.attributes];
                }
            }
        }
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        NSLog(@"%@", error);
    }];
}

//MARK:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModel.dataModel.banks.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MQLBankCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    
    cell.dic = [self.viewModel.dataModel.banks objectAtIndex:indexPath.item];
    __weak typeof(self) weakSelf = self;
    cell.callBack = ^(NSDictionary *dic){
        NSLog(@"%@", dic);
        MQLAreaViewController *vc = [[MQLAreaViewController alloc]initWithNibName:@"MQLAreaViewController" bundle:nil];
        vc.viewModel.dic = dic;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.viewModel sizeForItem];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
