//
//  DoingViewController.m
//  To-Do-List
//
//  Created by Macos on 14/05/2025.
//

#import "DoingViewController.h"

@interface DoingViewController ()

@end


Task *task;
}
- (void)viewDidLoad {
[super viewDidLoad];

_tableDetails.delegate = self;
_tableDetails.dataSource = self;
_tasksArray = [NSMutableArray new];

_searchBar.delegate = self;
_filteredTasksArray = [NSMutableArray new];
_isFiltering = NO;
_prioritySegment.selectedSegmentIndex = 3;

}

-(void)viewWillAppear:(BOOL)animated{
[super viewWillAppear:animated];
_resultTaskDefaults = [NSUserDefaults standardUserDefaults];
_arrayResultTaskDefaults = [_resultTaskDefaults objectForKey:@"Tasks"];
[_tasksArray removeAllObjects];
for (NSData *data in _arrayResultTaskDefaults) {
    Task *task = [NSKeyedUnarchiver unarchivedObjectOfClass:[Task class] fromData:data error:nil];
    if (task &&[task.status isEqualToString:@"doing"]) {
        [_tasksArray addObject:task];
    }
}

[_tableDetails reloadData];



}
- (IBAction)addTask:(id)sender {

AddTaskViewController *addTask = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];

[self.navigationController pushViewController:addTask animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {



return _isFiltering ? _filteredTasksArray.count : _tasksArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];


UILabel *labelTask = [cell viewWithTag:1];
UILabel *labelPriority = [cell viewWithTag:2];

Task *task = _isFiltering ? _filteredTasksArray[indexPath.row] : _tasksArray[indexPath.row];

labelTask.text = task.name;
labelPriority.text = task.priority;

return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
NSArray *sectionTitles =@[@"Tasks"];
return  sectionTitles[section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
[tableView deselectRowAtIndexPath: indexPath animated:YES];


DetailsViewController *detailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
if(_isFiltering){
    detailsViewController.selectedTask = _filteredTasksArray[indexPath.row];
}else{
    detailsViewController.selectedTask = _tasksArray[indexPath.row];
}


[self.navigationController pushViewController:detailsViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {

if (editingStyle == UITableViewCellEditingStyleDelete) {
    
    [_tasksArray removeObjectAtIndex:indexPath.row];

    
    NSMutableArray *encodedTasks = [NSMutableArray new];
    for (Task *t in _tasksArray) {
        NSData *encodedTask = [NSKeyedArchiver archivedDataWithRootObject:t requiringSecureCoding:NO error:nil];
        [encodedTasks addObject:encodedTask];
    }
    [_resultTaskDefaults setObject:encodedTasks forKey:@"Tasks"];
    [_resultTaskDefaults synchronize];

    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
_isFiltering = NO;
[_filteredTasksArray removeAllObjects];
[_tableDetails reloadData];
[searchBar resignFirstResponder];

_prioritySegment.selectedSegmentIndex = UISegmentedControlNoSegment;
}

-(IBAction)segmentChanged:(UISegmentedControl *)sender {
NSString *selectedPriority = @"";
switch (sender.selectedSegmentIndex) {
    case 0:
        selectedPriority = @"Low";
        break;
    case 1:
        selectedPriority = @"Mid";
        break;
    case 2:
        selectedPriority = @"High";
        break;
    case 3:
        _isFiltering = NO;
        [_filteredTasksArray removeAllObjects];
        [_tableDetails reloadData];
        return;
}

_isFiltering = YES;
[_filteredTasksArray removeAllObjects];

for (Task *task in _tasksArray) {
    if ([task.priority isEqualToString:selectedPriority]) {
        [_filteredTasksArray addObject:task];
    }
}

[_tableDetails reloadData];


}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
NSInteger selectedIndex = _prioritySegment.selectedSegmentIndex;

 if (searchText.length == 0 && selectedIndex == 3) {
     _isFiltering = NO;
     [_filteredTasksArray removeAllObjects];
     [_tableDetails reloadData];
     return;
 }

 _isFiltering = YES;
 [_filteredTasksArray removeAllObjects];

 for (Task *task in _tasksArray) {
     BOOL matchesSearch = (searchText.length == 0 || [task.name.lowercaseString containsString:searchText.lowercaseString]);

     if (selectedIndex == 3) {
         if (matchesSearch) {
             [_filteredTasksArray addObject:task];
         }
     } else {
         NSString *selectedPriority = @"";
         switch (selectedIndex) {
             case 0: selectedPriority = @"Low"; break;
             case 1: selectedPriority = @"Mid"; break;
             case 2: selectedPriority = @"High"; break;
         }

         BOOL matchesPriority = [task.priority isEqualToString:selectedPriority];
         if (matchesSearch && matchesPriority) {
             [_filteredTasksArray addObject:task];
         }
     }
 }

 [_tableDetails reloadData];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/

@end
