//
//  File.m
//  Repl
//
//  Created by Mikhail Ivanov on 15.03.13.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import "File.h"
#import "Menu.h"
#import "List.h"

@implementation File

- (id)init {
    if (self = [super init]) {
        // Поддерживаемые типы файлов
        supportType = @[@"aiff", @"aif", @"aifc",
                        @"wave", @"wav",
                        @"au", @"ulw", @"snd",
                        @"mp3",
                        @"m4p", @"m4b",
                        @"m4a"
                        ];
    }
    
    return self;
}

- (void)getPath:(id)path forMenu:(id)smenu {
    NSLog(@"File.getPath -> path: %@", path);
    
    // Пропускаем скрытые файлы
    NSRange isHidden = [path rangeOfString:@"/."];
    if (isHidden.length) {
        NSLog(@"File.getPath - hidden file, skip!");
        
        return;
    }
    
    // Выделяем из пути название файла
    NSString *fileName = [path lastPathComponent];
    
    // Файл-менеджер
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isDir;
    
    // Если файл является каталогом
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        NSLog(@"File.getPath - is directory");
        
        // Создаем пункт меню и субменю для него
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:fileName action:nil keyEquivalent:@""];
        NSMenu *subMenu = [[NSMenu alloc] initWithTitle:fileName];
        [menuItem setSubmenu:subMenu];
        [smenu addItem:menuItem];
        
        NSLog(@"File.getPath - create menu");
        NSLog(@"File.getPath - menu title: %@", [smenu title]);
        NSLog(@"File.getPath - item title: %@", [menuItem title]);
        NSLog(@"File.getPath - subm title: %@", [subMenu title]);
        
        //Читаем содержимое каталога
        NSArray * dir = [fileManager contentsOfDirectoryAtPath:path error:nil];
        
        // Перебор содержимого каталога
        NSLog(@"File.getPath - read directory");
        for (NSArray *d in dir) {
            // Полный путь к файлу каталога
            NSString *fullpath = [NSString stringWithFormat:@"%@/%@", path, d];
            
            [self getPath:fullpath forMenu:subMenu];
        }
    }
    // Если файл является файлом
    else {
        // Фильтруем файлы
        NSString *type = [path pathExtension];
        NSLog(@"File.getPath - file type: %@", type);
        
        if (![supportType containsObject:type]) {
            NSLog(@"File.getPath - file type not support, skip!");
            
            return;
        }
        
        // Добавляем трек в список
        NSUInteger nTrack = [list addTrack:path];
        
        // Создаем пунт меню
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:fileName action:@selector(playTrack:) keyEquivalent:@""];
        [menuItem setTag:nTrack+100];
        [smenu addItem:menuItem];
        
        // Линкуем трек с пунктом меню
        [list linkTrack:nTrack withItem:menuItem];
        
        NSLog(@"File.getPath - menu title: %@", [smenu title]);
        NSLog(@"File.getPath - item title: %@", [menuItem title]);
    }
}

// Открыть выбранные файлы
- (void)openFile:(id)files {
    NSLog(@"File.openFile -> files: %@", files);
    
    NSMenu *trackMenu = [menu trackMenu];
    
    // Читаем все выбранные файлы
    for(NSString *file in files) {
        // Обход дерева файлов
        [self getPath:file forMenu:trackMenu];
    }
    
    // Разблокировать пункты меню
    [menu unlock];
}

// Связать файлы с меню
- (void)setMenu:(id)m {
    menu = m;
}

// Связать файлы с плейлистом
- (void)setList:(id)l {
    list = l;
}

@end
