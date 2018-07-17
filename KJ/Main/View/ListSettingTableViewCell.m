//
//  ListSettingTableViewCell.m
//  KJ
//
//  Created by 周鑫 on 2018/7/13.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "ListSettingTableViewCell.h"
#import "staffModel.h"

@interface ListSettingTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDlabel;


@end
@implementation ListSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setStaffModel:(staffModel *)staffModel {
    
    _staffModel = staffModel;
    
    self.nameLabel.text = staffModel.name;
    self.IDlabel.text = staffModel.ID;
}

@end
