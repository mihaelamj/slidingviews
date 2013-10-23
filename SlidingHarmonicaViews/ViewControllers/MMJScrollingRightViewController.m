//
//  MMJScrollingRightViewController.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJScrollingRightViewController.h"

@interface MMJScrollingRightViewController ()

@end

@implementation MMJScrollingRightViewController

#pragma mark - Overrides

- (void)addSubViews
{
    int lastX = 0;
    
    for (int i = 0; i < self.noSubViews; i++) {
        
        //calculate view's frame
        CGRect frame = CGRectZero;
        
        //view is high as the scroll view
        frame.size.height = self.scrollView.frame.size.height;
        
        //view's width is open width
        frame.size.width = self.openWidth;
        
        //move right by open width
        frame.origin.x = i * (self.openWidth);
        
        //make view
        UIView *view = [self makeViewWithFrame:frame index:i gestureSelector:@selector(handleTapGesture:)];
        
        //add background color
        view.backgroundColor = [self colorByNumber:i];
        
        //add it to scroll view
        [self.scrollView addSubview:view];
        
        //increase by closed width
        lastX += view.bounds.size.width;
    }
    
    //calculate content size with added views
    CGSize scrollSize = CGSizeZero;
    scrollSize.width = lastX;
    scrollSize.height = self.scrollView.contentSize.height;
    
    //adjust scroll view's content size
    self.scrollView.contentSize = scrollSize;
}

#pragma mark - Handle tap

- (void)handleTapGesture:(UIGestureRecognizer *)sender
{
    NSLog(@"view tapped");
}


@end
