//
//  MQLRootViewModel.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/3.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLRootViewModel.h"

@implementation MQLRootViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLRootDataModel new];
    }
    return self;
}

//发送请求
- (NSURLSessionDataTask *)getOfBankListSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    NSString *urlString = @"http://tui78.com/bank";
    
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
