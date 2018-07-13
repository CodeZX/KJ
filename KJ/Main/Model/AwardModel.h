//
//  AwardModel.h
//  KJ
//
//  Created by 周鑫 on 2018/7/13.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AwardModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger totalPeople;
@property (nonatomic,assign) NSInteger singlePeople;
- (instancetype)initWithName:(NSString *)name totalPeople:(NSInteger )totalPeople singlePeople:(NSInteger )singlePeople;
@end
