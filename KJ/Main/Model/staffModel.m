//
//  StaffModel.m
//  KJ
//
//  Created by 周鑫 on 2018/7/16.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "staffModel.h"

@implementation staffModel
- (instancetype)initWithName:(NSString *)name ID:(NSString *)ID {
    
    self = [super init];
    if (self) {
        self.name = name;
        self.ID = ID;
        self.award = NO;
    }
    return self;
}
@end
