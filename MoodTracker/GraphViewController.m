//
//  GraphViewController.m
//  MoodTracker
//
//  Created by Eli MArshall on 11/25/16.
//  Copyright © 2016 Eli MArshall. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController 
@synthesize chartView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myDates = [self getNext30Days];
    self.myValues = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 30; i++) {
        //i = rand() % 10 + 1;
        NSNumber *value = [NSNumber numberWithInt:rand() % 10 + 1];
        [self.myValues addObject:value];
    }

    
    self.dataGraph = [[BEMSimpleLineGraphView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2)];
    
    
    // Create a gradient to apply to the bottom portion of the graph
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    // Apply the gradient to the bottom portion of the graph
    self.dataGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    self.dataGraph.delegate = self;
    self.dataGraph.dataSource = self;
    self.dataGraph.enableTouchReport = YES;
    self.dataGraph.enablePopUpReport = YES;
    self.dataGraph.enableYAxisLabel = YES;
    self.dataGraph.colorYaxisLabel = [UIColor whiteColor];
    self.dataGraph.colorXaxisLabel = [UIColor whiteColor];
    

    self.dataGraph.autoScaleYAxis = YES;
    self.dataGraph.alwaysDisplayDots = NO;
    self.dataGraph.enableReferenceXAxisLines = YES;
//    self.dataGraph.enableReferenceYAxisLines = YES;
//    self.dataGraph.enableReferenceAxisFrame = YES;


    self.dataGraph.animationGraphStyle = BEMLineAnimationDraw;
    self.dataGraph.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    self.dataGraph.formatStringForValues = @"%.1f";
    self.dataGraph.enableBezierCurve = YES;
    self.dataGraph.colorTop = [UIColor colorWithRed:91/255.0 green:200/255.0 blue:172/255.0 alpha:0.0];
    self.dataGraph.colorBottom = [UIColor colorWithRed:91/255.0 green:200/255.0 blue:172/255.0 alpha:0.0];
    [self.view addSubview:self.dataGraph];
    
    //Plus Minus View creation
    UIView *changeWeekView = [[UIView alloc] initWithFrame:CGRectMake(0, self.dataGraph.frame.size.height + 2, self.view.frame.size.width, 50)];
    changeWeekView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:changeWeekView];
    
    UILabel *currentWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, changeWeekView.frame.size.height)];
    currentWeekLabel.textColor = [UIColor whiteColor];
    currentWeekLabel.textAlignment = NSTextAlignmentCenter;
    currentWeekLabel.text = @"11/30 - 12/04";
    currentWeekLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14.0];
    [changeWeekView addSubview:currentWeekLabel];
    
    UIButton *minusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, -10, changeWeekView.frame.size.width / 2, 60)];
    [minusButton setTitle:@"-" forState:UIControlStateNormal];
    minusButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:50.0];
    [changeWeekView addSubview:minusButton];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(minusButton.frame.size.width, -10, changeWeekView.frame.size.width / 2, 60)];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:35];
    [changeWeekView addSubview:addButton];
   
    
    

//    
//    
//    self.ratingsArray = [[NSMutableArray alloc]initWithObjects:
//                         @"The Worst I've Ever Been",
//                         @"Horrible",
//                         @"Very Bad",
//                         @"Bad",
//                         @"Alright",
//                         @"Pretty Good",
//                         @"Good",
//                         @"Very Good",
//                         @"Great!",
//                         @"Awesome!", nil];
//    
//    chartView.delegate = self;
//    
//    
//    chartView.chartDescription.enabled = NO;
//    chartView.dragEnabled = YES;
//    [chartView setScaleEnabled:YES];
//    chartView.pinchZoomEnabled = NO;
//    
//    //[chartView setVisibleXRangeMaximum:50];
//    //[chartView moveViewToX:90];
//    
//    chartView.drawGridBackgroundEnabled = NO;
//    chartView.highlightPerDragEnabled = YES;
//    
//    chartView.backgroundColor = UIColor.whiteColor;
//    
//    chartView.legend.enabled = NO;
//    
//    ChartXAxis *xAxis = chartView.xAxis;
//    xAxis.labelPosition = XAxisLabelPositionBottom;
//    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
//    xAxis.labelTextColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:56/255.0 alpha:1.0];
//    xAxis.drawAxisLineEnabled = NO;
//    xAxis.drawGridLinesEnabled = NO;
//    xAxis.centerAxisLabelsEnabled = YES;
//    xAxis.granularity = 1.0;
//    xAxis.labelCount = 7;
//    xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:chartView];
//    
//    ChartYAxis *leftAxis = chartView.leftAxis;
//    leftAxis.labelPosition = YAxisLabelPositionInsideChart;
//    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
//    leftAxis.labelTextColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
//    leftAxis.drawGridLinesEnabled = NO;
//    leftAxis.granularityEnabled = YES;
//    leftAxis.axisMinimum = 0.0;
//    leftAxis.axisMaximum = 11.0;
//    leftAxis.yOffset = -9.0;
//    leftAxis.labelTextColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:56/255.0 alpha:1.0];
//    
//    chartView.rightAxis.enabled = NO;
//    
//    chartView.legend.form = ChartLegendFormLine;
    
    //[self setChartWithDataPoints:myDates values:myValues];
    //[self updateChartData];

}


