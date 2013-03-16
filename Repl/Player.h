//
//  Player.h
//  Repl
//
//  Created by Mikhail Ivanov on 09.08.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Menu.h"
#import "List.h"

@interface Player : NSObject <NSSoundDelegate> {
    
    // Проигрыватель
    NSSound *sound;
    
    // Меню
    Menu *menu;
    
    // Cписок
    List *list;
    
    // Флаг проигрывания
    BOOL isPlay;
}

- (id)init;

- (void)stop;
- (void)resume;
- (void)pause;
- (void)playFile:(id)path;
- (void)playTrack:(NSUInteger)number;
- (void)pauseTrack;

- (void)playNextTrack;
- (void)playPrevTrack;

- (void)setMenu:(id)m;
- (void)setList:(id)l;

- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)playbackSuccessful;

@end