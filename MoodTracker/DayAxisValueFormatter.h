//
//  DayAxisValueFormatter.h
//  MoodTracker
//
//  Created by Eli MArshall on 11/27/16.
//  Copyright © 2016 Eli MArshall. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Charts;

@interface DayAxisValueFormatter : NSObject <IChartAxisValueFormatter>
- (id)initForChart:(BarLineChartViewBase *)chart;
@end
