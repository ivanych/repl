//
//  AppDelegate.h
//  Repl
//
//  Created by Mikhail Ivanov on 02.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "List.h"
#import "Player.h"
#import "Three.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    // Графический интерфейс приложения (меню)
    IBOutlet NSMenu *statusMenu;
    
    // Объект статусной панели для размещения иконки приложения
    NSStatusItem *statusItem;
    
    // Основная и дополнительная иконки приложения
    NSImage *statusImage1;
    NSImage *statusImage2;
    
    // Дерево меню
    Three *three;
    
    // Список треков
    List *trackList;
    
    // Плеер
    Player *player;
}
    
@end
