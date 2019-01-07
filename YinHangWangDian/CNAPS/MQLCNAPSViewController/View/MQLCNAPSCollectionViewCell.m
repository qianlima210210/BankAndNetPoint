//
//  MQLCNAPSCollectionViewCell.m
//  BankAndNetPoint
//
//  Created by ma qianli on 2019/1/4.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLCNAPSCollectionViewCell.h"

@interface MQLCNAPSCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *apsLab;
@property (weak, nonatomic) IBOutlet UILabel *addLab;

@end

@implementation MQLCNAPSCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)resetContent{
    self.nameLab.text = @"";
    self.apsLab.text = @"";
    self.addLab.text = @"";
}

-(void)setContent{
    self.nameLab.text = [NSString stringWithFormat:@"银行网点名称: %@", self.dic[@"name"]];
    self.apsLab.text = [NSString stringWithFormat:@"网点联行号/CNAPS: %@", self.dic[@"aps"]];
    self.addLab.text = [NSString stringWithFormat:@"网点地址: %@", self.dic[@"add"]];
}

- (void)setDic:(NSDictionary *)dic{
    [self resetContent];
    _dic = dic;
    [self setContent];
}

@end
