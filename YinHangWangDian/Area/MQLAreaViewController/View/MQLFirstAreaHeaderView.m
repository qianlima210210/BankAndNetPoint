//
//  MQLFirstAreaHeaderView.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/4.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLFirstAreaHeaderView.h"

@interface MQLFirstAreaHeaderView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLab;

@end

@implementation MQLFirstAreaHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self generalInit];
}

-(void)generalInit{

}

-(void)resetContent{
    self.titleLab.text = @"";
}

-(void)setContent{
    self.titleLab.text = self.title;
}

- (void)setTitle:(NSString *)title{
    [self resetContent];
    _title = title;
    [self setContent];
}

@end
