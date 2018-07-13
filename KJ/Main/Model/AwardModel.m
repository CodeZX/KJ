//
//  AwardModel.m
//  KJ
//
//  Created by 周鑫 on 2018/7/13.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "AwardModel.h"

@implementation AwardModel

- (instancetype)initWithName:(NSString *)name totalPeople:(NSInteger)totalPeople singlePeople:(NSInteger)singlePeople {
    self = [super init];
    if (self) {
        self.name = name;
        self.totalPeople = totalPeople;
        self.singlePeople = singlePeople;
    }
    return self;
}
@end
