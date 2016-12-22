//
//  ViewController.h
//  XYPieChart
//
//  Created by XY Feng on 2/24/12.
//  Copyright (c) 2012 Xiaoyang Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface ViewController : UIViewController <XYPieChartDelegate, XYPieChartDataSource,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *tableData;
}
//@property (strong, nonatomic) NSMutableArray *expandedCells;

@property (strong, nonatomic) NSIndexPath *expandedIndexPath;
- (IBAction)back:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIView *insideCellView;

@property (weak, nonatomic) IBOutlet UITableView *myTable;

@property (weak, nonatomic) IBOutlet UILabel *viewDescription;

@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;

@property (strong, nonatomic) IBOutlet UITableViewCell *cellView;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@property (strong, nonatomic) IBOutlet XYPieChart *pieChartRight;

@property (strong, nonatomic) IBOutlet UILabel *selectedSliceLabel;
@property(nonatomic, strong) NSArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;
@end
