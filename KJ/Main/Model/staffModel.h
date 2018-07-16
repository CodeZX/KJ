//
//  StaffModel.h
//  KJ
//
//  Created by 周鑫 on 2018/7/16.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface staffModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,assign,getter=isAward) BOOL award;
- (instancetype)initWithName:(NSString *)name ID:(NSString *)ID;

@end
