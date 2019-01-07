//
//  MQLAreaDataModel.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/3.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLAreaDataModel.h"

@implementation MQLAreaDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _areas = [NSMutableArray array];
    }
    return self;
}

@end
