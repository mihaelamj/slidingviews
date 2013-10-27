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

#pragma mark - Positioning

- (CGRect)subViewRectToTheLeft:(int)index
{
    //set full width
    CGRect viewFrame = CGRectMake(0, 0, self.viewWidth, self.scrollView.frame.size.height);
    //move origin to the left by middle width
    viewFrame.origin.x = (index - 1) * self.middleViewWidth;
    return viewFrame;
}

- (CGRect)subViewBoundsMiddle
{
    //restrict bounds just to the middle part
    return CGRectMake(self.leftOffset, 0, self.middleViewWidth, self.scrollView.frame.size.height);
}

- (CGRect)subViewBoundsFull
{
    return CGRectMake(0, 0, self.viewWidth, self.scrollView.frame.size.height);
}

- (void)openTappedView:(UIView *)tappedView inScrollView:(UIScrollView *)scrollView
{
    //init local vars
    int lastX = 0;
    
    for (UIView *subview in [scrollView subviews]) {
        //skip over non UIView classes (Scrollbar image Views) and those with no tag
        if ([subview isKindOfClass:[UIView class]] && (subview.tag)) {
            
            CGRect subViewFrame = subview.frame;
            CGRect subViewBounds = CGRectZero;
            
            if ([subview isEqual:tappedView]) {
                //expand tapped view bounds to full size
                subViewBounds = [self subViewBoundsFull];
            } else {
                //restrict non-tapped view bounds to middle size
                subViewBounds = [self subViewBoundsMiddle];
            }
            
            //setting the bounds
            subview.bounds = subViewBounds;
            
            //move the origin
            subViewFrame.origin.x = lastX;
            //set the frame width
            subViewFrame.size.width = subViewBounds.size.width;
            //set view frame
            subview.frame = subViewFrame;
            
            //calculate next views offset
            lastX += subViewFrame.size.width;
            
            NSLog(@"AFTER subview %d Frame: %@, Bounds: %@", subview.tag, NSStringFromCGRect(subview.frame), NSStringFromCGRect(subview.bounds));
        }
    }
    
    //calculate content size with added views
    CGSize scrollSize = CGSizeZero;
    scrollSize.width = lastX;
    scrollSize.height = self.scrollView.contentSize.height;
    //adjust scroll view's content size
    self.scrollView.contentSize = scrollSize;
}

#pragma mark - Overrides

- (void)addSubViews
{
    //needed to calculate scroll view's content size
    int lastX = 0;
    
    for (int i = 0; i < self.noSubViews; i++) {
        
        //move subview to the left by offset
        CGRect frame = [self subViewRectToTheLeft:i];
        //make view
        UIView *view = [self makeViewWithFrame:frame index:i gestureSelector:@selector(handleMyTapGesture:)];
        
        //make bounds restricting to the middle
        CGRect viewBounds = [self subViewBoundsMiddle];
        view.bounds = viewBounds;
        NSLog(@"view : %d, frame : %@, bounds : %@", i, NSStringFromCGRect(frame), NSStringFromCGRect(viewBounds));
        
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
    [self openTappedView:sender.view inScrollView:self.scrollView];
}

@end
