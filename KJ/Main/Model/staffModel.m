//
//  StaffModel.m
//  KJ
//
//  Created by 周鑫 on 2018/7/16.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "staffModel.h"

@interface staffModel ()<NSCoding>


@end
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


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
}
@end
