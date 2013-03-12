//
//  Three.m
//  Repl
//
//  Created by Mikhail Ivanov on 10.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import "Three.h"
#import "List.h"

@implementation Three

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

- (void)getPath:(id)path forMenu:(id)menu {
    NSLog(@"Three.getPath -> path: %@", path);
    
    // Пропускаем скрытые файлы
    NSRange isHidden = [path rangeOfString:@"/."];
    if (isHidden.length) {
        NSLog(@"Three.getPath - hidden file, skip!");

        return;
    }
    
    // Выделяем из пути название файла
    NSString *fileName = [path lastPathComponent];
    
    // Файл-менеджер
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isDir;
    
    // Если файл является каталогом
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        NSLog(@"Three.getPath - is directory");
        
        // Создаем пункт меню и субменю для него
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:fileName action:nil keyEquivalent:@""];
        NSMenu *subMenu = [[NSMenu alloc] initWithTitle:fileName];
        [menuItem setSubmenu:subMenu];
        [menu addItem:menuItem];
        
        NSLog(@"Three.getPath - create menu");
        NSLog(@"Three.getPath - menu title: %@", [menu title]);
        NSLog(@"Three.getPath - item title: %@", [menuItem title]);
        NSLog(@"Three.getPath - subm title: %@", [subMenu title]);
        
        //Читаем содержимое каталога
        NSArray * dir = [fileManager contentsOfDirectoryAtPath:path error:nil];
        
        // Перебор содержимого каталога
        NSLog(@"Three.getPath - read directory");
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
        NSLog(@"Three.getPath - file type: %@", type);
        
        if (![supportType containsObject:type]) {
            NSLog(@"Three.getPath - file type not support, skip!");
            
            return;
        }
        
        // Добавляем трек в список
        NSUInteger nTrack = [list addTrack:path];
        
        // Создаем пунт меню
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:fileName action:@selector(playTrack:) keyEquivalent:@""];
        [menuItem setTag:nTrack+100];
        [menu addItem:menuItem];
        
        // Линкуем трек с пунктом меню
        [list linkTrack:nTrack withItem:menuItem];
        
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
 
// Отметить случайный режим воспроизведения в меню
- (void)markRndMenuItem:(NSInteger)state {
    NSLog(@"Three.markRndMenuItem -> state: %ld", state);
    
    // Назначаем обработчик пункту меню "Предыдущий" (тег "5" для пункта меню задан в редакторе, в файле интерфейса)
    NSMenuItem *rndMenuItem = [statusMenu itemWithTag:5];
    [rndMenuItem setState:state];
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
