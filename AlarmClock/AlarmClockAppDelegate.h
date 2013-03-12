//
//  AlarmClockAppDelegate.h
//  AlarmClock
//
//  Created by Krzysztof Kulesza on 08.03.13.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class AlarmClockViewController;

@interface AlarmClockAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSNumber *soundId;
@property (strong, nonatomic) AlarmClockViewController *viewController;

@end
