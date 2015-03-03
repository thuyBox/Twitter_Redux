//
//  ProfileViewController.h
//  Twitter
//
//  Created by Baeksan Oh on 2/27/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TwitterTimelineViewController.h"

@interface ProfileViewController : TwitterTimelineViewController//UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) User *user;
- (ProfileViewController *)initWithParentContainerViewController:(ContainerViewController *)parentContainerViewController;
@end
