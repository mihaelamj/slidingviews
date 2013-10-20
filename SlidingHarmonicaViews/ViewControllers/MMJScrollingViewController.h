//
//  MMJScrollingViewController.h
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMJScrollingViewController : UIViewController

@property(strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic) int noSubViews;

- (void)addSubViews; //abstract
- (UIColor *)colorByNumber:(int)number;
- (void)removeAllSubViewsFromScrollView;
- (void)reCreateViews;

@end
