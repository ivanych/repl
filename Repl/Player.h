//
//  Player.h
//  Repl
//
//  Created by Mikhail Ivanov on 09.08.12.
//  Copyright (c) 2012 Ivanych. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import "Menu.h"
#import "List.h"

@interface Player : NSObject <AVAudioPlayerDelegate> {
    
    // Проигрыватель
    AVAudioPlayer *avsound;
    
    // Меню
    Menu *menu;
    
    // Cписок
    List *list;
}

- (id)init;

- (BOOL)isOpen;
- (BOOL)isPlay;
- (void)stop;
- (void)resume;
- (void)pause;
- (void)play;
- (void)open:(id)path;

- (void)playTrack:(NSUInteger)number;
- (void)pauseTrack;

- (void)playNextTrack;
- (void)playPrevTrack;

- (void)setMenu:(id)m;
- (void)setList:(id)l;

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;

@end