//
//  MMJAppDelegate.h
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMJSlidingChooserNavigationController.h"

@interface MMJAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong, nonatomic) MMJSlidingChooserNavigationController *navigationController;

@end
