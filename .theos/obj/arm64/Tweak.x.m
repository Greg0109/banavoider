#line 1 "Tweak.x"
#import <UIKit/UIKit.h>
#import <spawn.h>
#import <FrontBoardServices/FBSSystemService.h>

@interface SBLeafIcon : NSObject
-(void)launchFromLocation:(id)arg1 context:(id)arg2 ;
-(id)applicationBundleID;
@end

@interface FBSystemService : NSObject
+(id)sharedInstance;
-(void)shutdownAndReboot:(BOOL)arg1;
@end

@interface SBApplication
@property (nonatomic,readonly) NSString * bundleIdentifier;                                                                                     
@property (nonatomic,readonly) NSString * iconIdentifier;
@property (nonatomic,readonly) NSString * displayName;
@end

int modespecifier;


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

@class SBLeafIcon; @class FBSystemService; @class SpringBoard; 
static void (*_logos_orig$_ungrouped$SBLeafIcon$launchFromLocation$context$)(_LOGOS_SELF_TYPE_NORMAL SBLeafIcon* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$SBLeafIcon$launchFromLocation$context$(_LOGOS_SELF_TYPE_NORMAL SBLeafIcon* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$SpringBoard$frontDisplayDidChange$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, SBApplication *); static void _logos_method$_ungrouped$SpringBoard$frontDisplayDidChange$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, SBApplication *); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$FBSystemService(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("FBSystemService"); } return _klass; }
#line 23 "Tweak.x"

static void _logos_method$_ungrouped$SBLeafIcon$launchFromLocation$context$(_LOGOS_SELF_TYPE_NORMAL SBLeafIcon* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
  NSMutableDictionary *applist = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.greg0109.banavoiderapplist"];
  if ([[applist valueForKey:[self applicationBundleID]] boolValue]) {
    UIAlertController* alertCtrl = [UIAlertController alertControllerWithTitle:@"You are jailbroken!" message:@"Do you want to disable the jailbreak or exit?" preferredStyle:UIAlertControllerStyleAlert];
    [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Exit" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    if (modespecifier == 0) {
      [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Reboot" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[_logos_static_class_lookup$FBSystemService() sharedInstance] shutdownAndReboot:YES];}]];
    } else if (modespecifier == 1) {
      [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Safemode" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pid_t pid;
        int status;
        const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
        posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
        waitpid(pid, &status, WEXITED);
      }]];
    }
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertCtrl animated:YES completion:^{}];
  } else {
    _logos_orig$_ungrouped$SBLeafIcon$launchFromLocation$context$(self, _cmd, arg1, arg2);
  }
}



static void _logos_method$_ungrouped$SpringBoard$frontDisplayDidChange$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, SBApplication * arg1) {
  NSMutableDictionary *applist = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.greg0109.banavoiderapplist"];
  if ([[applist valueForKey:arg1.bundleIdentifier] boolValue]) {
    UIAlertController* alertCtrl = [UIAlertController alertControllerWithTitle:@"You are jailbroken!" message:@"Do you want to disable the jailbreak or exit?" preferredStyle:UIAlertControllerStyleAlert];
    [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Exit" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    if (modespecifier == 0) {
      [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Reboot" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[_logos_static_class_lookup$FBSystemService() sharedInstance] shutdownAndReboot:YES];}]];
    } else if (modespecifier == 1) {
      [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Safemode" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pid_t pid;
        int status;
        const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
        posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
        waitpid(pid, &status, WEXITED);
      }]];
    }
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertCtrl animated:YES completion:^{}];
  } else {
    _logos_orig$_ungrouped$SpringBoard$frontDisplayDidChange$(self, _cmd, arg1);
  }
}


static __attribute__((constructor)) void _logosLocalCtor_75581c0b(int __unused argc, char __unused **argv, char __unused **envp) {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingFormat:@"/Library/Preferences/com.greg0109.banavoiderprefs.plist"]];
	BOOL enabled = prefs[@"enabled"] ? [prefs[@"enabled"] boolValue] : NO;
  modespecifier = prefs[@"modespecifier"] ? [prefs[@"modespecifier"] intValue] : 0;
  if (enabled) {
    {Class _logos_class$_ungrouped$SBLeafIcon = objc_getClass("SBLeafIcon"); { MSHookMessageEx(_logos_class$_ungrouped$SBLeafIcon, @selector(launchFromLocation:context:), (IMP)&_logos_method$_ungrouped$SBLeafIcon$launchFromLocation$context$, (IMP*)&_logos_orig$_ungrouped$SBLeafIcon$launchFromLocation$context$);}Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); { MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(frontDisplayDidChange:), (IMP)&_logos_method$_ungrouped$SpringBoard$frontDisplayDidChange$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$frontDisplayDidChange$);}}
  }
}
