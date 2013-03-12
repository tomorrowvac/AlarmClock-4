//
//  ClockControl.m
//  AlarmClock
//
//  Created by Krzysztof Kulesza on 10.03.13.
//
//

#import "ClockControl.h"
#import "UIView_AlarmClock.h"

@interface ClockControl()
@property(nonatomic) CGFloat savedAngle;
@end

@implementation ClockControl
@synthesize time;
@synthesize savedAngle;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGFloat)angle {
    return self.time * M_PI / 21600.0;
}

- (void)setAngle:(CGFloat)inAngle {
    self.time = 21600.0 * inAngle / M_PI;
}

- (CGFloat)angleWithPoint:(CGPoint)inPoint {
    CGPoint theCenter = [self midPoint];
    CGFloat theX = inPoint.x - theCenter.x;
    CGFloat theY = inPoint.y - theCenter.y;
    CGFloat theAngle = atan2f(theX, -theY);
    return theAngle < 0 ? theAngle + 2.0 * M_PI : theAngle;
}

- (BOOL)pointInside:(CGPoint)inPoint withEvent:(UIEvent *)inEvent {
    CGFloat theAngle = [self angleWithPoint:inPoint];
    CGFloat theDelta = fabs(theAngle - self.angle);
    return theDelta < 2 * M_PI / 180.0;
}
- (void)updateAngleWithTouch:(UITouch *)inTouch {
    CGPoint thePoint = [inTouch locationInView:self];
    self.angle = [self angleWithPoint:thePoint];
    [self setNeedsDisplay];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)inTouch withEvent:(UIEvent *)inEvent {
    self.savedAngle = self.angle;
    [self updateAngleWithTouch:inTouch];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)inTouch withEvent:(UIEvent *)inEvent {
    [self updateAngleWithTouch:inTouch];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)inTouch withEvent:(UIEvent *)inEvent {
    [self updateAngleWithTouch:inTouch];
}

- (void)cancelTrackingWithEvent:(UIEvent *)inEvent {
    self.angle = self.savedAngle;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef theContext = UIGraphicsGetCurrentContext();
    CGRect theBounds = self.bounds;
    CGPoint theCenter = [self midPoint];
    CGFloat theRadius = CGRectGetWidth(theBounds) / 2.0;
    CGPoint thePoint = [self pointWithRadius:theRadius * 0.7 angle:self.time * M_PI / 21600.0];
    CGContextSaveGState(theContext);
    CGContextSetRGBStrokeColor(theContext, 0.0, 0.0, 1.0, self.tracking ? 0.5 : 1.0);
    CGContextSetLineWidth(theContext, 7.0);
    CGContextSetLineCap(theContext, kCGLineCapRound);
    CGContextMoveToPoint(theContext, theCenter.x, theCenter.y);
    CGContextAddLineToPoint(theContext, thePoint.x, thePoint.y);
    CGContextStrokePath(theContext);
    CGContextRestoreGState(theContext);
}

@end
