//
//  ViewController.m
//  KJ
//
//  Created by 周鑫 on 2018/7/12.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "ViewController.h"
#import "staffModel.h"
#import "AwardModel.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *motifLabel;
@property (weak, nonatomic) IBOutlet UIButton *StartlotteryButton;

@property (weak, nonatomic) IBOutlet UILabel *namesLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (nonatomic,strong) NSTimer *timer;


@property (nonatomic,strong) NSArray *nameslistArray;
@property (nonatomic,strong) NSArray *awardsArray;



@property (nonatomic,strong) NSArray *currentNameListArray;
@property (nonatomic,strong) AwardModel *currentAwardModel;

@property (nonatomic,strong) AVAudioPlayer *bgPlayer;
@property (nonatomic,strong) AVAudioPlayer *awardPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    [self setupAudio];
}

- (void)viewWillAppear:(BOOL)animated {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"motif"]) {
        
        self.motifLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"motif"];
    }
    
//

}

- (void)setupAudio {
    
    NSURL *bgurl = [[NSBundle mainBundle] URLForResource:@"a" withExtension:@"mp3"];
    self.bgPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:bgurl error:nil];
    [self.bgPlayer prepareToPlay];
    [self.bgPlayer play];
    
    NSURL *awardurl = [[NSBundle mainBundle] URLForResource:@"b" withExtension:@"mp3"];
    self.awardPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:awardurl error:nil];
    [self.awardPlayer prepareToPlay];
    
}
- (IBAction)startAction:(id)sender {
    
    if ([self currentlyAwardModel]) {
       
        UIButton *button = (UIButton *)sender;
        if (button.selected) {
            
            [self finishAction];
            [self.bgPlayer play];
            [self.awardPlayer pause];
            
        }else {
            
            [self startAction];
            [self.bgPlayer pause];
            [self.awardPlayer play];
            
        }
        
        button.selected = !button.selected;
   
    }else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您好！" message:@"此次抽奖已完成！请查看中奖名单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //            [self finishAction];
            self.currentAwardModel = nil;
            return ;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
   
    
}

- (AwardModel *)currentlyAwardModel {
    
    for (NSInteger index = self.awardsArray.count - 1; index >= 0; index--) {
        AwardModel *model = self.awardsArray[index];
        if (!model.finish) {
            return model;
        }
    }
    return  nil;
    
}

- (void)startAction {
    
    
    self.currentAwardModel = [self currentlyAwardModel];
    if (self.currentAwardModel) {
        NSInteger singlePeople =  self.currentAwardModel.singlePeople;
        if (self.currentAwardModel.singlePeople + self.currentAwardModel.staffArray.count > self.currentAwardModel.totalPeople) {
            singlePeople = self.currentAwardModel.totalPeople - self.currentAwardModel.totalPeople;
        }
        
        self.titleLabel.text = [NSString stringWithFormat:@"%@: 共%@个，已抽取%@个，本轮抽取%@个",
                                self.currentAwardModel.name,
                                [NSString stringWithFormat:@"%ld",self.currentAwardModel.totalPeople],
                                [NSString stringWithFormat:@"%ld",self.currentAwardModel.staffArray.count],
                                [NSString stringWithFormat:@"%ld",singlePeople]
                                ];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSString *names = [[NSString alloc]init];
            self.currentNameListArray = [self arrayRandomForStaffList:singlePeople];
            for (staffModel *model in self.currentNameListArray) {
                names = [names stringByAppendingString:@" "];
                names = [names stringByAppendingString:model.name];
                NSLog(@"%@",model.name);
                
            }
            self.namesLabel.text = names;
        }];
        
    }else {
//        NSString *message = [NSString stringWithFormat:@"此次抽奖已完成！",self.currentAwardModel.name];
       
    }
    
   
    
    
}

- (void)finishAction {
    
    [self.timer invalidate];
    
    for (staffModel *model in self.currentNameListArray) {
        [self.currentAwardModel.staffArray addObject:model];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@: 共%@个，已抽取%@个",
                            self.currentAwardModel.name,
                            [NSString stringWithFormat:@"%ld",self.currentAwardModel.totalPeople],
                            [NSString stringWithFormat:@"%ld",self.currentAwardModel.staffArray.count]
                            ];
    
    [self saveAwardList];
    if (self.currentAwardModel.finish) {
        NSString *message = [NSString stringWithFormat:@"%@已完成！",self.currentAwardModel.name];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您好！" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //            [self finishAction];
            self.currentAwardModel = nil;
            return ;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)saveAwardList {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *awardListPath = [path stringByAppendingPathComponent:@"awardList"];
    if ([NSKeyedArchiver archiveRootObject:self.awardsArray toFile:awardListPath]) {
        NSLog(@"归档成功");
    }
    
}

- (NSArray *)arrayRandomForStaffList:(NSInteger)number  {
    
    
    if (!self.nameslistArray.count || number > self.nameslistArray.count)  {
        
        NSLog(@"%@",@"抽奖人数异常");
        return nil;
        
    }
    
    NSMutableArray *randomArray  = [[NSMutableArray alloc]init];
    for (int index = 0;index < number ; index ++) {
         staffModel *staffModel = self.nameslistArray[arc4random_uniform((int )self.nameslistArray.count)];
        [randomArray addObject:staffModel];
    }
    return randomArray;
   
    
}

- (void)setupUI {
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"motif"]) {
        
        self.motifLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"motif"];
    }
    
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startlotteryButton:(id)sender {
    
    
}

#pragma mark -------------------------- lazy load ----------------------------------------

- (NSArray *)nameslistArray {
    
    if (!_nameslistArray) {
        _nameslistArray = [[NSArray alloc]init];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *nameListPath = [path stringByAppendingPathComponent:@"nameList"];
        NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithFile:nameListPath];
        if (array) {
            _nameslistArray = array;
        }else {
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"nameList" ofType:@"plist"];
            NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
            NSMutableArray *muArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in array) {
                staffModel *model = [[staffModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [muArray addObject:model];
            }
            _nameslistArray = muArray;
            
        }
    }
    
    return _nameslistArray;
    
}

- (NSArray *)awardsArray {
    if (!_awardsArray) {
        _awardsArray = [[NSArray alloc]init];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *awardPath = [path stringByAppendingPathComponent:@"award"];
        NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithFile:awardPath];
        if (array) {
            _awardsArray = array;
        }else {
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"award" ofType:@"plist"];
            NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
            NSMutableArray *muArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in array) {
                AwardModel *model = [[AwardModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [muArray addObject:model];
            }
            _awardsArray = muArray;
        }
    }
    
    return _awardsArray;
    
}


@end
