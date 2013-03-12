//
//  AlarmClockAppDelegate.m
//  AlarmClock
//
//  Created by Krzysztof Kulesza on 08.03.13.
//
//

#import "AlarmClockAppDelegate.h"

#import "AlarmClockViewController.h"

@implementation AlarmClockAppDelegate

@synthesize soundId;


- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[AlarmClockViewController alloc] initWithNibName:@"AlarmClockViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    self.soundId = nil;
}

- (void)application:(UIApplication *)inApplication didReceiveLocalNotification:(UILocalNotification *)inNotification {
    if(inApplication.applicationState == UIApplicationStateActive) {
        UIAlertView *theAlert = [[UIAlertView alloc]initWithTitle:nil message:inNotification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [theAlert show];
        [theAlert release];
        [self playSound];
    }
}

- (NSNumber *)soundId {
    if (soundId == nil) {
        NSURL *theURL = [[NSBundle mainBundle] URLForResource:@"ringtone" withExtension:@"caf"];
        SystemSoundID theId;
        if (AudioServicesCreateSystemSoundID((CFURLRef) theURL, &theId) == kAudioServicesNoError) {
            self.soundId = [NSNumber numberWithUnsignedInt:theId];
        }
    }
    return soundId;
}


- (void)playSound {
    NSNumber *theId = self.soundId;
    if (theId) {
        AudioServicesPlaySystemSound([theId unsignedIntValue]);
    }
}

- (void)setSoundId:(NSNumber *)inSoundId {
    if(soundId != nil){
        AudioServicesDisposeSystemSoundID([soundId unsignedIntValue]);
        [soundId release];
    }
    soundId = [inSoundId retain];
}
    
@end
