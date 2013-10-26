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
    //needed to calculate scroll view's content size
    int lastX = 0;
    
    for (int i = 0; i < self.noSubViews; i++) {
        NSLog(@"view : %d", i);
        //move subview to the right by offset
        frame.origin.x = (i - 1) * self.middleViewMidth;
        NSLog(@"frame : %@", NSStringFromCGRect(frame));
        
        //make view
        UIView *view = [self makeViewWithFrame:frame index:i gestureSelector:@selector(handleMyTapGesture:)];
        
        //restrict drawing of view to center rect with bounds
        CGRect viewBounds = CGRectMake(0, 0, self.middleViewMidth, frame.size.height);
        //move origin by left offset
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
    NSLog(@"view %d tapped", sender.view.tag);
    [self openTappedViewRight:sender.view inScrollView:self.scrollView];
}

#pragma mark - Helpers

- (void)openTappedViewRight:(UIView *)tappedView inScrollView:(UIScrollView *)scrollView
{
    //init local vars
    int lastX = 0;
    CGRect frame = CGRectZero;
    
    for (UIView *subview in [scrollView subviews]) {
        //skip over non UIView classes (Scrollbar image Views)
        if ([subview isKindOfClass:[UIView class]]) {
            frame = subview.frame;
            NSLog(@"subview Frame: %@, Bounds: %@", NSStringFromCGRect(subview.frame), NSStringFromCGRect(subview.bounds));
            
            int boundsWidth;
            int boundsOrigin;
            
            //expand tapped view bounds to full size
            if ([subview isEqual:tappedView]) {
                boundsWidth = self.viewWidth;
                boundsOrigin = 0;
                lastX -= self.leftOffset;
            } else {
                //shrinks other (non tapped view's) bounds to smaller size
                boundsWidth = self.middleViewMidth;
                //set the bounds offset to left offset
                boundsOrigin = self.leftOffset;
            }
            
            //setting the bounds
            CGRect viewBounds = CGRectMake(0, 0, boundsWidth, subview.frame.size.height);
            viewBounds.origin.x = boundsOrigin;
            subview.bounds = viewBounds;
            frame.size.width = boundsWidth;
            
            frame.origin.x = lastX;
            subview.frame = frame;
            
            //calculate next views offset
            lastX += frame.size.width;
        }
    }

}

@end
