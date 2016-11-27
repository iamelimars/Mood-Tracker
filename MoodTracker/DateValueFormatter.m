//
//  DateValueFormatter.m
//  MoodTracker
//
//  Created by Eli MArshall on 11/25/16.
//  Copyright © 2016 Eli MArshall. All rights reserved.
//

#import "DateValueFormatter.h"

@implementation DateValueFormatter
{
    NSDateFormatter *_dateFormatter;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _dateFormatter = [[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = @"dd MMM HH:mm";
        
    }
    return self;
}

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    
    return [_dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:value]];
    
}

@end
