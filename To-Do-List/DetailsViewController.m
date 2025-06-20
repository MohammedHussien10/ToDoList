//
//  DetailsViewController.m
//  To-Do-List
//
//  Created by Macos on 14/05/2025.
//

#import "DetailsViewController.h"
#import "Task.h"
@interface DetailsViewController ()

@end

@implementation DetailsViewController
{
    Task *task;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _nameDetails.enabled = NO;
    _descriptionDetails.userInteractionEnabled = NO;
    _selectedStatusSegment.enabled = NO;
    _selectedPrioritySegment.enabled = NO;
    _UpdateTaskDefaults = [NSUserDefaults standardUserDefaults];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [_tasksArray removeAllObjects];
    
    [super viewWillAppear:animated];
    
    
    if (_selectedTask) {
        if([_selectedTask.priority isEqualToString:@"Low"]){
            _selectedPrioritySegment.selectedSegmentIndex = 0;
        }else if([_selectedTask.priority isEqualToString:@"Mid"]){
            _selectedPrioritySegment.selectedSegmentIndex = 1;
            
        }else{
            _selectedPrioritySegment.selectedSegmentIndex = 2;
        }
        
        if([_selectedTask.status isEqualToString:@"Task"]){
            _selectedStatusSegment.selectedSegmentIndex = 0;
        }else if([_selectedTask.status isEqualToString:@"Doing"]){
            _selectedStatusSegment.selectedSegmentIndex = 1;
            
        }else{
            _selectedStatusSegment.selectedSegmentIndex = 2;
        }
        _nameDetails.text = _selectedTask.name;
        _descriptionDetails.text = _selectedTask.descriptionTask;

        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm"; // نفس تنسيق التاريخ اللي حفظته فيه

        NSDate *convertedDate = [formatter dateFromString:_selectedTask.reminderDate];
        if (convertedDate) {
            self.UpdateRemiderDate.date = convertedDate;
        }
    }
}


- (IBAction)editDetails:(id)sender {
    _nameDetails.enabled = YES;
    _descriptionDetails.userInteractionEnabled = YES;
    _selectedStatusSegment.enabled = YES;
    _selectedPrioritySegment.enabled = YES;
}
- (IBAction)saveEditingDetails:(id)sender {
    
    NSString *oldName = self.selectedTask.name;
    
    
      self.selectedTask.name = self.nameDetails.text;
      self.selectedTask.descriptionTask = self.descriptionDetails.text;
      self.selectedTask.status = self.selectedStatusSegment.selectedSegmentIndex == 0 ? @"Task" :
                                 self.selectedStatusSegment.selectedSegmentIndex == 1 ? @"Doing" : @"Done";
      self.selectedTask.priority = self.selectedPrioritySegment.selectedSegmentIndex == 0 ? @"Low" :
                                   self.selectedPrioritySegment.selectedSegmentIndex == 1 ? @"Mid" : @"High";

      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      NSMutableArray *tasksDataArray = [[defaults objectForKey:@"Tasks"] mutableCopy];
      if (!tasksDataArray) {
          tasksDataArray = [NSMutableArray new];
      }

      NSMutableArray *tasks = [NSMutableArray new];
      for (NSData *data in tasksDataArray) {
          Task *t = [NSKeyedUnarchiver unarchivedObjectOfClass:[Task class] fromData:data error:nil];
          if (t) {
              [tasks addObject:t];
          }
      }

      for (int i = 0; i < tasks.count; i++) {
          Task *t = tasks[i];
          if ([t.name isEqualToString:oldName]) {
              tasks[i] = self.selectedTask;
              break;
          }
      }

      NSMutableArray *updatedTasksData = [NSMutableArray new];
      for (Task *t in tasks) {
          NSData *encoded = [NSKeyedArchiver archivedDataWithRootObject:t requiringSecureCoding:NO error:nil];
          [updatedTasksData addObject:encoded];
      }

      [defaults setObject:updatedTasksData forKey:@"Tasks"];
      [defaults synchronize];
//      [self.navigationController popViewControllerAnimated:YES];
    
    printf("Edit");
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
