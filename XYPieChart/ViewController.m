//
//  ViewController.m
//  XYPieChart
//
//  Created by XY Feng on 2/24/12.
//  Copyright (c) 2012 Xiaoyang Feng. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "data.h"

@implementation ViewController

@synthesize pieChartRight = _pieChart;
int a;

@synthesize selectedSliceLabel = _selectedSlice;

@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    _popView.hidden=YES;
    data *first=[[data alloc] init];
    first.title=@"Dbl";
    first.titledata=@" dbl is the banking section";
    data *second=[[data alloc]init];
    second.title=@"geckolyte";
    second.titledata=@"it is the big data section";
    data *third=[[data alloc]init];
    third.title=@"enterprise";
    third.titledata=@"it manages the enterprise";
    tableData = @[first,second,third];
    [super viewDidLoad];
    
    
    
   _slices=[NSArray arrayWithObjects:@40,@35,@25, nil];
    

    [self.pieChartRight setDelegate:self];
    [self.pieChartRight setDataSource:self];
    [self.pieChartRight setPieCenter:CGPointMake(240, 240)];
    [self.pieChartRight setShowPercentage:NO];
    [self.pieChartRight setLabelColor:[UIColor blackColor]];
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1], 
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    //rotate up arrow

}

- (void)viewDidUnload
{
   
    [self setPieChartRight:nil];
  
    [self setSelectedSliceLabel:nil];
  
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    [self.pieChartRight reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}




#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return 3;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    if(pieChart == self.pieChartRight) return nil;
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %d",index);
    a = index;
    data *db=[tableData objectAtIndex:index];
    _popView.hidden=NO;
    if(index==0)
    {
        _viewTitle.text=@"DBL";
        _viewDescription.text=@"DBL is the banking section of MobME";
    }
    else if(index==1)
    {
        _viewTitle.text=@"Geckolyst";
        _viewDescription.text=@"Geckolyst handles the big data";
    }
    else if(index==2)
    {
        _viewTitle.text=@"Enterprise";
        _viewDescription.text=@"It handles the enterprise section";
    }
    self.selectedSliceLabel.text =db.title;
    }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        [[NSBundle mainBundle]loadNibNamed:@"View" owner:self options:nil];
        cell=_cellView;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    data *da=[tableData objectAtIndex:indexPath.row];
    _cellLabel = (UILabel *)[cell viewWithTag:10];
    _cellLabel.text=da.title;
    return cell;
}


@end
