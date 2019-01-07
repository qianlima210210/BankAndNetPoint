//
//  MQLCNAPSDataModel.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/4.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLCNAPSDataModel.h"

@implementation MQLCNAPSDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cnapsArray = [NSMutableArray array];
    }
    return self;
}

@end
