//
//  ContainerViewController.h
//  Twitter
//
//  Created by Baeksan Oh on 2/27/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"

@interface ContainerViewController : UIViewController <TweetCellDelegate>
- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender;

@end
