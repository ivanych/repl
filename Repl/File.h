//
//  File.h
//  Repl
//
//  Created by Mikhail Ivanov on 15.03.13.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class List;

@interface File : NSObject {
    // Поддерживаемые типы файлов
    NSArray *supportType;
    
    // Статусное меню
    NSMenu *statusMenu;
    
    // Плейлист
    List *list;
}

- (id)init;

- (void)getPath:(id)path forMenu:(id)smenu;
- (void)openFile:(id)files;

- (void)setStatusMenu:(id)m;
- (void)setList:(id)l;

@end
