//
//  DoneViewController.h
//  To-Do-List
//
//  Created by Macos on 20/06/2025.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController:UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *filteredTasksArray;
@property (assign, nonatomic) BOOL isFiltering;
@property (weak, nonatomic) IBOutlet UITableView *tableDetails;
@property NSUserDefaults *resultTaskDefaults;
@property NSArray *arrayResultTaskDefaults;
@property NSMutableArray *tasksArray;

@end
