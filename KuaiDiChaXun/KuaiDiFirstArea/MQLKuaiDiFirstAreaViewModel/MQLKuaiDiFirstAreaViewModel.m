//
//  MQLKuaiDiFirstAreaViewModel.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/7.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLKuaiDiFirstAreaViewModel.h"

@implementation MQLKuaiDiFirstAreaViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLKuaiDiFirstAreaDataModel new];
    }
    return self;
}

//发送请求
- (NSURLSessionDataTask *)getKuaiDiFirstAreaListSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString *urlString = self.dic[@"href"];
    
    return [JRNetworkingSingleton GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

-(CGSize)sizeForItem{
    return CGSizeMake((kScreenWidth - 10.0 * 3) / 2, 50.0);
}

@end
