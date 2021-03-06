//
//  MenuViewController.h
//  Twitter
//
//  Created by Baeksan Oh on 2/27/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@protocol MenuViewControllerDelegate <NSObject>

- (void) displayContent:(UIViewController *)vc;

@end

@interface MenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) id<MenuViewControllerDelegate> delegate;
- (MenuViewController *)initWithParentContainerViewController:(ContainerViewController *)parentContainerViewController;
@end
