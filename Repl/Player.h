//
//  Player.h
//  Repl
//
//  Created by Mikhail Ivanov on 09.08.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "List.h"
#import "Menu.h"

@interface Player : NSObject <NSSoundDelegate> {
    
    // Проигрыватель
    NSSound *sound;
    
    // Cписок
    List *list;
    
    // Меню
    Menu *menu;
    
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

- (void)setList:(id)l;
- (void)setMenu:(id)m;

- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)playbackSuccessful;

@end