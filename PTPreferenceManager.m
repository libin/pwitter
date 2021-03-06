//
//  PTPreferenceManager.m
//  Pwitter
//
//  Created by Akihiro Noguchi on 26/12/08.
//  Copyright 2008 Aki. All rights reserved.
//

#import "PTPreferenceManager.h"
#import "EMKeychainProxy.h"


@implementation PTPreferenceManager

+ (PTPreferenceManager *)sharedInstance
{
	static PTPreferenceManager *instance;
	
	@synchronized(self)
	{
		if (!instance)
		{
			instance = [[PTPreferenceManager alloc] init];
			[instance setupPreferences];
		}
		return instance;
	}
	return nil;
}

- (void)setupPreferences {
	fPrefData = [NSUserDefaults standardUserDefaults];
	if ([fPrefData integerForKey:@"time_interval"] == 0)
		[fPrefData setInteger:2 forKey:@"time_interval"];
	if ([fPrefData integerForKey:@"message_interval"] == 0)
		[fPrefData setInteger:3 forKey:@"message_interval"];
	if ([fPrefData integerForKey:@"status_update_behavior"] == 0)
		[fPrefData setInteger:1 forKey:@"status_update_behavior"];
}

- (void)setUserName:(NSString *)aUserName password:(NSString *)aPassword {
	[fPrefData setObject:aUserName forKey:@"user_name"];
	EMGenericKeychainItem *lTempItem = 
	[[EMKeychainProxy sharedProxy] genericKeychainItemForService:@"Pwitter" 
													withUsername:aUserName];
	if (!lTempItem) {
		[[EMKeychainProxy sharedProxy] addGenericKeychainItemForService:@"Pwitter" 
														   withUsername:aUserName 
															   password:aPassword];
	} else {
		[lTempItem setPassword:aPassword];
	}
}

- (NSString *)userName {
	return [fPrefData stringForKey:@"user_name"];
}

- (NSString *)password {
	EMGenericKeychainItem *lTempItem = 
	[[EMKeychainProxy sharedProxy] genericKeychainItemForService:@"Pwitter" 
													withUsername:[fPrefData stringForKey:@"user_name"]];
	if (!lTempItem) {
		return nil;
	} else {
		return [lTempItem password];
	}
}

- (void)setAlwaysOnTop:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"always_on_top"];
}

- (BOOL)alwaysOnTop {
	return [fPrefData boolForKey:@"always_on_top"];
}

- (void)setReceiveFromNonFollowers:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"receive_updates_from_non_followers"];
}

- (BOOL)receiveFromNonFollowers {
	return [fPrefData boolForKey:@"receive_updates_from_non_followers"];
}

- (void)setTimeInterval:(int)aInterval {
	[fPrefData setInteger:aInterval forKey:@"time_interval"];
}

- (int)timeInterval {
	return [fPrefData integerForKey:@"time_interval"];
}

- (void)setMessageInterval:(int)aInterval {
	[fPrefData setInteger:aInterval forKey:@"message_interval"];
}

- (int)messageInterval {
	return [fPrefData integerForKey:@"message_interval"];
}

- (void)setUseMiniView:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"enable_mini_view"];
}

- (BOOL)useMiniView {
	return [fPrefData boolForKey:@"enable_mini_view"];
}

- (void)setAutoLogin:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"auto_login"];
}

- (BOOL)autoLogin {
	return [fPrefData boolForKey:@"auto_login"];
}

- (void)setQuickPost:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"use_quick_post"];
}

- (BOOL)quickPost {
	return [fPrefData boolForKey:@"use_quick_post"];
}

- (void)setIgnoreErrors:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"ignore_errors"];
}

- (BOOL)ignoreErrors {
	return [fPrefData boolForKey:@"ignore_errors"];
}

- (void)setDisableGrowl:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"disable_growl"];
}

- (BOOL)disableGrowl {
	return [fPrefData boolForKey:@"disable_growl"];
}

- (void)setDisableMessageNotification:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"disable_message_notification"];
}

- (BOOL)disableMessageNotification {
	return [fPrefData boolForKey:@"disable_message_notification"];
}

- (void)setDisableReplyNotification:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"disable_reply_notification"];
}

- (BOOL)disableReplyNotification {
	return [fPrefData boolForKey:@"disable_reply_notification"];
}

- (void)setDisableStatusNotification:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"disable_status_notification"];
}

- (BOOL)disableStatusNotification {
	return [fPrefData boolForKey:@"disable_status_notification"];
}

- (void)setDisableErrorNotification:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"disable_error_notification"];
}

- (BOOL)disableErrorNotification {
	return [fPrefData boolForKey:@"disable_error_notification"];
}

- (void)setDisableSoundNotification:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"disable_sound_notification"];
}

- (BOOL)disableSoundNotification {
	return [fPrefData boolForKey:@"disable_sound_notification"];
}

- (void)setStatusUpdateBehavior:(int)aBehavior {
	[fPrefData setInteger:aBehavior forKey:@"status_update_behavior"];
}

- (int)statusUpdateBehavior {
	return [fPrefData integerForKey:@"status_update_behavior"];
}

- (void)setSwapMenuItemBehavior:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"swap_menu_item_behavior"];
}

- (BOOL)swapMenuItemBehavior {
	return [fPrefData boolForKey:@"swap_menu_item_behavior"];
}

- (void)setUseTwelveHour:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"use_twelve_hour"];
}

- (BOOL)useTwelveHour {
	return [fPrefData boolForKey:@"use_twelve_hour"];
}

- (void)setDisableTopView:(BOOL)aFlag {
	[fPrefData setBool:aFlag forKey:@"disable_top_view"];
}

- (BOOL)disableTopView {
	return [fPrefData boolForKey:@"disable_top_view"];
}

- (void)setHideDockIcon:(BOOL)aFlag {
	NSString * lFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/../Info.plist"];
	if (lFilePath) {
		if ([[NSFileManager defaultManager] isWritableFileAtPath:lFilePath]) {
			NSMutableDictionary* lPlistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:lFilePath];
			[lPlistDict setValue:[NSNumber numberWithBool:aFlag] forKey:@"LSUIElement"];
			[lPlistDict writeToFile:lFilePath atomically: YES];
			[lPlistDict release];
		}
	}
}

- (BOOL)hideDockIcon {
	NSString *lFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/../Info.plist"];
	NSMutableDictionary* lPlistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:lFilePath];
	BOOL lShouldHide = [[lPlistDict objectForKey:@"LSUIElement"] boolValue];
	[lPlistDict release];
	return lShouldHide;
}

@end
