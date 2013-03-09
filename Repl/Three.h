//
//  Three.h
//  Repl
//
//  Created by Mikhail Ivanov on 10.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "List.h"

@interface Three : NSObject{
    NSUInteger playItem;
    NSMenu *statusMenu;
    
    // Плейлист
    List *list;
}

- (id)init;

- (void)getPath:(id)path forMenu:(id)menu toList:(id)list;

- (void)markItem:(id)item state:(NSUInteger)state;
- (void)markMenu:(NSUInteger)number;

- (void)setMenu:(id)m;
- (void)setList:(id)l;

@end
