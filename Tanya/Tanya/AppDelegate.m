//
//  AppDelegate.m
//  Tanya
//
//  Created by Tatyana Shut on 23.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
//#import "UIColor+CustomColor.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [ UIColor colorWithRed:0xD5/255.0f green:0xF0/255.0f blue:0xFA/255.0f alpha:1];
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    return YES;
}

+(UIColor *) blueLight {
    return [UIColor colorWithRed:0xD5/255.0f
                           green:0xF0/255.0f
                            blue:0xFA/255.0f alpha:1];
}

@end
