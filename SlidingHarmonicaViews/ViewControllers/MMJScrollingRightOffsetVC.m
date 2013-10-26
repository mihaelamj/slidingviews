//
//  MMJScrollingRightOffsetVC.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/23/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJScrollingRightOffsetVC.h"

@interface MMJScrollingRightOffsetVC ()

@end

@implementation MMJScrollingRightOffsetVC

#pragma mark - Overrides

- (void)addSubViews
{
    //make frame for each sub view
    CGRect frame = CGRectZero;
    //view is high as the scroll view
    frame.size.height = self.scrollView.frame.size.height;
    frame.size.width = self.viewWidth;
    
    int lastX = 0;
    
    for (int i = 0; i < self.noSubViews; i++) {
        
        NSLog(@"view : %d", i);
        //move subview to the right by offset
        frame.origin.x = (i -1) * self.middleViewMidth;
        NSLog(@"frame : %@", NSStringFromCGRect(frame));
        
        //make view
        UIView *view = [self makeViewWithFrame:frame index:i gestureSelector:@selector(handleMyTapGesture:)];
        
        //restrict drawing of view to center rect with bounds
        CGRect viewBounds = CGRectMake(0, 0, self.middleViewMidth, frame.size.height);
        viewBounds.origin.x = self.leftOffset;
        view.bounds = viewBounds;
        NSLog(@"bounts : %@", NSStringFromCGRect(viewBounds));
        
        //add it to scroll view
        [self.scrollView addSubview:view];
        
        //increase by bounds width
        lastX += view.bounds.size.width;
    }
    
    //calculate content size with added views
    CGSize scrollSize = CGSizeZero;
    scrollSize.width = lastX;
    scrollSize.height = self.scrollView.contentSize.height;
    
    //adjust scroll view's content size
    self.scrollView.contentSize = scrollSize;
}

#pragma mark - Handle tap gesture

- (void)handleMyTapGesture:(UIGestureRecognizer *)sender
{
    NSLog(@"view tapped");
}

@end
