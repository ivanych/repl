//
//  Player.h
//  Repl
//
//  Created by ivanych on 09.08.12.
//
//

#import <Cocoa/Cocoa.h>

@interface Player : NSObject {
    
    // Объект для работы со звуком
    NSSound *sound;
}

- (id)init;
- (void)playPath:(id)path;
- (void)sound:(NSSound*)sound didFinishPlaying:(BOOL)playbackSuccessful;

@end