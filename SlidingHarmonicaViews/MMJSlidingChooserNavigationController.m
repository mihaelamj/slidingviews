//
//  MMJSlidingChooserNavigationController.m
//  
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//
//

#import "MMJSlidingChooserNavigationController.h"
#import "MMJSlidingChooserViewController.h"

@interface MMJSlidingChooserNavigationController ()

@end

@implementation MMJSlidingChooserNavigationController

- (id)init
{
    //setting up initial view controller
    return [[MMJSlidingChooserNavigationController alloc] initWithRootViewController:[[MMJSlidingChooserViewController alloc] init]];
}


@end
