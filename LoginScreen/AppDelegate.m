//
//  AppDelegate.m
//  LoginScreen
//
//  Created by Artyom Gurbovich on 4.07.21.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [window setRootViewController:vc];
    self.window = window;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
