//
//  MQLKuaiDiChaXunFinalViewModel.h
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/7.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQLKuaiDiChaXunFinalViewModel : NSObject

@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) MQLKuaiDiChaXunFinalDataModel *dataModel;

//发送请求
- (NSURLSessionDataTask *)getKuaiDiDetailSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(CGSize)sizeForItem;


@end

NS_ASSUME_NONNULL_END
