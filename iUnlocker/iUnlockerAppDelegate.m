//
//  iUnlockerAppDelegate.m
//  iUnlocker
//
//  Created by mufeng on 16/3/19.
//  Copyright © 2016年 puckjs.com. All rights reserved.
//

#import "iUnlockerAppDelegate.h"
#import "RootViewController.h"

@interface iUnlockerAppDelegate ()

@end

@implementation iUnlockerAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RootViewController *rootViewController = [[RootViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [navigationController.navigationBar setTranslucent:YES];
    
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"%@", url);
    
    return  YES;
}

@end
