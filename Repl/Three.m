//
//  Three.m
//  Repl
//
//  Created by ivan ivanych on 10.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Three.h"


@implementation Three

- (void)getPath:(id)path forMenu:(id)menu {
    // Пропускаем скрытые файлы
    NSRange isHidden = [path rangeOfString:@"/."];
    if (isHidden.length) {
        NSLog(@"file: %@ (скрытый файл, пропускаем)", path);
        return;
    }
    
    // Выделяем из пути название файла
    NSString *fileName = [path lastPathComponent];
    
    // Файл-менеджер
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isDir;
    
    // Если файл является каталогом
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        NSLog(@"dir-> %@", path);
        
        // Создаем пунт меню и субменю для него
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:fileName action:nil keyEquivalent:@""];
        NSMenu *subMenu = [[NSMenu alloc] initWithTitle:fileName];
        [menuItem setSubmenu:subMenu];
        [menu addItem:menuItem];
        
        NSLog(@"menu title: %@", [menu title]);
        NSLog(@"item title: %@", [menuItem title]);
        NSLog(@"subm title: %@", [subMenu title]);
        
        //Читаем содержимое каталога
        NSArray * dir = [fileManager contentsOfDirectoryAtPath:path error:nil];
        
        // Перебор содержимого каталога
        for (NSArray *d in dir) {
            // Полный путь к файлу каталога
            NSString *fullpath = [NSString stringWithFormat:@"%@/%@", path, d];
            
            [self getPath:fullpath forMenu:subMenu];
        }
    }
    // Если файл является файлом
    else {
        NSLog(@"file: %@", path);
        
        // Создаем пунт меню
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:fileName action:nil keyEquivalent:@""];
        [menu addItem:menuItem];
        
        NSLog(@"menu title: %@", [menu title]);
        NSLog(@"item title: %@", [menuItem title]);
    }
}

@end
