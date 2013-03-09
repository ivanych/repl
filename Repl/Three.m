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
        playItem = NULL;
    }
    
    return self;
}

- (void)getPath:(id)path forMenu:(id)menu toList:(id)blist {
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
            
            [self getPath:fullpath forMenu:subMenu toList:blist];
        }
    }
    // Если файл является файлом
    else {
        NSLog(@"file: %@", path);
        
        // Добавляем трек в список
        NSUInteger nTrack = [blist addTrack:path];
        
        // Создаем пунт меню
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:fileName action:@selector(playTrack:) keyEquivalent:@""];
        [menuItem setTag:nTrack+100];
        [menu addItem:menuItem];
        
        // Линкуем трек с пунктом меню
        [blist linkTrack:nTrack withItem:menuItem];
        
        NSLog(@"menu title: %@", [menu title]);
        NSLog(@"item title: %@", [menuItem title]);
    }
}

- (void)markItem:(id)item state:(NSUInteger)state {
    NSLog(@"Three.markItem -> item: %@, state: %ld", item, state);
    
    [item setState:state];
    NSLog(@"Three.markItem - set state: %ld", state);
    
    // Поднимаемся верх по дереву, пока не дойдем до меню треков (тег "1" для пункта меню треков задан в редакторе, в файле интерфейса)
    if ([[item parentItem] tag] == 1) {
        NSLog(@"Three.markItem - parent item tag == 1, end markItem!");
        
        return;
    }
    
    [self markItem:[item parentItem] state:state];
}

// Отметить проигрываемый трек в меню
- (void)markMenu:(NSUInteger)number {
    NSLog(@"Three.markMenu -> number: %ld", number);
    
    // Номер текущего проигрываемого трека
    NSUInteger currentNumber = [list playTrack];
    
    // Если что-то уже играет - снять текущую отметку в меню
    if (currentNumber) {
        NSLog(@"Three.markMenu - current unmark required");
        
        NSMenuItem *oldPlayItem = [list item:currentNumber];
        
        // Снять отметку в меню со старого проигрываемого трека
        [self markItem:oldPlayItem state:NSOffState];
    }
    else {
        NSLog(@"Three.markMenu - current unmark not required");
    }

    // Определяем пункт меню
    NSMenuItem *item = [list item:number];
    
    // Отметить в меню проигрываемый пункт
    [self markItem:item state:NSOnState];
}

// Связать дерево с меню
- (void)setMenu:(id)m {
    statusMenu = m;
}

// Связать плеер с плейлистом
- (void)setList:(id)l {
    list = l;
}

@end
