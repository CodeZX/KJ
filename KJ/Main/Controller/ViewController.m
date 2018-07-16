//
//  ViewController.m
//  KJ
//
//  Created by 周鑫 on 2018/7/12.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *motifLabel;
@property (weak, nonatomic) IBOutlet UIButton *StartlotteryButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"motif"]) {
        
        self.motifLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"motif"];
    }
    
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


@end
