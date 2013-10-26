//
//  MMJSlidingChooserViewController.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJSlidingChooserViewController.h"

#import "MMJScrollingFullViewController.h"
#import "MMJScrollingRightViewController.h"

#import "MMJScrollingRightOffsetVC.h"


@interface MMJSlidingChooserViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *controllers;

@end

#define SLIDERS_CELL_ID @"cliders_cell"

#define CONT_NAME @"name"
#define CONT_OBJ @"object"

#pragma mark - Loading

@implementation MMJSlidingChooserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // add tableView to view
    [self.view addSubview:self.tableView];
    
    //set title
    self.title = @"Sliding Views";
}


#pragma mark - Helpers

- (NSDictionary *)controllerDictionaryAtIndex:(int)index
{
    if ((index < 0) || (index >= self.controllers.count))
        return nil;
    return [self.controllers objectAtIndex:index];
}

- (NSString *)controllerNameAtIndex:(int)index
{
    NSDictionary *controllerDict = [self controllerDictionaryAtIndex:index];
    return controllerDict ? [controllerDict objectForKey:CONT_NAME] : nil;
}

- (UIViewController *)controllerAtIndex:(int)index
{
    NSDictionary *controllerDict = [self controllerDictionaryAtIndex:index];
    return controllerDict ? [controllerDict objectForKey:CONT_OBJ] : nil;
}

#pragma mark - Properties

- (UITableView *)tableView
{
    if (!_tableView) {
        //create tableView
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        //setup table view protocol objects
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        //setup table appearance
        _tableView.rowHeight = 50;
        
        //register reusable cell class ID
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SLIDERS_CELL_ID];
    }
    return _tableView;
}

- (NSArray *)controllers //array of dictionary of array
{
    if (!_controllers) {
        // add dictionary for each controller holding controller objects with respective description
        _controllers = @[@{CONT_NAME : @"whole rect", CONT_OBJ : [[MMJScrollingFullViewController alloc] init]},
                         @{CONT_NAME : @"scrolling right", CONT_OBJ : [[MMJScrollingRightViewController alloc] init]},
                         @{CONT_NAME : @"scrolling right offset", CONT_OBJ : [[MMJScrollingRightOffsetVC alloc] init]}];
    }
    return _controllers;
}


#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SLIDERS_CELL_ID];
    
    //set controller description as cell's text
    cell.textLabel.text = [self controllerNameAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get selected view controller
    UIViewController *selectedViewController = [self controllerAtIndex:indexPath.row];
    if (!selectedViewController)
        return;
    
    //set selected view conroller's title
    selectedViewController.title = [self controllerNameAtIndex:indexPath.row];
    
    //instruct navigation controller to push detail view controller
    [self.navigationController pushViewController:selectedViewController animated:YES];
}

@end
