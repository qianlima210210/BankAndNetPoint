//
//  MQLKuaiDiChaXunFinalCollectionViewCell.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/7.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLKuaiDiChaXunFinalCollectionViewCell.h"

@interface MQLKuaiDiChaXunFinalCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation MQLKuaiDiChaXunFinalCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self generalInit];
}

-(void)generalInit{

}

- (void)layoutSubviews{
}

-(void)resetContent{
    self.textView.text = @"";
}

-(void)setContent:(NSString*)content{
    _content = content;
    self.textView.text = self.content;
}

@end
