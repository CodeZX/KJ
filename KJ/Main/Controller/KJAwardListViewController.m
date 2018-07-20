//
//  KJAwardListTableViewController.m
//  KJ
//
//  Created by 周鑫 on 2018/7/12.
//  Copyright © 2018年 ZX. All rights reserved.
//   获奖名单

#import "KJAwardListViewController.h"
#import "staffModel.h"
#import "AwardModel.h"


@interface KJAwardListViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic,strong) NSArray *awardArray;

@end

@implementation KJAwardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *awardListPath = [path stringByAppendingPathComponent:@"awardList"];
    self.awardArray = [NSKeyedUnarchiver unarchiveObjectWithFile:awardListPath];
    NSString *awardListString = [[NSString alloc]init];
    for (AwardModel *awardModel in self.awardArray) {
       awardListString  =  [awardListString stringByAppendingString:[NSString stringWithFormat:@"\n\t#####%@#####\n\t",awardModel.name]];
        for (staffModel *model in awardModel.staffArray) {
            awardListString  = [awardListString stringByAppendingString:[NSString stringWithFormat:@" %@",model.name]];
            NSLog(@"%@",model.name);
        }
    }
    
//    self.textView.text = @"\t\t\t\t#####一等奖######\n \
//                           #####二等奖######\n   \
//                           #####三等奖######\n   \
//                           #####优秀奖######\n";
//    NSLog(@"%@",awardListString);
    self.textView.text = awardListString;
    
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"复制" style:UIBarButtonItemStyleDone target:self action:@selector(copy:)];
}

- (void)copy:(id)sender {
    
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.textView.text;
    
    
//    NSString *message = [NSString stringWithFormat:@"%@已完！",self.currentAwardModel.name];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"复制完成" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //            [self finishAction];
    
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
