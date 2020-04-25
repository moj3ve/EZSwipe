#import <UIKit/UIKit.h>

@interface SBSearchScrollView : UIScrollView
  -(BOOL)gestureRecognizerShouldBegin:(id)arg1 ;
@end

@interface SBControlCenterController : NSObject
  +(id)sharedInstance;
  - (void)presentAnimated:(BOOL)arg1;
@end

@interface SBCoverSheetSlidingViewController
  -(void)_dismissCoverSheetAnimated:(BOOL)arg1 withCompletion:(id)arg2;
  -(void)_presentCoverSheetAnimated:(BOOL)arg1 withCompletion:(id)arg2;
  -(void)_presentGestureBeganWithGestureRecognizer:(id)arg1;
  -(void)_handlePresentGesture:(id)arg1 ;
@end

@interface SBCoverSheetPresentationManager
  @property(retain, nonatomic) SBCoverSheetSlidingViewController *coverSheetSlidingViewController;
  @property(retain, nonatomic) SBCoverSheetSlidingViewController *secureAppSlidingViewController;
  +(id)sharedInstance;
  -(BOOL)isVisible;
  -(BOOL)isInSecureApp;
  -(void)setCoverSheetPresented:(BOOL)arg1 animated:(BOOL)arg2 withCompletion:(id)arg3;
@end

static BOOL IsEnabled = YES;
static NSString* LeftAction = @"CS";
static NSString* CenterAction = @"SL";
static NSString* RightAction = @"CC";
static CGFloat LeftSensitivity = 50.0;
static CGFloat RightSensitivity = 50.0;

static void LaunchCoverSheet()
{
  [[%c(SBCoverSheetPresentationManager) sharedInstance] setCoverSheetPresented:YES animated:YES withCompletion:nil];
}

static void LaunchCC()
{
  [[NSClassFromString(@"SBControlCenterController") sharedInstance] presentAnimated:YES];
}

%hook SBSearchScrollView

-(BOOL)gestureRecognizerShouldBegin:(id)arg1 {
  BOOL OrigVal = %orig;
  if (OrigVal)
  {
    if (IsEnabled)
    {
      CGRect screenRect = [[UIScreen mainScreen] bounds];
      CGFloat screenWidth = screenRect.size.width;
      //CGFloat screenHeight = screenRect.size.height;

      CGPoint TmpPoint = [arg1 locationInView:self.window];

      if ((int)TmpPoint.x <= (int)LeftSensitivity)
      {
        if([LeftAction isEqualToString:@"CS"])
        {
          //[arg1 setTranslation:CGPointMake(0,0) inView:self.window];
          LaunchCoverSheet();
        }
        else if ([LeftAction isEqualToString:@"SL"])
        {
          return OrigVal;
        }
        else if ([LeftAction isEqualToString:@"CC"])
        {
          LaunchCC();
        }
        else
        {
          return NO;
        }
      }
      else if ((int)TmpPoint.x >= (int)(screenWidth - RightSensitivity))
      {
        if([RightAction isEqualToString:@"CS"])
        {
          //[arg1 setTranslation:CGPointMake(0,0) inView:self.window];
          LaunchCoverSheet();
        }
        else if ([RightAction isEqualToString:@"SL"])
        {
          return OrigVal;
        }
        else if ([RightAction isEqualToString:@"CC"])
        {
          LaunchCC();
        }
        else
        {
          return NO;
        }
      }
      else
      {
        if([CenterAction isEqualToString:@"CS"])
        {
          //[arg1 setTranslation:CGPointMake(0,0) inView:self.window];
          LaunchCoverSheet();
        }
        else if ([CenterAction isEqualToString:@"SL"])
        {
          return OrigVal;
        }
        else if ([CenterAction isEqualToString:@"CC"])
        {
          LaunchCC();
        }
        else
        {
          return NO;
        }
      }

      return NO;

    }
    else
    {
      return OrigVal;
    }

  }

  return OrigVal;
}

%end

static void reloadSettings() {
  static CFStringRef EZSwipePrefsKey = CFSTR("com.imkpatil.ezswipe");
  CFPreferencesAppSynchronize(EZSwipePrefsKey);

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"TwkEnabled", EZSwipePrefsKey))) {
    IsEnabled = [(id)CFPreferencesCopyAppValue((CFStringRef)@"TwkEnabled", EZSwipePrefsKey) boolValue];
  }

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"LeftSwipe", EZSwipePrefsKey))) {
    LeftAction = [(id)CFPreferencesCopyAppValue((CFStringRef)@"LeftSwipe", EZSwipePrefsKey) stringValue];
  }

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"CenterSwipe", EZSwipePrefsKey))) {
    CenterAction = [(id)CFPreferencesCopyAppValue((CFStringRef)@"CenterSwipe", EZSwipePrefsKey) stringValue];
  }

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"RightSwipe", EZSwipePrefsKey))) {
    RightAction = [(id)CFPreferencesCopyAppValue((CFStringRef)@"RightSwipe", EZSwipePrefsKey) stringValue];
  }

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"LeftSense", EZSwipePrefsKey))) {
    LeftSensitivity = [(id)CFPreferencesCopyAppValue((CFStringRef)@"LeftSense", EZSwipePrefsKey) floatValue];
  }

  if (CFBridgingRelease(CFPreferencesCopyAppValue((CFStringRef)@"RightSense", EZSwipePrefsKey))) {
    RightSensitivity = [(id)CFPreferencesCopyAppValue((CFStringRef)@"RightSense", EZSwipePrefsKey) floatValue];
  }

}

%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadSettings, CFSTR("com.imkpatil.ezswipe.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
  reloadSettings();
  // if ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.apple.springboard"]) {
  //
  //       //reloadSettings(nil, nil, nil, nil, nil);
  //   }
}
