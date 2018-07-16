//
//  KJAwardSettingTableViewController.m
//  KJ
//
//  Created by 周鑫 on 2018/7/12.
//  Copyright © 2018年 ZX. All rights reserved.
// 奖项设置

#import "KJAwardSettingTableViewController.h"
#import "AwardModel.h"
#import "AwardSettingTableViewCell.h"
#import "KJAwardEditTableViewController.h"
#import "KJAddAwardTableViewController.h"

@interface KJAwardSettingTableViewController ()
@property (nonatomic,strong) NSMutableArray *awardArray;
@end

@implementation KJAwardSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated  {
    
    [self.tableView reloadData];
}

- (void)setupUI {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClick:)];
    
}

- (void)addClick:(id)sender {
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];//这里的bundle 写nil也可以代表是mainBundle
//    KJAwardEditTableViewController *vc = [storyboard  instantiateViewControllerWithIdentifier:@"KJAwardEditTableViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    
   [self performSegueWithIdentifier:@"KJAddAwardTableViewController" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addAward:(AwardModel *)awardModel {
    
    [self.awardArray addObject:awardModel];
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.awardArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AwardSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AwardSettingCell" forIndexPath:indexPath];
    AwardModel *awardModel = self.awardArray[indexPath.row];
    cell.awardModel = awardModel;
    return cell;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"KJAddAwardTableViewController"]) {
        
        KJAddAwardTableViewController *VC = segue.destinationViewController;
        VC.awardSettingTableVC = self;
   
    } else {
        UIButton *button = (UIButton *)sender;
        UITableViewCell *cell = (UITableViewCell *) button.superview.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        KJAwardEditTableViewController *VC = segue.destinationViewController;
        VC.awardModel = self.awardArray[indexPath.row];
        
    }
   
    
    
}

#pragma mark -------------------------- lazy laod ----------------------------------------
- (NSMutableArray *)awardArray {
    if (!_awardArray) {
        _awardArray = [[NSMutableArray alloc]init];
        AwardModel *awardModel1 = [[AwardModel alloc]initWithName:@"一等奖" totalPeople:1 singlePeople:1];
        AwardModel *awardModel2 = [[AwardModel alloc]initWithName:@"二等奖" totalPeople:2 singlePeople:1];
        AwardModel *awardModel3 = [[AwardModel alloc]initWithName:@"三等奖" totalPeople:3 singlePeople:1];
        AwardModel *awardModel4 = [[AwardModel alloc]initWithName:@"优秀奖" totalPeople:20 singlePeople:4];
        [_awardArray addObject:awardModel1];
        [_awardArray addObject:awardModel2];
        [_awardArray addObject:awardModel3];
        [_awardArray addObject:awardModel4];
    }
    return _awardArray;
}


@end
