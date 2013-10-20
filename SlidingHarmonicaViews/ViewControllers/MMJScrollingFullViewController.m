//
//  MMJScrollingFullViewController.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJScrollingFullViewController.h"

@interface MMJScrollingFullViewController ()
@property (nonatomic, getter = isBottom) BOOL bottom;
@property (nonatomic, getter = IsShowIndicator) BOOL showIndicator;
@end

@implementation MMJScrollingFullViewController

#pragma mark - Bar buttons

#define TITLE_BOTTOM @"Bottom"
#define TITLE_RIGHT @"Right"

- (void)addBarButtons
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:TITLE_RIGHT style:UIBarButtonItemStylePlain target:self action:@selector(bottomOnOff)];
    //TODO: maybe add segmented control
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Indicator" style:UIBarButtonItemStylePlain target:self action:@selector(indicatorOnOff)];
}

//- (void)indicatorOnOff
//{
//    self.showIndicator = !self.IsShowIndicator;
//}

- (void)bottomOnOff
{
    self.bottom = !self.isBottom;
}

#pragma mark - Overrides

- (void)addSubViews
{
    for (int i = 0; i < self.noSubViews; i++) {
        CGRect frame = self.scrollView.frame;
        
        //calculating view's frame : adding to the bootom or to the right
        if (self.isBottom) {
            frame.origin.x = frame.size.width * i;
            frame.origin.y = 0;
        } else {
            frame.origin.x = 0;
            frame.origin.y = frame.size.height * i;;
        }
        
        //create view
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        
        //add background color
        subview.backgroundColor = [self colorByNumber:i];
        
        //add it to scroll view
        [self.scrollView addSubview:subview];
    }
    
    //adjust scroll view's content size accordingly
    if (self.isBottom) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.noSubViews, self.scrollView.frame.size.height);
    } else {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height * self.noSubViews);
    }
    
    [self addBarButtons];
}

#pragma maks - Properties

- (void)setBottom:(BOOL)bottom
{
    if (_bottom !=bottom) {
        _bottom = bottom;
        
        [self reCreateViews];
    }
    
    //display the title of action that will be performed if button is clicked
    if (_bottom)
        [self.navigationItem.rightBarButtonItem setTitle:TITLE_BOTTOM];
    else
        [self.navigationItem.rightBarButtonItem setTitle:TITLE_RIGHT];
}

- (void)setShowIndicator:(BOOL)showIndicator
{
    _showIndicator = showIndicator;
    self.scrollView.showsHorizontalScrollIndicator = _showIndicator;
    self.scrollView.showsVerticalScrollIndicator = _showIndicator;
}

@end
