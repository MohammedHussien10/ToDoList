//
//  Task.h
//  To-Do-List
//
//  Created by Macos on 14/05/2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *priority; 
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSData *attachedFile;
@property (nonatomic, strong) NSDate *reminderDate;

@end

NS_ASSUME_NONNULL_END
