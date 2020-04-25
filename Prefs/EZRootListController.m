#include "EZRootListController.h"

//#define ezswipepath @"/User/Library/Preferences/com.imkpatil.ezswipe.plist"

@implementation EZRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"EZSwipe" target:self] retain];
	}

	return _specifiers;
}

// -(id) readPreferenceValue:(PSSpecifier*)specifier {
//     NSDictionary *ezswipeSettings = [NSDictionary dictionaryWithContentsOfFile:ezswipepath];
//     if (!ezswipeSettings[specifier.properties[@"key"]]) {
//         return specifier.properties[@"default"];
//     }
//     return ezswipeSettings[specifier.properties[@"key"]];
// }
//
// -(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
//     NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
//     [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:ezswipepath]];
//     [defaults setObject:value forKey:specifier.properties[@"key"]];
//     [defaults writeToFile:ezswipepath atomically:YES];
//     //  NSDictionary *powercolorSettings = [NSDictionary dictionaryWithContentsOfFile:powercolorPath];
//     CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
//     if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
// }

@end
