//
//  LoginViewController.m
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TwitterTimelineViewController.h"
#import "ContainerViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)loginClicked:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        NSLog(@"Welcome %@", user.name);
        //TwitterTimelineViewController *vc = [[TwitterTimelineViewController alloc] init];
        //UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        [[UIApplication sharedApplication] delegate].window.rootViewController = [[ContainerViewController alloc] init];
        //[self presentViewController:nvc animated:YES completion:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
