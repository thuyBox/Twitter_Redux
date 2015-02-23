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

@interface ComposeTweetViewController ()

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *currentUser = [User user];
    self.nameLabel.text = currentUser.name;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    self.screenNameLabel.text = currentUser.screenName;
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
    [[TwitterClient sharedInstance] tweet:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
        //TODO: handle error
        NSLog(@"Finished tweeting: %@", tweet);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
