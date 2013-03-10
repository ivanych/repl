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
        [sound setDelegate: self];
    }

    return self;
}

// Остановить проигрывание
- (void)stop {
    NSLog(@"Player.stop -> ()");
    
    [sound stop];
    NSLog(@"Player.stop - sound stop");
}

// Запустить проигрывание файла
- (void)playFile:(id)path {
    NSLog(@"Player.playFile -> path: %@", path);
    
    // Если что-то уже играет - остановить
    if ([sound isPlaying]) {
        NSLog(@"Player.playFile - sound isPlaying");
        
        [self stop];
    }
    
    // Открыть файл и запустить
    sound = [sound initWithContentsOfFile:path byReference:false];
    [sound play];
    NSLog(@"Player.playFile - sound play");
}

// Запустить проигрывание трека
- (void)playTrack:(NSUInteger)number {
    NSLog(@"Player.playTrack -> number: %ld", number);
    
    // Путь к файлу трека
    NSString *path = [list path:number];

    // Запустить проигрывание файла
    [self playFile:path];
    
    // Отметить проигрываемый трек в меню
    [menu markMenu:number];
    
    // Запомнить проигрываемый трек
    [list setPlayTrack:number];
}

// Запустить проигрывание следующего трека
- (void)playNextTrack {
    NSLog(@"Player.playNextTrack - - - - - - - - - - - - - - -");
    NSLog(@"Player.playNextTrack -> ()");
    
    // Следующий трек
    NSUInteger number = [list nextTrack];
    NSLog(@"Player.playNextTrack -> number: %ld", number);
    
    // Запустить проигрывание трека
    [self playTrack:number];
}

// Вызывается после завершения проигрывания трека
- (void)sound:(NSSound *)snd didFinishPlaying:(BOOL)playbackSuccessful {
    NSLog(@"Player.sound -> snd: %@, playbackSuccessful: %hhd", snd, playbackSuccessful);
    
    if (playbackSuccessful) {
        NSLog(@"Player.sound - current sound end");
        
        [self playNextTrack];
    }
    else {
        NSLog(@"Player.sound - current sound interrupt!");
    }
}

// Связать плеер с плейлистом
- (void)setList:(id)l {
    list = l;
}

// Связать плеер с меню
- (void)setMenu:(id)m {
    menu = m;
}

@end