#pragma mark - SimpleLineGraph Data Source

-(NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    
    return (int)[self.myValues count] - 23;
}

-(CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    
    return [[self.myValues objectAtIndex:index] doubleValue];
}

#pragma mark - SimpleLineGraph Delegate Methods

-(NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    
    return 1;
    
}

-(NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    
    NSString *label = self.myDates[index];
    NSLog(@"%@", label);
    NSLog(@"%lu", (unsigned long)self.myDates.count);
    NSLog(@"%lu", (unsigned long)self.myValues.count);
    return label;
    
    
}

-(NSInteger)numberOfYAxisLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    
    return 10.0;
    
}



















- (void)setChartWithDataPoints:(NSMutableArray *) dataPoints values:(NSMutableArray<NSNumber *>*) values {
    
    NSMutableArray *dataEntries = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < dataPoints.count; i++) {
        
        double newValue = [values[i] doubleValue];
        NSLog(@"%f", newValue);
        NSLog(@"%i", i);
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:newValue y:i];
        [dataEntries addObject:entry];
    }
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:dataEntries label:@"Ratings"];
    
    
    set1.mode = LineChartModeCubicBezier;
    set1.cubicIntensity = 0.2;
    set1.axisDependency = AxisDependencyLeft;
    set1.valueTextColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
    set1.lineWidth = 1.5;
    set1.drawCirclesEnabled = YES;
    set1.drawValuesEnabled = NO;
    set1.fillAlpha = 0.26;
    set1.fillColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
    set1.highlightColor = [UIColor colorWithRed:224/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
    set1.drawCircleHoleEnabled = NO;
    set1.drawFilledEnabled = YES;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    
    LineChartData *chartData = [[LineChartData alloc]initWithDataSets:dataSets];
    
    [chartData setValueTextColor:UIColor.whiteColor];
    [chartData setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.0]];
    
    chartView.data = chartData;
}


-(NSMutableArray *)getNext30Days {
    
    NSInteger numberOfDays = 30;
    
    NSDate *startDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *offset = [[NSDateComponents alloc]init];
    //NSMutableArray* dates = [NSMutableArray arrayWithObject:startDate];
    NSMutableArray* dates = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd"];
    
    for (int i = 1; i <= numberOfDays; i++) {
        [offset setDay:i];
        NSDate *nextDay = [calendar
                           dateByAddingComponents:offset
                           toDate:startDate
                           options:0];
        NSString *formattedDateString = [dateFormatter stringFromDate:nextDay];
        [dates addObject: formattedDateString];
    }
    return dates;
}



- (void)updateChartData
{
//    if (self.shouldHideData)
//    {
//        chartView.data = nil;
//        return;
//    }
    
    [self setDataCount:100.0 range:30.0];
}

- (void)setDataCount:(int)count range:(double)range
{
//    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
//    NSTimeInterval hourSeconds = 3600.0;
//    
//    NSMutableArray *values = [[NSMutableArray alloc] init];
//    
//    NSTimeInterval from = now - (count / 2.0) * hourSeconds;
//    NSTimeInterval to = now + (count / 2.0) * hourSeconds;
//    
//    for (NSTimeInterval x = from; x < to; x += hourSeconds)
//    {
//        double y = arc4random_uniform(range) + 50;
//        [values addObject:[[ChartDataEntry alloc] initWithX:x y:y]];
//    }
//    
//    NSMutableArray *Vals1 = [[NSMutableArray alloc] init];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:1.0 y:2.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:2.0 y:3.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:3.0 y:1.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:4.0 y:6.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:5.0 y:10.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:6.0 y:1.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:7.0 y:2.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:8.0 y:3.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:9.0 y:1.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:10.0 y:6.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:11.0 y:10.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:12.0 y:1.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:13.0 y:2.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:14.0 y:3.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:15.0 y:1.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:16.0 y:6.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:17.0 y:10.0]];
//    [Vals1 addObject:[[ChartDataEntry alloc]initWithX:18.0 y:1.0]];
    
    NSMutableArray *values = [[NSMutableArray alloc]init];
    
    
    LineChartDataSet *set1 = nil;
    if (chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)chartView.data.dataSets[0];
        set1.values = values;
        [chartView.data notifyDataChanged];
        [chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet 1"];
        set1.mode = LineChartModeCubicBezier;
        set1.cubicIntensity = 0.2;
        set1.axisDependency = AxisDependencyLeft;
        set1.valueTextColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
        set1.lineWidth = 1.5;
        set1.drawCirclesEnabled = YES;
        set1.drawValuesEnabled = NO;
        set1.fillAlpha = 0.26;
        set1.fillColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
        set1.highlightColor = [UIColor colorWithRed:224/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
        set1.drawCircleHoleEnabled = NO;
        set1.drawFilledEnabled = YES;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.whiteColor];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.0]];
        
        chartView.data = data;
        [chartView setVisibleXRangeMaximum:3600 * 24];
        [chartView moveViewToX:90];
        
    }
}
#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    //int selectedValue = (int)entry.y;
    //NSLog(@"%@", self.ratingsArray[selectedValue - 1]);
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}



@end
