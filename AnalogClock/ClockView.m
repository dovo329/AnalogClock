//
//  ClockView.m
//  AnalogClock
//
//  Created by Douglas Voss on 4/9/15.
//  Copyright (c) 2015 Doug. All rights reserved.
//

#import "ClockView.h"

@implementation ClockView


- (void)drawHand:(CGContextRef)context rect:(CGRect)rect radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth value:(int)value thresh:(int)thresh color:(UIColor *)color
{
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, lineWidth);
    UIColor *handColor = color;
    CGContextSetStrokeColorWithColor(context, handColor.CGColor);
    CGContextBeginPath(context);
    CGPoint center;
    center.x = CGRectGetMidX(rect);
    center.y = CGRectGetMidY(rect);
    CGContextMoveToPoint(context, center.x, center.y);
    CGFloat angle = ((2*M_PI)/thresh)*value;
    CGPoint handPoint;
    handPoint.x = center.x + sin(angle)*radius;
    handPoint.y = center.y + -cos(angle)*radius;
    CGContextAddLineToPoint(context, handPoint.x, handPoint.y);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();

    
    CGFloat hue, saturation, brightness, alpha;
    UIColor *color = [UIColor redColor];
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    //NSLog(@"hue=%f saturation=%f brightness=%f alpha=%f", hue, saturation, brightness, alpha);
    
    UIColor *topColor1 = [UIColor colorWithHue:hue saturation:(0.3*saturation) brightness:(1.0*brightness) alpha:alpha];
    UIColor *topColor2 = [UIColor colorWithHue:hue saturation:(0.8*saturation) brightness:(1.0*brightness) alpha:alpha];
    UIColor *bottomColor1 = [UIColor colorWithHue:hue saturation:(1.0*saturation) brightness:(1.0*brightness) alpha:alpha];
    UIColor *bottomColor2 = [UIColor colorWithHue:hue saturation:(1.0*saturation) brightness:(1.0*brightness) alpha:alpha];
    
    CGFloat topColor1Red, topColor1Green, topColor1Blue, topColor1Alpha;
    [topColor1 getRed:&topColor1Red green:&topColor1Green blue:&topColor1Blue alpha:&topColor1Alpha];
    
    CGFloat topColor2Red, topColor2Green, topColor2Blue, topColor2Alpha;
    [topColor2 getRed:&topColor2Red green:&topColor2Green blue:&topColor2Blue alpha:&topColor2Alpha];
    
    CGFloat bottomColor1Red, bottomColor1Green, bottomColor1Blue, bottomColor1Alpha;
    [bottomColor1 getRed:&bottomColor1Red green:&bottomColor1Green blue:&bottomColor1Blue alpha:&bottomColor1Alpha];
    
    CGFloat bottomColor2Red, bottomColor2Green, bottomColor2Blue, bottomColor2Alpha;
    [bottomColor2 getRed:&bottomColor2Red green:&bottomColor2Green blue:&bottomColor2Blue alpha:&bottomColor2Alpha];
    
    
    CGGradientRef topGradient;
    CGFloat topLocations[2] = { 0.0, 1.0 };
    CGFloat topComponents[4*2] = {
        topColor1Red, topColor1Green, topColor1Blue, topColor1Alpha,  // Start color
        topColor2Red, topColor2Green, topColor2Blue, topColor2Alpha   // End color
    };
    
    CGPoint startPoint, endPoint;
    startPoint.x = rect.origin.x;
    startPoint.y = rect.origin.y;
    endPoint.x = startPoint.x;
    endPoint.y = rect.origin.y+rect.size.height;
    topGradient = CGGradientCreateWithColorComponents (colorspace, topComponents,
                                                       topLocations, 2);
    
    CGContextSaveGState(context);
    CGContextDrawLinearGradient (context, topGradient, startPoint, endPoint, 0);
    CGGradientRelease (topGradient);
    CGContextRestoreGState(context);
    
    CGFloat lineWidth = 5.0;

    CGContextSaveGState(context);
    CGContextSetLineWidth(context, lineWidth);
    UIColor *circleColor = [UIColor blueColor];
    CGContextSetStrokeColorWithColor(context, circleColor.CGColor);
    CGRect clockRect;
    CGFloat diameter = MIN(rect.size.width, rect.size.height) - (lineWidth*2.0);
    CGFloat radius = diameter / 2.0;
    clockRect.size.width = diameter;
    clockRect.size.height = diameter;
    clockRect.origin.x = rect.origin.x + (rect.size.width/2.0) - (clockRect.size.width/2.0);
    clockRect.origin.y = rect.origin.y + (rect.size.height/2.0) - (clockRect.size.height/2.0);
    CGContextAddEllipseInRect(context, clockRect);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    
    [self drawHand:context rect:rect radius:radius lineWidth:1.0 value:self.seconds thresh:60.0 color:[UIColor purpleColor]];
    [self drawHand:context rect:rect radius:radius lineWidth:5.0 value:self.minutes thresh:60.0 color:[UIColor brownColor]];
    [self drawHand:context rect:rect radius:(radius/2.0) lineWidth:10.0 value:self.hours thresh:12.0 color:[UIColor orangeColor]];

    CGColorSpaceRelease (colorspace);
    
    [super drawRect:rect];

}

@end