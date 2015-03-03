//
//  MenuViewController.m
//  Twitter
//
//  Created by Baeksan Oh on 2/27/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "MenuViewController.h"
#import "TwitterTimelineViewController.h"
#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AccountCell.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UINavigationController *timelineNvc;
@property (nonatomic, strong) UINavigationController *profileNvc;
@property (nonatomic, strong) TwitterTimelineViewController *timelineVc;
@property (nonatomic, strong) ProfileViewController *profileVc;
@property (nonatomic, strong) ContainerViewController *parentContainerViewController;
@end

@implementation MenuViewController

typedef NS_ENUM(NSInteger, MenuOptionIndex) {
    MenuOptionIndexTimeline = 0,
    MenuOptionIndexProfile = 1,
    MenuOptionIndexMessages = 2,
    MenuOptionIndexLogout = 3,
    MenuOptionIndexCount = 4
};

- (MenuViewController *)initWithParentContainerViewController:(ContainerViewController *)parentContainerViewController {
    self = [super init];
    if (self) {
        self.parentContainerViewController = parentContainerViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Menu";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountCell" bundle:nil] forCellReuseIdentifier:@"AccountCell"];
    self.tableView.estimatedRowHeight = 82;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.timelineVc = [[TwitterTimelineViewController alloc] initWithParentContainerViewController:self.parentContainerViewController];
    self.timelineNvc = [[UINavigationController alloc] initWithRootViewController:self.timelineVc];
    
    self.profileVc = [[ProfileViewController alloc] initWithParentContainerViewController:self.parentContainerViewController];
    self.profileNvc = [[UINavigationController alloc] initWithRootViewController:self.profileVc];
    [self displayContent:self.timelineNvc];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 82;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    /*if (self.header == nil) {
        self.header = [self.tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
        self.header.user = self.user;
        self.header.delegate = self;
    }
    return self.header;*/
    /*UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HeaderCell"];
    }*/
    
    AccountCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AccountCell"];
    
    User *user = [User user];
    [cell.profileImageView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    cell.nameLabel.text = user.name;
    cell.descriptionLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    //[cell.imageView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    //cell.textLabel.text = user.name;
    //cell.detailTextLabel.text = user.tagline;
    return cell;
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
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    switch (indexPath.row) {
        case MenuOptionIndexTimeline:
            cell.textLabel.text = @"Timeline";
            break;
        case MenuOptionIndexProfile:
            cell.textLabel.text = @"Profile";
            break;
        case MenuOptionIndexMessages:
            cell.textLabel.text = @"Messages";
            break;
        case MenuOptionIndexLogout:
            cell.textLabel.text = @"Logout";
            break;
    }
    return cell;
}

- (void) displayContent:(UIViewController *)vc {
    [self.delegate displayContent:vc];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case MenuOptionIndexTimeline:
            [self displayContent:self.timelineNvc];
            break;
        case MenuOptionIndexProfile:
            self.profileVc.user = [User user];
            [self displayContent:self.profileNvc];
            break;
        case MenuOptionIndexMessages:
            break;
        case MenuOptionIndexLogout:
            [User logout];
            break;
    }
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
