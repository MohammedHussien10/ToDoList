//
//  DetailsViewController.h
//  To-Do-List
//
//  Created by Macos on 14/05/2025.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameDetails;

@property (weak, nonatomic) IBOutlet UITextView *descriptionDetails;
@property NSUserDefaults *resultTaskDefaults;
@property NSArray *arrayResultTaskDefaults;
@property NSMutableArray *tasksArray;
@property Task *selectedTask;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectedPrioritySegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectedStatusSegment;
@property NSString *selectedPriority;
@property NSString *selectedStatus;
@property NSUserDefaults *UpdateTaskDefaults;
@property NSMutableArray *UpdateArrayOfTaskDetails;
@property (weak, nonatomic) IBOutlet UIDatePicker *UpdateRemiderDate;
@end

NS_ASSUME_NONNULL_END
