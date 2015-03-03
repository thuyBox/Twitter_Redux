//
//  User.m
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";

@interface User()

@property (nonatomic, strong) NSDictionary *dictionary;
@end
@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
        self.followersCount = [dictionary[@"friends_count"] integerValue];
        self.followingCount = [dictionary[@"followers_count"] integerValue];
        self.favoritesCount = [dictionary[@"favourites_count"] integerValue];
        self.profileBannerUrl = dictionary[@"profile_banner_url"];
        self.userId = dictionary[@"id_str"];
    }
    
    return self;
}

static User* _currentUser = nil;
NSString * const kCurrentUserKey = @"kCurrentUserKey";
+ (User *)user {
    if (_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if (data) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            _currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return _currentUser;
}

+ (void)setUser:(User *)user {
    _currentUser = user;
    
    if (_currentUser != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:user.dictionary options:0 error:NULL];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)logout {
    [User setUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}

@end
