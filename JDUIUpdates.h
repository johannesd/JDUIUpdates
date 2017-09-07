//
//  JDUIUpdates.h
//  Pods
//
//  Created by Johannes Dörr on 30.05.16.
//
//

#import <Foundation/Foundation.h>

@protocol JDUIUpdates <NSObject>

@optional
- (void)activateUIUpdates;
- (void)deactivateUIUpdates;

@end
