//
//  MMJScrollingGestureCenterdVC.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/23/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJScrollingGestureCenterdVC.h"

@interface MMJScrollingGestureCenterdVC ()

@end

@implementation MMJScrollingGestureCenterdVC

#define DEFAULT_CLOSED_WID 100
#define DEFAULT_OPEN_WID 250

#pragma mark - Creating view


/**
 *  Adds view in the middle of a given view
 *
 *  @param view view to add a middle view to
 */

- (void)addMiddleViewToView:(UIView *)view
{
    //add middle view to view
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    [view addSubview:middleView];
    middleView.backgroundColor = [UIColor blackColor];
    
    //position it in the middle of view
    middleView.frame = CGRectMake(0, 0, view.frame.size.width / 6, view.frame.size.height);
    middleView.center = CGPointMake(view.frame.size.width / 2, middleView.center.y);
}

/**
 *  Adds a gesture reckognizer to a given view
 *
 *  @param view     view to add a gesture reckognizer to
 *  @param selector selector to perfomt for a gesture
 */

- (void)addGestureReckogizerToView:(UIView *)view selector:(SEL)selector
{
    UITapGestureRecognizer *viewTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    viewTap.numberOfTapsRequired=1;
    [view addGestureRecognizer:viewTap];
}

/**
 *  Makes view with a given frame, index, and selector for a geture reckognizer
 *
 *  @param frame           frame for view
 *  @param index           view's index in superview
 *  @param gestureSelector selector for gesture reckognizer
 *
 *  @return returns the created view
 */

- (UIView *)makeViewWithFrame:(CGRect)frame index:(int)index gestureSelector:(SEL)gestureSelector
{
    //create view
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    //create middle view
    [self addMiddleViewToView:view];
    
    //add gesture reckognizer to view
    [self addGestureReckogizerToView:view selector:gestureSelector];
    
    return view;
}

#pragma mark - Properties

- (int)closedWidth
{
    return (0 == _closedWidth) ? DEFAULT_CLOSED_WID : _closedWidth;
}

- (int)openWidth
{
    return (0 == _openWidth) ? DEFAULT_OPEN_WID : _closedWidth;
}

@end
