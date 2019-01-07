//
//  MQLBankCollectionViewCell.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/3.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLBankCollectionViewCell.h"

@interface MQLBankCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *bank;

@end

@implementation MQLBankCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self generalInit];
}

-(void)generalInit{
    [self.bank addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bank.layer.borderColor = UIColor.cyanColor.CGColor;
    self.bank.layer.borderWidth = 1;
    self.bank.layer.masksToBounds = YES;//必须设置
    self.bank.layer.cornerRadius = CGRectGetHeight(self.bank.frame) / 2.0;//设置圆角的弧度，等于label的高的一半的时候，是个圆
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [self.bank setTitle:dic[@"title"] forState:UIControlStateNormal];
}

-(void)onBtnClicked:(id)sender{
    if (self.callBack) {
        self.callBack(self.dic);
    }
}
@end
