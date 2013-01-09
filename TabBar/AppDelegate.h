//
//  AppDelegate.h
//  TabBar
//
//  Created by Marian PAUL on 21/03/12.
//  Copyright (c) 2012 iPuP SARL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataListViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
 
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) FBSession *session;

@end
 