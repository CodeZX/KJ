//
//  KJAwardListTableViewController.m
//  KJ
//
//  Created by 周鑫 on 2018/7/12.
//  Copyright © 2018年 ZX. All rights reserved.
//   获奖名单

#import "KJAwardListTableViewController.h"
#import "staffModel.h"
#import "AwardModel.h"


@interface KJAwardListTableViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic,strong) NSArray *awardArray;

@end

@implementation KJAwardListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *awardListPath = [path stringByAppendingPathComponent:@"awardList"];
    self.awardArray = [NSKeyedUnarchiver unarchiveObjectWithFile:awardListPath];
    NSString *awardListString = [[NSString alloc]init];
    for (AwardModel *awardModel in self.awardArray) {
       awardListString  =  [awardListString stringByAppendingString:[NSString stringWithFormat:@"\n\t\t\t\t#####%@#####\n\t\t\t",awardModel.name]];
        for (staffModel *model in awardModel.staffArray) {
            awardListString  = [awardListString stringByAppendingString:[NSString stringWithFormat:@"\t%@",model.name]];
            NSLog(@"%@",model.name);
        }
    }
    
//    self.textView.text = @"\t\t\t\t#####一等奖######\n \
//                           #####二等奖######\n   \
//                           #####三等奖######\n   \
//                           #####优秀奖######\n";
    
    self.textView.text = awardListString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
