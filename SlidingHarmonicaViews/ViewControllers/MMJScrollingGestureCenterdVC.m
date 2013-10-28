//
//  MMJScrollingGestureCenterdVC.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/23/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJScrollingGestureCenterdVC.h"
#import "UIColor+KECrayons.h"

@interface MMJScrollingGestureCenterdVC ()

@end

@implementation MMJScrollingGestureCenterdVC

//need to synthesize these properties because we are declaring both getters and setters
@synthesize viewWidth = _viewWidth;
@synthesize leftOffset = _leftOffset;
@synthesize rigthOffset = _rigthOffset;

#define VIEW_WIDTH 120
#define LEFT_OFFSET 40
#define RIGHT_OFFSET 40

#pragma mark - Creating view

/**
 *  Adds view in the middle of a given view
 *
 *  @param view view to add a middle view to
 */

- (void)addMiddleViewToView:(UIView *)view index:(int)index
{
    //add middle view to view
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];
    [view addSubview:middleView];
    middleView.backgroundColor = [UIColor tungstenColor];
    
    //position it in the middle of view
    middleView.frame = CGRectMake(0, 0, view.frame.size.width / 6, view.frame.size.height);
    
    //add label to middle view to know view's index in the subview
    UILabel *label = [[UILabel alloc] initWithFrame:middleView.frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = [NSString stringWithFormat:@"%d", view.tag];
    label.textColor = [UIColor whiteColor];
    
    //need to add the label before changing the view's center, because it changes the view's frame
    middleView.center = CGPointMake(view.frame.size.width / 2, middleView.center.y);
    [middleView addSubview:label];
}

/**
 *  Adds a gesture recognizer to a given view
 *
 *  @param view     view to add a gesture recognizer to
 *  @param selector selector to perfomt for a gesture
 */
- (void)addGestureReckogizerToView:(UIView *)view selector:(SEL)selector
{
    UITapGestureRecognizer *viewTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    viewTap.numberOfTapsRequired=1;
    [view addGestureRecognizer:viewTap];
}

/**
 *  Makes view with a given frame, index, and selector for a geture recognizer, used in addSubViews
 *
 *  @param frame           frame for view
 *  @param index           view's index in superview
 *  @param gestureSelector selector for gesture recognizer
 *
 *  @return returns the created view
 */
- (UIView *)makeViewWithFrame:(CGRect)frame index:(int)index gestureSelector:(SEL)gestureSelector
{
    //create view and add index as a tag
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.tag = index + 1;
    
    //create middle view
    [self addMiddleViewToView:view index:index];
    
    //add gesture recognizer to view
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

- (int)middleViewWidth
{
    return self.viewWidth - (self.leftOffset + self.rigthOffset);
}


@end
