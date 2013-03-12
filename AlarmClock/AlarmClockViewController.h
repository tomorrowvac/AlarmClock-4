//
//  AlarmClockViewController.h
//  AlarmClock
//
//  Created by Krzysztof Kulesza on 08.03.13.
//
//

#import <UIKit/UIKit.h>
#import "ClockView.h"
#import "ClockControl.h"

@interface AlarmClockViewController : UIViewController

@property (retain, nonatomic) IBOutlet ClockView *clockView;
@property (retain, nonatomic) IBOutlet ClockControl *clockControl;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UISwitch *alarmSwitch;
- (IBAction)updateTimeLabel;
- (IBAction)updateAlarmHand:(UIGestureRecognizer *)inRecognizer;
- (IBAction)updateAlarm;
@end
