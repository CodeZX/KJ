//
//  KJLotterySettingTableViewController.m
//  KJ
//
//  Created by 周鑫 on 2018/7/12.
//  Copyright © 2018年 ZX. All rights reserved.
//  

#import "KJLotterySettingTableViewController.h"

@interface KJLotterySettingTableViewController ()


@end

@implementation KJLotterySettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.title);
    
    
    [self setupUI];
}

- (void)setupUI {
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
}

- (void)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}
//
///*
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}
//*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        
        
        
        // 删除文件   名单   奖品   中奖名单
        
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL res = YES;
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *awardPath = [path stringByAppendingPathComponent:@"award"];
        res =[fileManager removeItemAtPath:awardPath error:nil];
        
       
        NSString *nameListPath = [path stringByAppendingPathComponent:@"award"];
        res =[fileManager removeItemAtPath:nameListPath error:nil];
        
        
        NSString *awardListPath = [path stringByAppendingPathComponent:@"awardList"];
        res = [fileManager removeItemAtPath:awardListPath error:nil];
        
        
//            NSString *message = [NSString stringWithFormat:@"%@已完成！",self.currentAwardModel.name];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"初始数据成功" message:@"可以重新开奖了" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //            [self finishAction];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"initialData" object:nil];
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
       
        
        
    }
//    NSLog(@"%d",indexPath.row);
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
