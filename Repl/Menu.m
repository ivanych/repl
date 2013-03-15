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

// Разблокировать пункты меню
- (void)unlock {
    // Разблокируем пункт меню "Треки" (тег "1" для пункта меню задан в редакторе, в файле интерфейса)
    NSMenuItem *trackMenuItem = [statusMenu itemWithTag:1];
    [trackMenuItem setEnabled:YES];
    
    // Назначаем обработчик пункту меню "Пуск/Пауза" (тег "2" для пункта меню задан в редакторе, в файле интерфейса)
    NSMenuItem *pauseMenuItem = [statusMenu itemWithTag:2];
    [pauseMenuItem setAction:@selector(pauseTrack:)];
    
    // Назначаем обработчик пункту меню "Следующий" (тег "3" для пункта меню задан в редакторе, в файле интерфейса)
    NSMenuItem *nextMenuItem = [statusMenu itemWithTag:3];
    [nextMenuItem setAction:@selector(nextTrack:)];
    
    // Назначаем обработчик пункту меню "Предыдущий" (тег "4" для пункта меню задан в редакторе, в файле интерфейса)
    NSMenuItem *prevMenuItem = [statusMenu itemWithTag:4];
    [prevMenuItem setAction:@selector(prevTrack:)];
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
}

// Связать плеер со списком
- (void)setList:(id)l {
    list = l;
}

@end
