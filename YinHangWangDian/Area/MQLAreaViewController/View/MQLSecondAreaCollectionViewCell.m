//
//  MQLSecondAreaCollectionViewCell.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/4.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLSecondAreaCollectionViewCell.h"

@interface MQLSecondAreaCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *area;

@end

@implementation MQLSecondAreaCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self generalInit];
}

-(void)generalInit{
    [self.area addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.area.layer.borderColor = UIColor.cyanColor.CGColor;
    self.area.layer.borderWidth = 1;
    self.area.layer.masksToBounds = YES;//必须设置
    self.area.layer.cornerRadius = CGRectGetHeight(self.area.frame) / 2.0;//设置圆角的弧度，等于label的高的一半的时候，是个圆
}

-(void)resetContent{
    
}

-(void)setContent{
    [self.area setTitle:self.dic[@"title"] forState:UIControlStateNormal];
}

- (void)setDic:(NSDictionary *)dic{
    [self resetContent];
    _dic = dic;
    [self setContent];
}

-(void)onBtnClicked:(id)sender{
    if (self.callBack) {
        self.callBack(self.dic);
    }
}

@end
