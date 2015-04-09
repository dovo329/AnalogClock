//
//  ViewController.m
//  AnalogClock
//
//  Created by Douglas Voss on 4/9/15.
//  Copyright (c) 2015 Doug. All rights reserved.
//

#import "ViewController.h"
#import "ClockView.h"

@interface ViewController ()

@property (nonatomic) NSTimer *timer;
@property (nonatomic) ClockView *view;

@end

@implementation ViewController

- (void)timerHandler
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    int seconds = [[dateFormatter stringFromDate:now] intValue];
    dateFormatter.dateFormat = @"mm";
    int minutes = [[dateFormatter stringFromDate:now] intValue];
    dateFormatter.dateFormat = @"hh";
    int hours = [[dateFormatter stringFromDate:now] intValue];
    NSLog(@"The Current Time is hour: %d, min: %d, sec: %d", hours, minutes, seconds);
    
    self.view.seconds = seconds;
    self.view.minutes = minutes;
    self.view.hours   = hours;
    [self.view setNeedsDisplay];
}

- (void)loadView
{
    self.view = [[ClockView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.seconds = 0.0;
    self.view.minutes = 0.0;
    self.view.hours = 0.0;
    self.view.color = [UIColor purpleColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // fire the timerHandler every second
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(timerHandler)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
