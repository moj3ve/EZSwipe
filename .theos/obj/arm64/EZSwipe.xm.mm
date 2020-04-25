#line 1 "EZSwipe.xm"
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


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBSearchScrollView; @class SBCoverSheetPresentationManager; 
static BOOL (*_logos_orig$_ungrouped$SBSearchScrollView$gestureRecognizerShouldBegin$)(_LOGOS_SELF_TYPE_NORMAL SBSearchScrollView* _LOGOS_SELF_CONST, SEL, id); static BOOL _logos_method$_ungrouped$SBSearchScrollView$gestureRecognizerShouldBegin$(_LOGOS_SELF_TYPE_NORMAL SBSearchScrollView* _LOGOS_SELF_CONST, SEL, id); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBCoverSheetPresentationManager(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBCoverSheetPresentationManager"); } return _klass; }
#line 35 "EZSwipe.xm"
static void LaunchCoverSheet()
{
  [[_logos_static_class_lookup$SBCoverSheetPresentationManager() sharedInstance] setCoverSheetPresented:YES animated:YES withCompletion:nil];
}

static void LaunchCC()
{
  [[NSClassFromString(@"SBControlCenterController") sharedInstance] presentAnimated:YES];
}



static BOOL _logos_method$_ungrouped$SBSearchScrollView$gestureRecognizerShouldBegin$(_LOGOS_SELF_TYPE_NORMAL SBSearchScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
  BOOL OrigVal = _logos_orig$_ungrouped$SBSearchScrollView$gestureRecognizerShouldBegin$(self, _cmd, arg1);
  if (OrigVal)
  {
    if (IsEnabled)
    {
      CGRect screenRect = [[UIScreen mainScreen] bounds];
      CGFloat screenWidth = screenRect.size.width;
      

      CGPoint TmpPoint = [arg1 locationInView:self.window];

      if ((int)TmpPoint.x <= (int)LeftSensitivity)
      {
        if([LeftAction isEqualToString:@"CS"])
        {
          
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

static __attribute__((constructor)) void _logosLocalCtor_3e1f2675(int __unused argc, char __unused **argv, char __unused **envp) {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadSettings, CFSTR("com.imkpatil.ezswipe.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
  reloadSettings();
  
  
  
  
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBSearchScrollView = objc_getClass("SBSearchScrollView"); MSHookMessageEx(_logos_class$_ungrouped$SBSearchScrollView, @selector(gestureRecognizerShouldBegin:), (IMP)&_logos_method$_ungrouped$SBSearchScrollView$gestureRecognizerShouldBegin$, (IMP*)&_logos_orig$_ungrouped$SBSearchScrollView$gestureRecognizerShouldBegin$);} }
#line 173 "EZSwipe.xm"
