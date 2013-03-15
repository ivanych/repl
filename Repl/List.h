//
//  List.h
//  Repl
//
//  Created by Mikhail Ivanov on 31.07.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Menu;

@interface List : NSObject {
    
    // Плейлист
    NSMutableArray *hlist;
    
    // Флаг случайного режима
    NSUInteger rndFlag;
    
    // Проигрываемый трек
    NSUInteger playTrack;
    
    // Меню
    Menu *menu;
}

- (id)init;

- (void)reset;

- (NSUInteger)addTrack:(id)path;
- (void)linkTrack:(NSUInteger)number withItem:(id)item;

- (id)path:(NSUInteger)number;
- (id)item:(NSUInteger)number;

- (void)setPlayTrack:(NSUInteger)number;
- (NSUInteger)playTrack;

- (NSUInteger)nextTrack;
- (NSUInteger)prevTrack;

- (void)setRndFlag:(NSInteger)flag;
- (void)turnRndFlag;
- (NSUInteger)rndFlag;

- (void)setMenu:(id)m;

@end
