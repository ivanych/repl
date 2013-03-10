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
}

- (id)init;

- (void)stop;
- (void)playFile:(id)path;
- (void)playTrack:(NSUInteger)number;
- (void)playNextTrack;

- (void)setList:(id)l;
- (void)setMenu:(id)m;

- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)playbackSuccessful;

@end