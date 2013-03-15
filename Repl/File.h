//
//  File.h
//  Repl
//
//  Created by Mikhail Ivanov on 15.03.13.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class List;
@class Menu;

@interface File : NSObject {
    // Поддерживаемые типы файлов
    NSArray *supportType;
    
    // Статусное меню
    NSMenu *statusMenu;
    
    // Список
    List *list;
    
    // Меню
    Menu *menu;
}

- (id)init;

- (void)getPath:(id)path forMenu:(id)smenu;
- (void)openFile:(id)files;

- (void)setList:(id)l;
- (void)setMenu:(id)m;

@end
