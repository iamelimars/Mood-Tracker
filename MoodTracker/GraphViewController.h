//
//  GraphViewController.h
//  MoodTracker
//
//  Created by Eli MArshall on 11/25/16.
//  Copyright © 2016 Eli MArshall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateValueFormatter.h"
#import "DayAxisValueFormatter.h"
@import ScrollableGraphView;
@import Charts;
#import "BEMSimpleLineGraphView.h"



@interface GraphViewController : UIViewController <ChartViewDelegate, IChartAxisValueFormatter, BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource>
@property (strong, nonatomic) IBOutlet BEMSimpleLineGraphView *dataGraph;

@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property (nonatomic, strong) NSMutableArray *ratingsArray;
@property (strong, nonatomic) IBOutlet ScrollableGraphView *graphView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic) NSMutableArray<NSNumber *> *myValues;
@property (strong, nonatomic) NSMutableArray *myDates;

@end
