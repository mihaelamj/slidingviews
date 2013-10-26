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
@property (nonatomic, strong) NSArray *colorNames;
@end

#define DEFAULT_SUBVIEWS_NO 15
#define USE_DEFAULT_COLORS YES

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

#pragma mark - Abstract
/**
 *  Abstract methods that need overriding in descendant classes
 */
- (void)addSubViews
{
    return;
}


#pragma mark - Helpers

+ (NSArray *)defaultColors
{
    return @[@"floraColor", @"lavenderColor", @"skyColor", @"strawberryColor", @"bananaColor", @"aquaColor", @"bubblegumColor", @"fernColor", @"maraschinoColor", @"iceColor", @"maroonColor", @"mossColor", @"midnightColor", @"aluminumColor", @"cantaloupeColor"];
}

- (UIColor *)colorByNumber:(int)number
{
//    return [UIColor randomStandardColor];
    return [UIColor colorFromName:[self.colorNames objectAtIndex:(number % [self.colorNames count])]];
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

- (NSArray *)colorNames
{
    if (!_colorNames) {
        if (USE_DEFAULT_COLORS) {
            _colorNames = [MMJScrollingViewController defaultColors];
        } else {
            _colorNames = [UIColor standardColorNamesExcludingColors:@[@"clearColor", @"blackColor",@"whiteColor",@"aluminumColor",@"asparagusColor",@"blueberryColor",@"cantaloupeColor",@"carnationColor",@"fernColor",@"floraColor",@"grapeColor",@"honeydewColor",@"iceColor",@"leadColor",@"licoriceColor",@"magnesiumColor"]];
            //remove black, white and clear color
        }
    }
    return _colorNames;
}


@end
