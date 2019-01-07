//
//  MQLBankCollectionViewCell.h
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/3.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQLBankCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) void (^callBack)(NSDictionary *dic);

//href = "http://www.tui78.com/bank/14772.html";
//title = "\U5de5\U5546\U94f6\U884c";
@property (nonatomic, strong) NSDictionary *dic;

@end

NS_ASSUME_NONNULL_END
