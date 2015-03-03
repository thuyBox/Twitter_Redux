//
//  ContainerViewController.m
//  Twitter
//
//  Created by Baeksan Oh on 2/27/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "ContainerViewController.h"
#import "MenuViewController.h"
#import "MenuViewController.h"
#import "ProfileViewController.h"

//CGFloat const xTrailing = 30.0;

@interface ContainerViewController () <MenuViewControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) MenuViewController *menuViewController;
@property (strong, nonatomic) UIViewController *childContentViewController;
@property BOOL isMenuVisible;
@property CGFloat xCenterOfMenu;
@property CGFloat menuWidth;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuWidth = self.leftView.frame.size.width; //self.view.frame.size.width - xTrailing;
    self.xCenterOfMenu = self.menuWidth/2;
    self.leftView.center = CGPointMake(-self.xCenterOfMenu, self.view.center.y);
    
    //Set up MenuViewController in leftView
    MenuViewController *menuVC = [[MenuViewController alloc] initWithParentContainerViewController:self];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:menuVC];
    menuVC.delegate = self;
    [self addChildViewController:nvc];
    nvc.view.frame = CGRectMake(0, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
    [self.leftView addSubview:nvc.view];
    [nvc didMoveToParentViewController:self];
    
    [self closeMenu];
}

- (void) displayContent:(UIViewController *)vc {
    if (self.childContentViewController) {
        [self hideChildController:self.childContentViewController];
    }
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    [self.contentView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    [self closeMenu];
}

- (void) closeMenu {
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.4 options:UIViewAnimationCurveEaseOut|UIViewAnimationOptionAllowUserInteraction animations:^{
        NSLog(@"current leftView's center=%@ closed to newCenter=%@", NSStringFromCGPoint(self.leftView.center), NSStringFromCGPoint(CGPointMake(-self.xCenterOfMenu,self.leftView.center.y)));
        self.leftView.center = CGPointMake(-self.xCenterOfMenu,self.leftView.center.y);
    } completion:^(BOOL finished) {
        
    }];
}

- (void) openMenu {
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.4 options:UIViewAnimationCurveEaseIn|UIViewAnimationOptionAllowUserInteraction animations:^{
        NSLog(@"current leftView's center=%@ open to newCenter=%@", NSStringFromCGPoint(self.leftView.center), NSStringFromCGPoint(CGPointMake(self.xCenterOfMenu,self.leftView.center.y)));
        self.leftView.center = CGPointMake(self.xCenterOfMenu,self.leftView.center.y);
    } completion:^(BOOL finished) {
        
    }];
}

- (void) hideChildController:(UIViewController*) child
{
    [child willMoveToParentViewController:nil];
    [child.view removeFromSuperview];
    [child removeFromParentViewController];
}

/*
 Allow sliding of Menu to open it, if panning from left to right passing the center of the left Menu, open it all the way (xdistance from right edge)
 
 Allow slidng of Menu to close it, if panning from right to left passing the center of the Menu, close all the way
 */
- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"UIGestureRecognizerStateBegan!");
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged!");
        CGPoint translation = [sender translationInView:self.view];
        CGPoint newCenter = CGPointMake(self.leftView.center.x + translation.x, self.leftView.center.y);
        
        if (newCenter.x > self.xCenterOfMenu) {
            newCenter.x = self.xCenterOfMenu;
        }
        
        NSLog(@"current leftView's center=%@ changed to newCenter=%@", NSStringFromCGPoint(self.leftView.center), NSStringFromCGPoint(newCenter));
        self.leftView.center = newCenter;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded!");
        if (self.leftView.center.x < self.xCenterOfMenu) {
            //close menu given final position is on the left half
            [self closeMenu];
        } else {
            //open menu given final position is on the right half
            [self openMenu];
        }
    }
}

#pragma mark - gesture controls

// Need to allow parent container to handle pan gesture while the table view scroll still working
// See http://stackoverflow.com/questions/17614609/table-view-doesnt-scroll-when-i-use-gesture-recognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)onProfileImageTap:(User *)user {
    ProfileViewController *profileVc = [[ProfileViewController alloc] initWithParentContainerViewController:self];
    profileVc.user = user;
    UINavigationController *profileNvc = [[UINavigationController alloc] initWithRootViewController:profileVc];
    [self displayContent:profileNvc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
