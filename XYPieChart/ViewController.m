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
{
    UITableView *newTable;
    NSIndexPath *newIndex;
 
    
    NSUInteger *a;
}

@synthesize pieChartRight = _pieChart;
int flag;
int b=0;
int c=50;
int selectedIndex;

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
    first.title=@"DBL";
    first.titledata=@" dbl is the banking section of MobMe";
    data *second=[[data alloc]init];
    second.title=@"GECKOLYST";
    second.titledata=@"it is the big data section of MobMe";
    data *third=[[data alloc]init];
    third.title=@"ENTERPRISE";
    third.titledata=@"it manages the enterprise section of MobMe";
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
    _label2.text=da.titledata;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSIndexPath *p = [NSIndexPath indexPathWithIndex:a];
    NSLog(@"the yoyo is %@",p);
    p=indexPath;
 NSLog(@"the zozo is %ld",(long)indexPath);
    [tableView beginUpdates]; // tell the table you're about to start making changes
    
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
       self.expandedIndexPath = nil;
    } else {
       self.expandedIndexPath = indexPath;
   }
   
    
    [tableView endUpdates]; // tell the table you're done making your changes
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Compares the index path for the current cell to the index path stored in the expanded
    // index path variable. If the two match, return a height of 100 points, otherwise return
    // a height of 44 points.
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {

        return 200.0; // Expanded height
    }
    return 44.0; // Normal height
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{

// [self tableView:newTable didSelectRowAtIndexPath:newIndex];
    
    [_myTable reloadData];

   

//    data *entry=[tableData objectAtIndex:index];
//    NSLog(@"did select slice at index %d",index);
//    a =index;
//    NSLog (@"did select table at %@", indexPatha);
//    _viewTitle.text=entry.title;
//    _viewDescription.text=entry.titledata;
//    self.selectedSliceLabel.text =entry.title;
//   
    NSIndexPath *indexPatha = [NSIndexPath indexPathForRow:index inSection:0];

    [_myTable selectRowAtIndexPath:indexPatha
                               animated:NO
                         scrollPosition:UITableViewScrollPositionNone];
    
    // This will also Highlighted the row. Then delegate
   [_myTable.delegate tableView:newTable didSelectRowAtIndexPath:indexPatha];
//    NSLog(@"table is %@",indexPatha);
}

@end
