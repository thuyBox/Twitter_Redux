//
//  ComposeTweetViewController.m
//  Twitter
//
//  Created by Baeksan Oh on 2/23/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "TwitterTimelineViewController.h"

@interface ComposeTweetViewController ()

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *currentUser = [User user];
    self.nameLabel.text = currentUser.name;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", currentUser.screenName];
    self.tweetTextView.text = @"";
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tweetTextView becomeFirstResponder];
}

- (void)onCancel {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onTweet {
    if (self.toBeRepliedTweet) {
        [[TwitterClient sharedInstance] reply:self.toBeRepliedTweet text:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
            NSLog(@"Finished replying: %@", tweet);
            //TwitterTimelineViewController *vc = [self.navigationController.viewControllers objectAtIndex:0];
            [self.tweetsDelegate addTweet:tweet];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    } else {
        [[TwitterClient sharedInstance] tweet:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
            //TODO: handle error
            NSLog(@"Finished tweeting: %@", tweet);
            //TwitterTimelineViewController *vc = [self.navigationController.viewControllers objectAtIndex:0];
            [self.tweetsDelegate addTweet:tweet];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
