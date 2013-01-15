//
//  AppDelegate.m
//  TabBar
//
//  Created by Marian PAUL on 21/03/12.
//  Copyright (c) 2012 iPuP SARL. All rights reserved.
//

#import "AppDelegate.h"

 
 
 
#import "FifthViewController.h"

#import "WineViewController.h"
#import "CommandesViewController.h"
#import "CoursViewController.h"

@implementation AppDelegate
@synthesize session = _session;

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

#pragma mark facebook

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [self.session handleOpenURL:url];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.tabBarController = [[UITabBarController alloc] init];
    
 //  FirstViewController *firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
//    firstViewController.title = @"Vins";
    
    WineViewController *wineVC = [[WineViewController alloc] init];
    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"Wine"
                                                              image:[UIImage imageNamed:@"142-wine-bottle.png"]
                                                                tag:2];
    wineVC.tabBarItem = tabBarItem3;

    
    
    
    
    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"List"
                                                              image:[UIImage imageNamed:@"53-house.png"]
                                                                tag:0];
    UITabBarItem *tabBarItem4 = [[UITabBarItem alloc] initWithTitle:@"Cours"
                                                              image:[UIImage imageNamed:@"96-book.png"]
                                                                tag:0];
    UITabBarItem *tabBarItemCommande = [[UITabBarItem alloc] initWithTitle:@"Commandes"
                                                              image:[UIImage imageNamed:@"167-upload-photo.png"]
                                                                tag:0];
    
    
    DataListViewController *dataListVC = [[DataListViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:dataListVC];
 
    navController.tabBarItem = tabBarItem1;

   
    UINavigationController *winenavigationController = [[UINavigationController alloc] initWithRootViewController:wineVC];
    winenavigationController.title= @"Wine2";
    [winenavigationController setNavigationBarHidden:NO];
    
    CoursViewController *secondViewController = [[CoursViewController alloc]  initWithStyle:UITableViewStylePlain];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    navigationController.title = @"Cours";
    navigationController.tabBarItem = tabBarItem4;
    [navigationController setNavigationBarHidden:NO];
 
    
    CommandesViewController *commandeslist = [[CommandesViewController alloc] initWithStyle:UITableViewStylePlain];
    commandeslist.tabBarItem = tabBarItemCommande;
 
    _tabBarController.viewControllers = [NSArray arrayWithObjects: navController,
                                         winenavigationController, navigationController, commandeslist,  nil];
    
    [_tabBarController.tabBar setSelectedImageTintColor:[UIColor grayColor]];
    
 
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:_tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        [self.session close];
}

@end
