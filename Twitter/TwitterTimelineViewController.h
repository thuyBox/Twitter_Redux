//
//  TwitterTimelineViewController.h
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWeet.h"
#import "ContainerViewController.h"
#import "TweetUpdateDelegate.h"
/*@protocol TweetUpdateDelegate <NSObject>

- (void) updateTweet:(Tweet *)tweet oldTweet:(Tweet *)oldTweet;
- (void) addTweet:(Tweet *)tweet;

@end*/

@interface TwitterTimelineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TweetUpdateDelegate>
//- (void) addTweet:(Tweet *)tweet;
//- (void) updateTweet:(Tweet *)tweet oldTweet:(Tweet *)oldTweet;
- (void)onRefresh;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) ContainerViewController *parentContainerViewController;
- (TwitterTimelineViewController *)initWithParentContainerViewController:(ContainerViewController *)parentContainerViewController;

@end
