//
//  Menu.h
//  Repl
//
//  Created by Mikhail Ivanov on 10.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class List;

@interface Menu : NSObject {
    // Статусное меню
    NSMenu *statusMenu;
    
    // Статусная кнопка "Меню"
    NSStatusItem *statusItemMenu;
    // Статусная кнопка "Предыдущий"
    NSStatusItem *statusItemPrev;
    // Статусная кнопка "Пуск/Пауза"
    NSStatusItem *statusItemPause;
    // Статусная кнопка "Следующий"
    NSStatusItem *statusItemNext;
    
    // Изображения для статусных кнопок
    NSImage *imageMenu1, *imageMenu2;
    NSImage *imagePlay1, *imagePlay2;
    NSImage *imagePause1, *imagePause2;
    NSImage *imagePrev1, *imagePrev2;
    NSImage *imageNext1, *imageNext2;

    // Список
    List *list;
}
    
- (void)markItem:(id)item state:(NSUInteger)state;
- (void)markMenu:(NSUInteger)number;

- (void)changeSuggest:(id)suggest;

- (void)markRndMenuItem:(NSInteger)state;
- (void)markPause:(NSInteger)pause;

- (void)unlock;
- (id)trackMenu;

- (void)setStatusMenu:(id)m;
- (void)setList:(id)l;

@end
