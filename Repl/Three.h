//
//  Three.h
//  Repl
//
//  Created by Mikhail Ivanov on 10.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class List;

@interface Three : NSObject{
    NSMenu *statusMenu;
    
    // Поддерживаемые типы файлов
    NSArray *supportType;
    
    // Плейлист
    List *list;
}

- (id)init;

- (void)getPath:(id)path forMenu:(id)menu;

- (void)markItem:(id)item state:(NSUInteger)state;
- (void)markMenu:(NSUInteger)number;

- (void)markRndMenuItem:(NSInteger)state;

- (void)setMenu:(id)m;
- (void)setList:(id)l;

@end
