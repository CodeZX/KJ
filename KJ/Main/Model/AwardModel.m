//
//  AwardModel.m
//  KJ
//
//  Created by 周鑫 on 2018/7/13.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "AwardModel.h"


@interface AwardModel ()<NSCoding>

@end
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


- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.totalPeople forKey:@"totalPeople"];
    [aCoder encodeInteger:self.singlePeople forKey:@"singlePeople"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.totalPeople = [aDecoder decodeIntegerForKey:@"totalPeople"];
        self.singlePeople = [aDecoder decodeIntegerForKey:@"singlePeople"];
    }
    return self;
    
}
@end
