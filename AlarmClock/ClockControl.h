//
//  ClockControl.h
//  AlarmClock
//
//  Created by Krzysztof Kulesza on 10.03.13.
//
//

#import <UIKit/UIKit.h>

@interface ClockControl : UIControl
@property(nonatomic) NSTimeInterval time;
@property (nonatomic) CGFloat angle;

- (CGFloat)angleWithPoint:(CGPoint)inPoint;

@end
