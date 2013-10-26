//
//  MMJColorsViewController.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 26/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorsViewController.h"
#import "UIColor+KECrayons.h"
#import "UIColor+StandardColors.h"

#define COLOR_TABLE_CELL @"ColorTableCell"

@interface MMJColorsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *colors;
@end

@implementation MMJColorsViewController

#pragma mark - Helpers

- (void)addBarButton
{
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style: UIBarButtonItemStyleBordered target:self action:@selector(editButton:)];
    [self.navigationItem setRightBarButtonItem:editButton];
}

#pragma mark - Editing cells

- (void)editButton:(id)sender
{
    if (self.editing) {
        //if editing disable it and change button's title
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:YES];
        [self.tableView reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
    } else {
        //if not editing enable it, change button title
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
    
    NSLog(@"colors\n%@", self.colors);
}

#pragma mark - Loading

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // add tableView to view
    [self.view addSubview:self.tableView];
    
    [self addBarButton];
    
    //set title
    self.title = @"Standard Colors";
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:COLOR_TABLE_CELL];
    }
    return _tableView;
}

- (NSMutableArray *)colors
{
    if (!_colors) {
        _colors = [NSMutableArray arrayWithArray:[UIColor standardColorNamesExcludingColors:@[@"clearColor", @"blackColor",@"whiteColor"]]];
        NSLog(@"colors \n%@", _colors);
        //remove black, white and clear color
        [self.tableView reloadData];
    }
    return _colors;
}

#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.colors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COLOR_TABLE_CELL];
    
    //set controller description as cell's text
    cell.textLabel.text = self.colors[indexPath.row];
    UIColor *cellColor = [UIColor colorFromName:self.colors[indexPath.row]];
    cell.backgroundColor = cellColor;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *selectedColor = self.colors[sourceIndexPath.row];
    NSLog(@"colors before \n%@", self.colors);
    //replace colors
    [self.colors removeObject:selectedColor];
    [self.colors insertObject:selectedColor atIndex:destinationIndexPath.row];
    NSLog(@"colors after:\n%@", self.colors);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"colors before %d:\n%@", self.colors.count, self.colors);
        [self.colors removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"colors after %d:\n%@", self.colors.count, self.colors);
    }
}



@end
