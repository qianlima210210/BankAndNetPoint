//
//  MQLKuaiDiFirstAreaCollectionViewCell.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/7.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLKuaiDiFirstAreaCollectionViewCell.h"

@interface MQLKuaiDiFirstAreaCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *kuaiDiFirstArea;

@end

@implementation MQLKuaiDiFirstAreaCollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self generalInit];
}

-(void)generalInit{
    [self.kuaiDiFirstArea addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.kuaiDiFirstArea.layer.borderColor = UIColor.cyanColor.CGColor;
    self.kuaiDiFirstArea.layer.borderWidth = 1;
    self.kuaiDiFirstArea.layer.masksToBounds = YES;//必须设置
    self.kuaiDiFirstArea.layer.cornerRadius = CGRectGetHeight(self.kuaiDiFirstArea.frame) / 2.0;//设置圆角的弧度，等于label的高的一半的时候，是个圆
}

-(void)resetContent{
    
}

-(void)setContent{
    [self.kuaiDiFirstArea setTitle:self.dic[@"title"] forState:UIControlStateNormal];
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
