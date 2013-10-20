//
//  MMJScrollingViewController.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJScrollingViewController.h"
#import "UIColor+KECrayons.h"
#import "UIColor+StandardColors.h"

@interface MMJScrollingViewController ()

@end

@implementation MMJScrollingViewController

@synthesize noSubViews = _noSubViews;

#pragma mark - Loading

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //add svroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollView];
    [self.scrollView setScrollEnabled:TRUE];
    
    //call abstract method overriden in descendands
    [self addSubViews];
}

- (void)addSubViews
{
    return;
}


#pragma mark - Helpers

- (UIColor *)colorByNumber:(int)number
{
    //TODO: change to index colors
    return [UIColor randomStandardColor];
}


- (void)removeAllSubViewsFromScrollView
{
    //remove all UIView descendands from scroll view
    for (id subView in [self.scrollView subviews]) {
        //scroll view has image subvies that for scrolling indicators
        if ([subView isKindOfClass:[UIView class]])
            [subView removeFromSuperview];
    }
}

- (void)reCreateViews
{
    [self removeAllSubViewsFromScrollView];
    [self addSubViews];
}

#pragma maks - Properties

#define DEFAULT_SUBVIEWS_NO 10

- (int)noSubViews
{
    return (0 == _noSubViews) ? DEFAULT_SUBVIEWS_NO : _noSubViews;
}

- (void)setNoSubViews:(int)noSubViews
{
    //recreate subvies only if number changed
    if (_noSubViews != noSubViews) {
        _noSubViews = noSubViews;
        [self reCreateViews];
    }
}


@end
