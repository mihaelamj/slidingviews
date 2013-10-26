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

//need to synthesize because declaring bith getters and setters
@synthesize viewWidth = _viewWidth;
@synthesize leftOffset = _leftOffset;
@synthesize rigthOffset = _rigthOffset;

#define VIEW_WIDTH 150
#define LEFT_OFFSET 50
#define RIGHT_OFFSET 50

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
 *  Makes view with a given frame, index, and selector for a geture reckognizer, used in (void)addSubViews
 *
 *  @param frame           frame for view
 *  @param index           view's index in superview
 *  @param gestureSelector selector for gesture reckognizer
 *
 *  @return returns the created view
 */

- (UIView *)makeViewWithFrame:(CGRect)frame index:(int)index gestureSelector:(SEL)gestureSelector
{
    //create view and add index as a tag
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.tag = index;
    
    //create middle view
    [self addMiddleViewToView:view];
    
    //add gesture reckognizer to view
    [self addGestureReckogizerToView:view selector:gestureSelector];
    
    //add color to the view
    view.backgroundColor = [self colorByNumber:index];
    
    return view;
}

#pragma mark - Properties

- (int)viewWidth
{
    return (0 == _viewWidth) ? VIEW_WIDTH : _viewWidth;
}

- (int)leftOffset
{
    return (0 == _leftOffset) ? LEFT_OFFSET : _leftOffset;
}

- (int)rigthOffset
{
    return (0 == _rigthOffset) ? RIGHT_OFFSET : _rigthOffset;
}

- (void)setViewWidth:(int)viewWidth
{
    if (_viewWidth != viewWidth) {
        _viewWidth = viewWidth;
        //re-create subviews
        [self reCreateViews];
    }
}

- (void)setLeftOffset:(int)leftOffset
{
    if (_leftOffset != leftOffset) {
        _leftOffset = leftOffset;
        //re-create subviews
        [self reCreateViews];
    }
}

- (void)setRigthOffset:(int)rigthOffset
{
    if (_rigthOffset != rigthOffset) {
        _rigthOffset = rigthOffset;
        //re-create subviews
        [self reCreateViews];
    }
}

- (int)middleViewMidth
{
    return self.viewWidth - (self.leftOffset + self.rigthOffset);
}


@end
