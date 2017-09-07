//
//  UIView+JDUIUpdates.h
//  Pods
//
//  Created by Johannes Dörr on 30.05.16.
//
//

#import <UIKit/UIKit.h>
#import "JDUIUpdates.h"

@interface UIView (JDUIUpdates)

- (void)jd_UIUpdates_activateUIUpdates;
- (void)jd_UIUpdates_deactivateUIUpdates;

@property (nonatomic, assign, readonly) BOOL uiUpdatesActivated;

@end
