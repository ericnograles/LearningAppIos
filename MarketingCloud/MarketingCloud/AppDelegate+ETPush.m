//
//  AppDelegate+ETPush.m
//  Generated by the Salesforce Marketing Cloud App Accelerator.
//

#import "AppDelegate+ETPush.h"
#import "ETPush.h" // From the SDK
#import "AppDelegate+ETPushConstants.h"

@implementation AppDelegate (ETPush)

- (BOOL)application:(UIApplication *)application shouldInitETSDKWithOptions:(NSDictionary *)launchOptions {
    BOOL successful = NO;
    NSError *error = nil;
    
#ifdef DEBUG
    // Set to YES to enable logging while debugging
    [ETPush setETLoggerToRequiredState:YES];
    // configure and set initial settings of the JB4ASDK
    successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Debug
                                              andAccessToken:kETAccessToken_Debug
                                               withAnalytics:YES
                                         andLocationServices:YES
                                               andCloudPages:YES
                                             withPIAnalytics:YES
                                                       error:&error];
#else
    // configure and set initial settings of the JB4ASDK
    successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Prod
                                              andAccessToken:kETAccessToken_Prod
                                               withAnalytics:YES
                                         andLocationServices:YES
                                               andCloudPages:YES
                                             withPIAnalytics:YES
                                                       error:&error];
#endif
    //
    // if configureSDKWithAppID returns NO, check the error object for detailed failure info. See PushConstants.h for codes.
    // the features of the JB4ASDK will NOT be useable unless configureSDKWithAppID returns YES.
    //
    if (!successful) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // something failed in the configureSDKWithAppID call - show what the error is
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed configureSDKWithAppID!", @"Failed configureSDKWithAppID!")
                                        message:[error localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                              otherButtonTitles:nil] show];
        });
    }
    else {
        // register for push notifications - enable all notification types, no categories
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                UIUserNotificationTypeBadge |
                                                UIUserNotificationTypeSound |
                                                UIUserNotificationTypeAlert
                                                                                 categories:nil];
        
        [[ETPush pushManager] registerUserNotificationSettings:settings];
        [[ETPush pushManager] registerForRemoteNotifications];
        
        // inform the JB4ASDK of the launch options - possibly UIApplicationLaunchOptionsRemoteNotificationKey or UIApplicationLaunchOptionsLocalNotificationKey
        [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    // inform the JB4ASDK of the notification settings requested
    [[ETPush pushManager] didRegisterUserNotificationSettings:notificationSettings];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // inform the JB4ASDK of the device token
    [[ETPush pushManager] registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    // inform the JB4ASDK that the device failed to register and did not receive a device token
    [[ETPush pushManager] applicationDidFailToRegisterForRemoteNotificationsWithError:error];
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // inform the JB4ASDK that the device received a local notification
    [[ETPush pushManager] handleLocalNotification:notification];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler {
    
    // inform the JB4ASDK that the device received a remote notification
    [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];
    
    // is it a silent push?
    if (userInfo[@"aps"][@"content-available"]) {
        // received a silent remote notification...
        
        // indicate a silent push
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    }
    else {
        // received a remote notification...
        
        // clear the badge
        [[ETPush pushManager] resetBadgeCount];
    }
    
    handler(UIBackgroundFetchResultNoData);
}

@end
