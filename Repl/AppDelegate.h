//
//  AppDelegate.h
//  Repl
//
//  Created by ivan ivanych on 02.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    // Графический интерфейс приложения (меню)
    IBOutlet NSMenu *statusMenu;
    
    // Объект статусной панели для размещения иконки приложения
    NSStatusItem *statusItem;
    
    // Основная и дополнительная иконки приложения
    NSImage *statusImage1;
    NSImage *statusImage2;
}

@end
