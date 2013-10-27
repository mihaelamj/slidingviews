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
//    viewFrame.origin.x = (index - 1) * self.leftOffset;
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

- (void)positionViewsWithTappedView:(UIView *)tappedView inScrollView:(UIScrollView *)scrollView
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
            
            NSLog(@"AFTER subview %d Frame: %@, Bounds: %@", subview.tag, NSStringFromCGRect(subview.frame), NSStringFromCGRect(subview.bounds));
            //calculate next views offset
            lastX += subViewFrame.size.width;
        }
    }
    //calculate content size with added views
    self.scrollView.contentSize = CGSizeMake(lastX, self.scrollView.contentSize.height);
}

- (void)showTappedView:(UIView *)view
{
    CGRect viewFrame = view.frame;
    CGPoint viewCenter = CGPointMake(CGRectGetMidX(viewFrame), 0);
    //find center of the viwe and move scroll frame /2 to the left
    viewCenter.x -= (self.scrollView.frame.size.width/2);
    //no gap to the left
    if (viewCenter.x < 0)
        viewCenter.x = 0;
    //no gap to the right
    int contentXEnd = viewCenter.x + self.scrollView.frame.size.width;
    if (contentXEnd > self.scrollView.contentSize.width)
        viewCenter.x -= (contentXEnd - self.scrollView.contentSize.width);
    
    [UIView animateWithDuration:0.6 delay:0.01 options: UIViewAnimationCurveLinear |
     UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.scrollView setContentOffset:viewCenter animated:NO];
                     }
                     completion:^(BOOL finished) {
                         //NSLog(@"Done!");
                     }
     ];
}

- (void)positionViewsWithTappedViewAnimatedPlain:(UIView *)tappedView inScrollView:(UIScrollView *)scrollView
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
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationDelay:0.05];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            //setting the bounds
            subview.bounds = subViewBounds;
            //move the origin
            subViewFrame.origin.x = lastX;
            //set the frame width
            subViewFrame.size.width = subViewBounds.size.width;
            //set view frame
            subview.frame = subViewFrame;
            
            [UIView commitAnimations];
            
            NSLog(@"AFTER subview %d Frame: %@, Bounds: %@", subview.tag, NSStringFromCGRect(subview.frame), NSStringFromCGRect(subview.bounds));
            //calculate next views offset
            lastX += subViewFrame.size.width;
        }
    }
    //calculate content size with added views
    self.scrollView.contentSize = CGSizeMake(lastX, self.scrollView.contentSize.height);
}

- (void)positionViewsWithTappedViewAnimated:(UIView *)tappedView inScrollView:(UIScrollView *)scrollView
{
    //init local vars
    int lastX = 0;
    
    for (UIView *subview in [scrollView subviews]) {
        //skip over non UIView classes (Scrollbar image Views) and those with no tag
        if ([subview isKindOfClass:[UIView class]] && (subview.tag)) {
            
            __block CGRect subViewFrame = subview.frame;
            CGRect subViewBounds = CGRectZero;
            
            if ([subview isEqual:tappedView]) {
                //expand tapped view bounds to full size
                subViewBounds = [self subViewBoundsFull];
            } else {
                //restrict non-tapped view bounds to middle size
                subViewBounds = [self subViewBoundsMiddle];
            }
            
            [UIView animateWithDuration:0.6 delay:0.01 options: UIViewAnimationCurveLinear |
             UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 //setting the bounds
                                 subview.bounds = subViewBounds;
                                 //move the origin
                                 subViewFrame.origin.x = lastX;
                                 //set the frame width
                                 subViewFrame.size.width = subViewBounds.size.width;
                                 //set view frame
                                 subview.frame = subViewFrame;
                             }
                             completion:^(BOOL finished) {
//                                 NSLog(@"Done!");
                             }
             ];
            
            
            NSLog(@"AFTER subview %d Frame: %@, Bounds: %@", subview.tag, NSStringFromCGRect(subview.frame), NSStringFromCGRect(subview.bounds));
            //calculate next views offset
            lastX += subViewFrame.size.width;
        }
    }
    //calculate content size with added views
    self.scrollView.contentSize = CGSizeMake(lastX, self.scrollView.contentSize.height);
}

#pragma mark - Overrides

- (void)addSubViews
{
    
    for (int i = 0; i < self.noSubViews; i++) {
        CGRect frame = [self subViewRectToTheLeft:i];
        UIView *view = [self makeViewWithFrame:frame index:i gestureSelector:@selector(handleMyTapGesture:)];
        [self.scrollView addSubview:view];
    }
    [self positionViewsWithTappedView:nil inScrollView:self.scrollView];
}

#pragma mark - Handle tap gesture

- (void)handleMyTapGesture:(UIGestureRecognizer *)sender
{
    NSLog(@"view %d tapped", sender.view.tag);
    [self positionViewsWithTappedViewAnimated:sender.view inScrollView:self.scrollView];
    [self showTappedView:sender.view];
}

@end
