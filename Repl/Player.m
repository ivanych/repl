//
//  Player.m
//  Repl
//
//  Created by Dmitry Rassoshenko on 18.11.12.
//
//

#import "Player.h"

@implementation Player

- (id)init {
    if (self = [super init]) {
        _sound = [NSSound alloc];
    }

    return self;
}

- (void)play:(NSString *)filePath {
    /*
     Начинает воспроизведение файла по пути filePath.

    При каждом вызове останавливает текущее и начинает новое воспроизведение.
     */
    _currentFilePath = filePath;
    [self stop];
    _sound = [_sound initWithContentsOfFile:_currentFilePath byReference:false];
    [_sound play];
}

- (void)stop {
    /*
     Останавливает воспроизведение текущей композиции
     */
    if ([_sound isPlaying]) {
        [_sound stop];
    }
}

@end
