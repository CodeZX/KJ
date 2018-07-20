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
#import <AFNetworking/AFNetworking.h>
#import "XTJWebNavigationViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *motifLabel;
@property (weak, nonatomic) IBOutlet UIButton *StartlotteryButton;

@property (weak, nonatomic) IBOutlet UILabel *namesLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@property (nonatomic,strong) NSTimer *timer;


@property (nonatomic,strong) NSArray *nameslistArray;
@property (nonatomic,strong) NSArray *awardsArray;



@property (nonatomic,strong) NSArray *currentNameListArray;
@property (nonatomic,strong) AwardModel *currentAwardModel;

@property (nonatomic,strong) AVAudioPlayer *bgPlayer;
@property (nonatomic,strong) AVAudioPlayer *awardPlayer;

@end

@implementation ViewController

- (void)networking3 {
    
    NSDictionary *dic = @{@"appId":@"tj2_20180720008"};
    AFHTTPSessionManager *httpManager = [[AFHTTPSessionManager alloc]init];
    [httpManager GET:@"http://149.28.12.15:8080/app/get_version" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"0"]) {
            NSDictionary *retDataDic = dic[@"retData"];
            if ([retDataDic[@"version"] isEqualToString:@"2.0"]) {
                [self.bgPlayer stop];
                [self.awardPlayer stop];
                XTJWebNavigationViewController *Web = [[XTJWebNavigationViewController alloc]init];
                Web.url = retDataDic[@"updata_url"];
//                Web.url = @"http://www.baidu.com";
                [self presentViewController:Web animated:NO completion:nil];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initialData:) name:@"initialData" object:nil];
    [self setupUI];
    [self setupAudio];
    [self networking3];
}

- (void)initialData:(NSNotification *)notification {
    
    _nameslistArray = nil;
    _awardsArray = nil;
    
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"motif"]) {
        
        self.motifLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"motif"];
    }
    
//
    
   

}
- (IBAction)lotterySetting:(id)sender {
    
    
    if (!self.titleLabel.hidden) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"抽奖中" message:@"不能进行设置！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //            [self finishAction];
            
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        
        [self performSegueWithIdentifier:@"KJLotterySettingTableViewController" sender:nil];
        _nameslistArray = nil;
        _awardsArray = nil;
    }
    
    
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
       
        self.titleLabel.hidden = NO;
        self.contentView.hidden = NO;
        self.motifLabel.hidden = YES;
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
            self.titleLabel.hidden = YES;
            self.contentView.hidden = YES;
            self.motifLabel.hidden = NO;
            
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
    
    
    
    self.titleLabel.hidden = YES;
    self.contentView.hidden = YES;
    
   
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//
//}

- (void)setInterfaceOrientation:(UIDeviceOrientation)orientation {
    if ([[UIDevice currentDevice]   respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:orientation]
                                    forKey:@"orientation"];
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

//1.决定当前界面是否开启自动转屏，如果返回NO，后面两个方法也不会被调用，只是会支持默认的方向
- (BOOL)shouldAutorotate {
    return YES;
}

//2.返回支持的旋转方向
//iPad设备上，默认返回值UIInterfaceOrientationMaskAllButUpSideDwon
//iPad设备上，默认返回值是UIInterfaceOrientationMaskAll
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}

//3.返回进入界面默认显示方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}


@end
