//
//  Menu.h
//  Repl
//
//  Created by Mikhail Ivanov on 10.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class List;

@interface Menu : NSObject {
    NSMenu *statusMenu;

    // Список
    List *list;
}
    
- (void)markItem:(id)item state:(NSUInteger)state;
- (void)markMenu:(NSUInteger)number;

- (void)markRndMenuItem:(NSInteger)state;

- (void)unlock;
- (id)trackMenu;

- (void)setStatusMenu:(id)m;
- (void)setList:(id)l;

@end
