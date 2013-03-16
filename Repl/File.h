//
//  File.h
//  Repl
//
//  Created by Mikhail Ivanov on 15.03.13.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Menu;
@class List;

@interface File : NSObject {
    // Поддерживаемые типы файлов
    NSArray *supportType;
    
    // Меню
    Menu *menu;
    
    // Список
    List *list;
}

- (id)init;

- (void)getPath:(id)path forMenu:(id)smenu;
- (void)openFile:(id)files;

- (void)setMenu:(id)m;
- (void)setList:(id)l;

@end
