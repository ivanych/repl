//
//  Player.m
//  Repl
//
//  Created by Dmitry Rassoshenko on 18.11.12.
//
//

#import "Player.h"

@implementation Player {
    // объект для воспроизведения музыки
    AVAudioPlayer *_sound;

    // текущий файл для воспроизведения
    NSString *_currentFilePath;

}

// флаг воспроизведения файла в данный момент
@synthesize is_playing;

- (id)init {
    /*
     Инициализирует объект плеера
     */
    if (self = [super init]) {
        _sound = [AVAudioPlayer alloc];
        // при старте программы у нас ничего не воспроизводится
        self.is_playing = false;
    }

    return self;
}

- (void)play:(NSString *)filePath {
    /*
     Начинает воспроизведение файла по пути filePath.

    При каждом вызове останавливает текущее и начинает новое воспроизведение.
     */
    _currentFilePath = filePath;

    // останавливаем текущее воспроизведение, чтобы начать воспроизводить другой файл
    [self stop];

    // инициализирует объект плеера (AVAudioPlayer) с использованием урла файла
    _sound = [_sound initWithContentsOfURL:[NSURL fileURLWithPath:filePath]  error: NULL];
    self.is_playing = true;

    // запускаем воспроизведение
    [_sound play];
}

- (void)stop {
    /*
     Останавливает воспроизведение текущей композиции
     */

    // Если у нас ничего в данный момент не играет, то и останавливать нечего
    if (self.is_playing) {

        // останавливаем проигрывание файла
        [_sound stop];

        // не забываем установить соответствующий флаг
        self.is_playing = false;
    }
}

@end
