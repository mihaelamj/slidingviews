//
//  MMJScrollingRightViewController.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJScrollingRightViewController.h"

@interface MMJScrollingRightViewController ()
@property (nonatomic) int closedWidth;
@property (nonatomic) int openWidth;
@property (nonatomic, readonly) int rightGap;
@end

@implementation MMJScrollingRightViewController

#define DEFAULT_CLOSED_WID 100
#define DEFAULT_OPEN_WID 300

#pragma mark - Creating view

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

- (void)addGestureReckogizerToView:(UIView *)view selector:(SEL)selector
{
    UITapGestureRecognizer *viewTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    viewTap.numberOfTapsRequired=1;
    [view addGestureRecognizer:viewTap];
}

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

- (void)handleTapGesture:(UIGestureRecognizer *)sender
{
    NSLog(@"view tapped");
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

- (int)rightGap
{
    return self.openWidth - self.closedWidth;
}

@end
