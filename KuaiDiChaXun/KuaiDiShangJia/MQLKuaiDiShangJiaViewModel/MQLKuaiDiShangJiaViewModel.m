//
//  MQLKuaiDiShangJiaViewModel.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/6.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLKuaiDiShangJiaViewModel.h"

@implementation MQLKuaiDiShangJiaViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLKuaiDiShangJiaDataModel new];
    }
    return self;
}

//发送请求
- (NSURLSessionDataTask *)getKuaiDiShangJiaListSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString *urlString = @"http://www.tui78.com/kuaidi";
    
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
