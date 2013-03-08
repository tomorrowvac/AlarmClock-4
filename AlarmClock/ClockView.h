//
//  ClockView.h
//  AlarmClock
//
//  Created by Krzysztof Kulesza on 08.03.13.
//
//

#import <UIKit/UIKit.h>

@interface ClockView : UIView

@property(retain) NSDate *time;
@property(nonatomic, retain, readonly) NSCalendar *calendar;

- (void)startAnimation;
- (void)stopAnimation;
@end
