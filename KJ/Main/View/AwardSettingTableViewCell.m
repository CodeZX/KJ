//
//  AwardSettingTableViewCell.m
//  KJ
//
//  Created by 周鑫 on 2018/7/13.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "AwardSettingTableViewCell.h"


@interface AwardSettingTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation AwardSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAwardModel:(AwardModel *)awardModel {
    
    _awardModel = awardModel;
    self.nameLable.text = awardModel.name;
    self.contentLabel.text =  [NSString stringWithFormat:@"一共%ld个，每次抽%ld",(long)awardModel.totalPeople,awardModel.singlePeople];
}

@end
