//
//  MenuViewController.m
//  Twitter
//
//  Created by Baeksan Oh on 2/27/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MenuViewController

typedef NS_ENUM(NSInteger, MenuOptionIndex) {
    MenuOptionIndexTimeline = 0,
    MenuOptionIndexProfile = 1,
    MenuOptionIndexMessages = 2,
    MenuOptionIndexLogout = 3,
    MenuOptionIndexCount = 4
};

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MenuOptionIndexCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch (indexPath.row) {
        case MenuOptionIndexTimeline:
            cell.textLabel.text = @"Timeline";
            cell.imageView.image = [UIImage imageNamed:@"retweet.png"];
            break;
        case MenuOptionIndexProfile:
            cell.textLabel.text = @"Profile";
            cell.imageView.image = [UIImage imageNamed:@"retweet.png"];
            break;
        case MenuOptionIndexMessages:
            cell.textLabel.text = @"Messages";
            cell.imageView.image = [UIImage imageNamed:@"retweet.png"];
            break;
        case MenuOptionIndexLogout:
            cell.textLabel.text = @"Timeline";
            cell.imageView.image = [UIImage imageNamed:@"retweet.png"];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
