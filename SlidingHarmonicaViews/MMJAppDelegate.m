//
//  MMJAppDelegate.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJAppDelegate.h"


@implementation MMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    //setup navigation controller and put it as a root
    self.window.rootViewController = self.navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Properties

- (MMJSlidingChooserNavigationController *)navigationController
{
    if (!_navigationController) {
        _navigationController = [[MMJSlidingChooserNavigationController alloc] init];
    }
    return _navigationController;
}

@end
