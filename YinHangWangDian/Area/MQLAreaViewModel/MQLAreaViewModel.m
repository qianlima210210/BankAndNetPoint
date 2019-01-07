//
//  MQLAreaViewModel.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/3.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLAreaViewModel.h"

@implementation MQLAreaViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLAreaDataModel new];
    }
    return self;
}

//发送请求
- (NSURLSessionDataTask *)getOfAreaListSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
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
