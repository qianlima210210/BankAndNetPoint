//
//  MQLKuaiDiShangJiaViewModel.h
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/6.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQLKuaiDiShangJiaViewModel : NSObject

@property (nonatomic, strong) MQLKuaiDiShangJiaDataModel *dataModel;

//发送请求
- (NSURLSessionDataTask *)getKuaiDiShangJiaListSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


-(CGSize)sizeForItem;

@end

NS_ASSUME_NONNULL_END
