//
//  UIViewController+JDUIUpdates.h
//
//  Created by Johannes Dörr on 10.05.14.
//  Copyright (c) 2014 Johannes Dörr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDUIUpdates.h"


@interface UIViewController (JDUIUpdates)

- (void)jd_UIUpdates_activateUIUpdates;
- (void)jd_UIUpdates_deactivateUIUpdates;

@property (nonatomic, assign, readonly) BOOL uiUpdatesActivated;

@end
