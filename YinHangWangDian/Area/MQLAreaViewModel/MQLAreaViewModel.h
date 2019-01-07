//
//  MQLAreaViewModel.h
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/3.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQLAreaViewModel : NSObject

@property (nonatomic, strong) NSDictionary *dic;

@property (nonatomic, strong) MQLAreaDataModel *dataModel;

//发送请求
- (NSURLSessionDataTask *)getOfAreaListSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
-(CGSize)sizeForItem;

@end

NS_ASSUME_NONNULL_END
