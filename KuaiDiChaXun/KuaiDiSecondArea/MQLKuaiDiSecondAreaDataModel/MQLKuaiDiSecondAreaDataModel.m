//
//  MQLKuaiDiSecondAreaDataModel.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/7.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLKuaiDiSecondAreaDataModel.h"

@implementation MQLKuaiDiSecondAreaDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _secondAreaList = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

@end
