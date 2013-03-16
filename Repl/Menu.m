//
//  Menu.m
//  Repl
//
//  Created by Mikhail Ivanov on 10.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import "Menu.h"
#import "List.h"

@implementation Menu

- (id)init {
    if (self = [super init]) {
        
        // Объект для работы с файлами
        NSBundle *bundle = [NSBundle mainBundle];
        
        // Загрузка изображений для кнопок
        imageMenu1 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"menu1" ofType:@"png" inDirectory:@"icons"]];
        imageMenu2 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"menu2" ofType:@"png" inDirectory:@"icons"]];
        
        imagePlay1 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"play1" ofType:@"png" inDirectory:@"icons"]];
        imagePlay2 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"play2" ofType:@"png" inDirectory:@"icons"]];
        
        imagePause1 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"pause1" ofType:@"png" inDirectory:@"icons"]];
        imagePause2 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"pause2" ofType:@"png" inDirectory:@"icons"]];
        
        imagePrev1 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"prev1" ofType:@"png" inDirectory:@"icons"]];
        imagePrev2 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"prev2" ofType:@"png" inDirectory:@"icons"]];
        
        imageNext1 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"next1" ofType:@"png" inDirectory:@"icons"]];
        imageNext2 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"next2" ofType:@"png" inDirectory:@"icons"]];
        
        // Статусная кнопка "Следующий"
        statusItemNext = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        [statusItemNext setEnabled:NO];
        [statusItemNext setImage:imageNext1];
        [statusItemNext setAlternateImage:imageNext2];
        [statusItemNext setAction:@selector(nextTrack:)];
        
        // Статусная кнопка "Пуск/Пауза"
        statusItemPause = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        [statusItemPause setEnabled:NO];
        [statusItemPause setImage:imagePlay1];
        [statusItemPause setAlternateImage:imagePlay2];
        [statusItemPause setAction:@selector(pauseTrack:)];
        
        // Статусная кнопка "Предыдущий"
        statusItemPrev = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        [statusItemPrev setEnabled:NO];
        [statusItemPrev setImage:imagePrev1];
        [statusItemPrev setAlternateImage:imagePrev2];
        [statusItemPrev setAction:@selector(prevTrack:)];
        
        // Статусная кнопка "Меню"
        statusItemMenu = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        [statusItemMenu setImage:imageMenu1];
        [statusItemMenu setAlternateImage:imageMenu2];
        [statusItemMenu setHighlightMode:YES];
    }
    
    return self;
}

- (void)markItem:(id)item state:(NSUInteger)state {
    NSLog(@"Menu.markItem -> item: %@, state: %ld", item, state);
    
    [item setState:state];
    NSLog(@"Menu.markItem - set state: %ld", state);
    
    // Поднимаемся верх по дереву, пока не дойдем до меню треков (тег "1" для пункта меню треков задан в редакторе, в файле интерфейса)
    if ([[item parentItem] tag] == 1) {
        NSLog(@"Menu.markItem - parent item tag == 1, end markItem!");
        
        return;
    }
    
    [self markItem:[item parentItem] state:state];
}

// Отметить проигрываемый трек в меню
- (void)markMenu:(NSUInteger)number {
    NSLog(@"Menu.markMenu -> number: %ld", number);
    
    // Номер текущего проигрываемого трека
    NSUInteger currentNumber = [list playTrack];
    
    // Если что-то уже играет - снять текущую отметку в меню
    if (currentNumber) {
        NSLog(@"Menu.markMenu - current unmark required");
        
        NSMenuItem *oldPlayItem = [list item:currentNumber];
        
        // Снять отметку в меню со старого проигрываемого трека
        [self markItem:oldPlayItem state:NSOffState];
    }
    else {
        NSLog(@"Menu.markMenu - current unmark not required");
    }

    // Определяем пункт меню
    NSMenuItem *item = [list item:number];
    
    // Отметить в меню проигрываемый пункт
    [self markItem:item state:NSOnState];
}
 
// Отметить случайный режим воспроизведения в меню
- (void)markRndMenuItem:(NSInteger)state {
    NSLog(@"Menu.markRndMenuItem -> state: %ld", state);
    
    // Назначаем обработчик пункту меню "Предыдущий" (тег "5" для пункта меню задан в редакторе, в файле интерфейса)
    NSMenuItem *rndMenuItem = [statusMenu itemWithTag:5];
    [rndMenuItem setState:state];
}

// Отметить кнопку "Пуск/Пауза"
- (void)markPause:(NSInteger)pause {
    NSLog(@"Menu.markPause -> pause: %ld", pause);
    
    // Меняем изображение кнопки
    if (pause) {
        [statusItemPause setImage:imagePause1];
        [statusItemPause setAlternateImage:imagePause2];
    }
    else {
        [statusItemPause setImage:imagePlay1];
        [statusItemPause setAlternateImage:imagePlay2];
    }
}

// Разблокировать пункты меню
- (void)unlock {
    // Разблокируем пункт меню "Треки" (тег "1" для пункта меню задан в редакторе, в файле интерфейса)
    NSMenuItem *trackMenuItem = [statusMenu itemWithTag:1];
    [trackMenuItem setEnabled:YES];
    
    // Разблокируем контролы
    [statusItemNext setEnabled:YES];
    [statusItemPause setEnabled:YES];
    [statusItemPrev setEnabled:YES];
}

// Меню треков
- (id)trackMenu {
    // Находим меню треков (тег "1" для пункта меню треков задан в редакторе, в файле интерфейса)
    NSMenuItem *trackMenuItem = [statusMenu itemWithTag:1];
    NSMenu *trackMenu = [trackMenuItem submenu];
    
    return trackMenu;
}

// Связать меню со статусным меню
- (void)setStatusMenu:(id)m {
    statusMenu = m;
    [statusItemMenu setMenu:statusMenu];
}

// Связать плеер со списком
- (void)setList:(id)l {
    list = l;
}

@end
