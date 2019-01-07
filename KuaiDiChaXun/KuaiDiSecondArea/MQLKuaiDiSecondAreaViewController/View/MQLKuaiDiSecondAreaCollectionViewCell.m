//
//  MQLKuaiDiSecondAreaCollectionViewCell.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/7.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLKuaiDiSecondAreaCollectionViewCell.h"

@interface MQLKuaiDiSecondAreaCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *kuaiDiSecondArea;

@end

@implementation MQLKuaiDiSecondAreaCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self generalInit];
}

-(void)generalInit{
    [self.kuaiDiSecondArea addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.kuaiDiSecondArea.layer.borderColor = UIColor.cyanColor.CGColor;
    self.kuaiDiSecondArea.layer.borderWidth = 1;
    self.kuaiDiSecondArea.layer.masksToBounds = YES;//必须设置
    self.kuaiDiSecondArea.layer.cornerRadius = CGRectGetHeight(self.kuaiDiSecondArea.frame) / 2.0;//设置圆角的弧度，等于label的高的一半的时候，是个圆
}

-(void)resetContent{
    
}

-(void)setContent{
    [self.kuaiDiSecondArea setTitle:self.dic[@"title"] forState:UIControlStateNormal];
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
