//
//  MQLKuaiDiSecondAreaViewController.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/7.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLKuaiDiSecondAreaViewController.h"

@interface MQLKuaiDiSecondAreaViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *heightContraintOfNavContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfLowestView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSString *identifier;

@end

@implementation MQLKuaiDiSecondAreaViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewModel = [MQLKuaiDiSecondAreaViewModel new];
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
    self.heightContraintOfNavContainerView.constant = navigationBarHeight() + kStatusBarHeight;
    self.bottomConstraintOfLowestView.constant = bottomSafeAreaHeight();
    
    //add layout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10.0;
    layout.minimumLineSpacing = 10.0;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView.collectionViewLayout = layout;
    
    self.identifier = @"MQLKuaiDiSecondAreaCollectionViewCell";
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
        [weakSelf getKuaiDiSecondAreaList];
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

-(void)getKuaiDiSecondAreaList{
    __weak typeof(self) weakSelf = self;
    [self.viewModel getKuaiDiSecondAreaListSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [weakSelf.collectionView.mj_header endRefreshing];
        
        //先清除
        [weakSelf.viewModel.dataModel.secondAreaList removeAllObjects];
        
        //再新增
        TFHpple *doc = [[TFHpple alloc]initWithHTMLData:responseObject];
        NSArray *elements = [doc searchWithXPathQuery:@"//ul"];
        for (int i = 0; i < elements.count; i++) {
            TFHppleElement *e = elements[i];
            NSArray *subelements = [e childrenWithTagName:@"li"];
            for (TFHppleElement *e in subelements) {
                NSArray *subsubelements = [e childrenWithTagName:@"a"];
                if (subsubelements.count == 2) {
                    TFHppleElement *e0 = subsubelements[0];
                    TFHppleElement *e1 = subsubelements[1];
                    
                    NSString *title = [NSString stringWithFormat:@"[%@]%@", e0.text, e1.text];
                    NSString *href = e1.attributes[@"href"];
                    
                    NSDictionary *dic = @{@"title":title, @"href":href};
                    [weakSelf.viewModel.dataModel.secondAreaList addObject:dic];
                }
            }
        }
        [weakSelf.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        NSLog(@"%@", error);
    }];
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModel.dataModel.secondAreaList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MQLKuaiDiSecondAreaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    
    cell.dic = [self.viewModel.dataModel.secondAreaList objectAtIndex:indexPath.item];
    __weak typeof(self) weakSelf = self;
    cell.callBack = ^(NSDictionary *dic){
        NSLog(@"%@", dic);
        MQLKuaiDiChaXunFinalViewController *vc = [[MQLKuaiDiChaXunFinalViewController alloc]initWithNibName:@"MQLKuaiDiChaXunFinalViewController" bundle:nil];
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
