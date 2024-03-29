//
//  ClockView.m
//  AlarmClock
//
//  Created by Krzysztof Kulesza on 08.03.13.
//
//

#import "ClockView.h"
#import "UIView_AlarmClock.h"

@interface ClockView()

@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain, readwrite) NSCalendar *calendar;

@end

@implementation ClockView

@synthesize time;
@synthesize calendar;
@synthesize timer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)inCoder{
    self = [super initWithCoder:inCoder];
    if (self) {
        self.calendar = [NSCalendar currentCalendar];
        self.time = [NSDate date];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.calendar = [NSCalendar currentCalendar];
    self.time = [NSDate date];
}

- (void)startAnimation {
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    }
}

-(void)stopAnimation {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;

    }
}

- (void)updateTime:(NSTimer *)inTimer {
    self.time = [NSDate date];
    [self setNeedsDisplay];
}

- (void)drawClockHands {
    CGContextRef theContext = UIGraphicsGetCurrentContext();
    CGPoint theCenter = [self midPoint];
    CGFloat theRadius = CGRectGetWidth(self.bounds) / 2.0;
    
    NSDateComponents *theComponents = [self.calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self.time];
    CGFloat theSecond = theComponents.second * M_PI / 30.0;
    CGFloat theMinute = theComponents.minute * M_PI / 30.0;
    CGFloat theHour = (theComponents.hour + theComponents.minute / 60) * M_PI / 6.0;
    
    CGPoint thePoint = [self pointWithRadius:theRadius * 0.7 angle:theHour];
    CGContextSetRGBStrokeColor(theContext, 0.25, 0.25, 0.25, 1.0);
    CGContextSetLineWidth(theContext, 7.0);
    CGContextSetLineCap(theContext, kCGLineCapButt);
    CGContextMoveToPoint(theContext, theCenter.x, theCenter.y);
    CGContextAddLineToPoint(theContext, thePoint.x, thePoint.y);
    CGContextStrokePath(theContext);
    
    thePoint = [self pointWithRadius:theRadius * 0.9 angle:theMinute];
    CGContextSetLineWidth(theContext, 5.0);
    CGContextMoveToPoint(theContext, theCenter.x, theCenter.y);
    CGContextAddLineToPoint(theContext, thePoint.x, thePoint.y);
    CGContextStrokePath(theContext);
    
    thePoint = [self pointWithRadius:theRadius * 0.95 angle:theSecond];
    CGContextSetLineWidth(theContext, 3.0);
    CGContextSetRGBStrokeColor(theContext, 1.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(theContext, theCenter.x, theCenter.y);
    CGContextAddLineToPoint(theContext, thePoint.x, thePoint.y);
    CGContextStrokePath(theContext);
    
    CGContextAddArc(theContext, theCenter.x, theCenter.y, 6.0, 0.0, 2 * M_PI, YES);
    CGContextFillPath(theContext);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef theContext = UIGraphicsGetCurrentContext();
    CGRect theBounds = self.bounds;
    CGFloat theRadius = CGRectGetWidth(theBounds) / 2.0;
    
    CGContextSaveGState(theContext);
    CGContextSetRGBFillColor(theContext, 1.0, 1.0, 1.0, 1.0);
    CGContextAddEllipseInRect(theContext, theBounds);
    CGContextFillPath(theContext);
    CGContextAddEllipseInRect(theContext, theBounds);
    CGContextClip(theContext);
    
    CGContextSetRGBStrokeColor(theContext, 0.25, 0.25, 0.25, 1);
    CGContextSetRGBFillColor(theContext, 0.25, 0.25, 0.25, 1);
    CGContextSetLineWidth(theContext, 7.0);
    CGContextSetLineCap(theContext, kCGLineCapRound);
    for (NSInteger i = 0; i < 60; ++i) {
        CGFloat theAngle = i * M_PI / 30.0;
        if (i % 5 == 0) {
            CGFloat theInnerRadius = theRadius * (i % 15 == 0 ? 0.7 : 0.8);
            CGPoint theInnerPoint = [self pointWithRadius:theInnerRadius angle:theAngle];
            CGPoint theOuterPoint = [self pointWithRadius:theRadius * 0.95 angle:theAngle];
            CGContextMoveToPoint(theContext, theInnerPoint.x, theInnerPoint.y);
            CGContextAddLineToPoint(theContext, theOuterPoint.x, theOuterPoint.y);
            CGContextStrokePath(theContext);
        }
        else {
            CGPoint thePoint = [self pointWithRadius:theRadius * 0.95 angle:theAngle];
            CGContextAddArc(theContext, thePoint.x, thePoint.y, 3.0, 0.0, 2 * M_PI, YES);
            CGContextFillPath(theContext);
        }
    }
    
    [self drawClockHands];
    CGContextRestoreGState(theContext);
}

- (void)dealloc {
    self.calendar = nil;
    self.time = nil;
    [super dealloc];
}
@end
