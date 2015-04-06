//
//  UIViewController+JDUIUpdates.m
//
//  Created by Johannes Dörr on 10.05.14.
//  Copyright (c) 2014 Johannes Dörr. All rights reserved.
//

#import "UIViewController+JDUIUpdates.h"
#import <objc/runtime.h>


static char updatesAreActivatedKey;


@implementation UIViewController (JDUIUpdates)

+ (void)load
{
    Method original, swizzled;
    original = class_getInstanceMethod(self, @selector(viewWillAppear:));
    swizzled = class_getInstanceMethod(self, @selector(jd_UIUpdates_viewWillAppear:));
    method_exchangeImplementations(original, swizzled);
    
    original = class_getInstanceMethod(self, @selector(viewWillDisappear:));
    swizzled = class_getInstanceMethod(self, @selector(jd_UIUpdates_viewWillDisappear:));
    method_exchangeImplementations(original, swizzled);
}

- (void)jd_UIUpdates_viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jd_UIUpdates_applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jd_UIUpdates_applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [self jd_UIUpdates_activateUIUpdates];
}

- (void)jd_UIUpdates_viewWillDisappear:(BOOL)animated
{
    [self jd_UIUpdates_deactivateUIUpdates];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)jd_UIUpdates_applicationWillEnterForeground:(NSNotification*)notification
{
    [self jd_UIUpdates_activateUIUpdates];
}

- (void)jd_UIUpdates_applicationDidEnterBackground:(NSNotification*)notification
{
    [self jd_UIUpdates_deactivateUIUpdates];
}

- (void)jd_UIUpdates_activateUIUpdates
{
    objc_setAssociatedObject(self, &updatesAreActivatedKey, @TRUE, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self conformsToProtocol:@protocol(JDUIUpdates)] && [self respondsToSelector:@selector(activateUIUpdates)]) {
        [self performSelector:@selector(activateUIUpdates)];
    }
}

- (void)jd_UIUpdates_deactivateUIUpdates
{
    objc_setAssociatedObject(self, &updatesAreActivatedKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self conformsToProtocol:@protocol(JDUIUpdates)] && [self respondsToSelector:@selector(deactivateUIUpdates)]) {
        [self performSelector:@selector(deactivateUIUpdates)];
    }
}

- (BOOL)uiUpdatesActivated
{
    NSObject *updatesAreActivated = objc_getAssociatedObject(self, &updatesAreActivatedKey);
    return [updatesAreActivated isEqual:@TRUE];
}

@end
