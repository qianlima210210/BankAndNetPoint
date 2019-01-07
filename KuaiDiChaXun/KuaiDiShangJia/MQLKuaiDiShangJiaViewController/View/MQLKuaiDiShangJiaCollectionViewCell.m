//
//  MQLKuaiDiShangJiaCollectionViewCell.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/7.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLKuaiDiShangJiaCollectionViewCell.h"

@interface MQLKuaiDiShangJiaCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *kuaiDiShangjia;

@end

@implementation MQLKuaiDiShangJiaCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self generalInit];
}

-(void)generalInit{
    [self.kuaiDiShangjia addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.kuaiDiShangjia.layer.borderColor = UIColor.cyanColor.CGColor;
    self.kuaiDiShangjia.layer.borderWidth = 1;
    self.kuaiDiShangjia.layer.masksToBounds = YES;//必须设置
    self.kuaiDiShangjia.layer.cornerRadius = CGRectGetHeight(self.kuaiDiShangjia.frame) / 2.0;//设置圆角的弧度，等于label的高的一半的时候，是个圆
}

-(void)resetContent{
    
}

-(void)setContent{
    [self.kuaiDiShangjia setTitle:self.dic[@"title"] forState:UIControlStateNormal];
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
