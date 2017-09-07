//
//  UITableViewController+JDUIUpdates.m
//
//  Created by Johannes Dörr on 17.08.14.
//  Copyright (c) 2014 Johannes Dörr. All rights reserved.
//

#import "UITableViewController+JDUIUpdates.h"
#import <JDBindings/NSObject+JDOneWayBinding.h>
#import <objc/runtime.h>
#import <BlocksKit/NSObject+BKBlockExecution.h>

@implementation UITableViewController (JDUIUpdates)

//+ (void)load
//{
//    Method original, swizzled;
//    original = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
//    swizzled = class_getInstanceMethod(self, @selector(jd_UIUpdates_dealloc));
//    method_exchangeImplementations(original, swizzled);
//}

- (void)jd_UIUpdates_activateUIUpdates
{
    [super jd_UIUpdates_activateUIUpdates];
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    [self.tableView reloadData];
    [NSObject bk_performBlock:^{
        for (NSIndexPath *indexPath in indexPaths) {
            [self.tableView selectRowAtIndexPath:indexPath animated:FALSE scrollPosition:UITableViewScrollPositionNone];
        }
        for (NSIndexPath *indexPath in indexPaths) {
            [self.tableView deselectRowAtIndexPath:indexPath animated:TRUE];
        }
    } afterDelay:0];
//    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationNone];
}

- (void)jd_UIUpdates_deactivateUIUpdates
{
    [super jd_UIUpdates_deactivateUIUpdates];
    [self removeBindingsFromVisibleCells];
}

//- (void)jd_UIUpdates_dealloc
//{
//    [self removeBindingsFromVisibleCells];
//    [self jd_UIUpdates_dealloc];
//}

- (void)removeBindingsFromVisibleCells
{
//    NSLog(@"remove bindings: %@", self.tableView.indexPathsForVisibleRows.description);
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        [cell removeAllBindings];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell removeAllBindings];
}

@end
