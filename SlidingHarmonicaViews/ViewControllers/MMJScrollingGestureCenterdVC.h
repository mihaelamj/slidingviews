//
//  MMJScrollingGestureCenterdVC.h
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/23/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJScrollingViewController.h"

@interface MMJScrollingGestureCenterdVC : MMJScrollingViewController

@property (nonatomic) int viewWidth;
@property (nonatomic) int leftOffset;
@property (nonatomic) int rigthOffset;
@property (nonatomic, readonly) int middleViewWidth;

- (UIView *)makeViewWithFrame:(CGRect)frame index:(int)index gestureSelector:(SEL)gestureSelector;

@end
