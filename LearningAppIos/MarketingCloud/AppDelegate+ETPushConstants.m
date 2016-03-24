/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "AppDelegate+ETPushConstants.h"

@implementation AppDelegate (ETPushConstants)

// Code@ AppIDs and Access Tokens for the debug and production versions of your app
// These values should be stored securely by your application or retrieved from a remote server
NSString *const kETAppID_Debug                       = @"d6684160-1bb0-4598-b6bf-23c43bc279a2";
NSString *const kETAccessToken_Debug                 = @"fdyervvwyar4zfuqf8776rwq";
NSString *const kETAppID_Prod                        = @"app id prod";
NSString *const kETAccessToken_Prod                  = @"access token prod";

// Constants used for Strings
NSString *const kMessageTypeLocation                 = @"Location";
NSString *const kUserDefaultsLastPushReceivedDate    = @"ud_lastPushReceivedDate";
NSString *const kUserDefaultsPushUserInfo            = @"ud_pushUserInfo";
NSString *const kUserDefaultsMessageType             = @"ud_messageType";
NSString *const kUserDefaultsAlertText               = @"ud_alertText";
NSString *const kMessageDetailCustomKeyDiscountCode  = @"discount_code";
NSString *const kPushDefineOpenDirectPayloadKey      = @"_od";
NSString *const kPushDefineCloudPagePayloadKey       = @"_x";
NSString *const kPushDefinePersistentNotificationKey = @"_p";

@end