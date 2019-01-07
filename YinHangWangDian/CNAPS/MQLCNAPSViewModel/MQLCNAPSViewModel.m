//
//  MQLCNAPSViewModel.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/4.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLCNAPSViewModel.h"

@implementation MQLCNAPSViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLCNAPSDataModel new];
    }
    return self;
}

//发送请求
- (NSURLSessionDataTask *)getOfCNAPSListSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    NSString *urlString = self.dic[@"href"];
    
    return [JRNetworkingSingleton GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

-(CGSize)sizeForItem{
    return CGSizeMake(kScreenWidth - 10.0 * 2, 130.0);
}

@end
