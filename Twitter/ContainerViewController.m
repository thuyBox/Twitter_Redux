//
//  ContainerViewController.m
//  Twitter
//
//  Created by Baeksan Oh on 2/27/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "ContainerViewController.h"
#import "MenuViewController.h"


CGFloat const xTrailing = 10.0;

@interface ContainerViewController ()

@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) MenuViewController *menuViewController;
@property BOOL isMenuVisible;
@property CGFloat xCenterOfMenu;
@property CGFloat menuWidth;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftView.backgroundColor = [UIColor greenColor];
    self.contentView.backgroundColor = [UIColor blackColor];
    self.isMenuVisible = NO;
    self.menuWidth = self.view.frame.size.width - xTrailing;
    self.xCenterOfMenu = self.menuWidth/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Allow sliding of Menu to open it, if panning from left to right passing the center of the left Menu, open it all the way (xdistance from right edge)
 
 Allow slidng of Menu to close it, if panning from right to left passing the center of the Menu, close all the way
 */
- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint velocity = [sender velocityInView:self.view];
    
    if (self.isMenuVisible && velocity.x > 0) {
        //menu is already open
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"UIGestureRecognizerStateBegan!");
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged!");
        CGPoint translation = [sender translationInView:self.view];
        CGPoint newCenter = CGPointMake(self.leftView.center.x + translation.x, self.leftView.center.y);
        
        if (newCenter.x > self.menuWidth) {
            newCenter.x = self.menuWidth;
        }
        self.leftView.center = newCenter;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded!");
        if (self.leftView.center.x < self.xCenterOfMenu) {
            if (velocity.x > 0) {
                //sliding right but not passing the center, close back
            } else {
                //sliding left and passing the center, close
            }
        } else {
            if (velocity.x > 0) {
                //sliding right and passing center, open all the way
            } else {
                //sliding left and still on the right half, stay open
            }
        }
    }
}
@end
