//
//  TwitterTimelineViewController.h
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWeet.h"

@interface TwitterTimelineViewController : UIViewController
- (void) addTweet:(Tweet *)tweet;
- (void) updateTweet:(Tweet *)tweet oldTweet:(Tweet *)oldTweet;
@end
