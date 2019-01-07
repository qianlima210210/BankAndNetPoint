//
//  MQLRootDataModel.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/3.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLRootDataModel.h"

@implementation MQLRootDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _banks = [NSMutableArray array];
    }
    return self;
}

@end
