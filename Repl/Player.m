//
//  Player.m
//  Repl
//
//  Created by ivanych on 09.08.12.
//
//

#import "Player.h"

@implementation Player

- (id)init {
    if (self = [super init]) {
        sound = [NSSound alloc];
    }
    
    return self;
}

// Запустить проигрывание файла по пути
- (void)playPath:(id)path {
    
    // Если что-то уже играет - остановить
    if ([sound isPlaying]) {
        [sound stop];
    }
    
    // Открыть файл и запустить
    sound = [sound initWithContentsOfFile:path byReference:false];
    [sound play];
}

@end
