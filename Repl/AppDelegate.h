//
//  AppDelegate.h
//  Repl
//
//  Created by Mikhail Ivanov on 02.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Menu.h"
#import "File.h"
#import "List.h"
#import "Player.h"


@interface AppDelegate : NSObject <NSApplicationDelegate> {
    // Графический интерфейс приложения (меню)
    IBOutlet NSMenu *statusMenu;
    
    // Меню
    Menu *menu;
    
    // Файлы
    File *file;
    
    // Список
    List *list;
    
    // Плеер
    Player *player;
    
    // Конфиг
    NSUserDefaults *config;
}
    
@end
