//
//  Player.h
//  Repl
//
//  Created by ivanych on 09.08.12.
//
//

#import <Cocoa/Cocoa.h>
#import "List.h"
#import "Three.h"

@interface Player : NSObject <NSSoundDelegate> {
    
    // Проигрыватель
    NSSound *sound;
    
    // Плейлист
    List *list;
    
    // Меню
    Three *menu;
    
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