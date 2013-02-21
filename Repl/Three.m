//
//  Three.m
//  Repl
//
//  Created by ivan ivanych on 10.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Three.h"
#import "List.h"

@implementation Three

- (id)init {
    if (self = [super init]) {
        playItem = [NSMenuItem alloc];
        rndFlag = 0;
    }
    
    return self;
}

- (void)getPath:(id)path forMenu:(id)menu toList:(id)list {
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
        
        // Создаем пункт меню и субменю для него
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
            
            [self getPath:fullpath forMenu:subMenu toList:list];
        }
    }
    // Если файл является файлом
    else {
        NSLog(@"file: %@", path);
        
        // Добавляем трек в список
        NSUInteger nTrack = [list addTrack:path];
        
        // Создаем пунт меню
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:fileName action:@selector(playTrack:) keyEquivalent:@""];
        [menuItem setTag:nTrack];
        [menu addItem:menuItem];
        
        NSLog(@"menu title: %@", [menu title]);
        NSLog(@"item title: %@", [menuItem title]);
    }
}

- (void)markTrack:(id)item state:(NSUInteger)val {
    NSLog(@"markTrack - item title: %@", [item title]);
    
    [item setState:val];
    NSLog(@"markTrack - mark item: %ld", val);
    
    // Поднимаемся верх по дереву, пока не дойдем до меню треков (тег "1" для пункта меню треков задан в редакторе, в файле интерфейса)
    if ([[item parentItem] tag] == 1) {
        return;
    }
    
    [self markTrack:[item parentItem] state:val];
}

// Установить текущий проигрываемый пункт меню
- (void)setPlayItem:(id)item {
    playItem = item;
}

// Получить текущий проигрываемый пункт меню
- (id)playItem {
    return playItem;
}

// Переключить флаг случайного режима воспроизведения
- (void)turnRndFlag:(id)sender {
    if (rndFlag) {
        rndFlag = 0;
        [sender setState:NSOffState];
    }
    else {
        rndFlag = 1;
        [sender setState:NSOnState];
    }
}

// Прочитать флаг случайного режима воспроизведения
- (NSUInteger)rndFlag {
    return rndFlag;
}

@end
