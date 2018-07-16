//
//  KJListSettingTableViewController.m
//  KJ
//
//  Created by 周鑫 on 2018/7/12.
//  Copyright © 2018年 ZX. All rights reserved.
//   名单设置

#import "KJListSettingTableViewController.h"
#import "ListSettingTableViewCell.h"
#import "staffModel.h"
#import "KJAddListTableViewController.h"

@interface KJListSettingTableViewController ()
@property (nonatomic,strong) NSArray *nameListArray;
@end

@implementation KJListSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
   
}

- (void)setupUI {
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addList:)];
}

- (void)addList:(id)serder {
    
    
    [self performSegueWithIdentifier:@"KJAddListTableViewController" sender:nil];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.nameListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListSettingTableViewCell" forIndexPath:indexPath];
 
 
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"KJAddListTableViewController"]) {
        
        KJAddListTableViewController *VC = segue.destinationViewController;
        VC.addListTableVC = self;
        
    }
    
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


#pragma mark -------------------------- lazy laod ----------------------------------------
- (NSArray *)nameListArray {
    
    if (!_nameListArray) {
     
        staffModel *model1 = [[staffModel alloc]initWithName:@"张三" ID:@"1"];
        staffModel *model2 = [[staffModel alloc]initWithName:@"李四" ID:@"2"];
        _nameListArray = @[model1,model2];
        
    }
    return _nameListArray;
}
@end
