//
//  AppDelegate.m
//  Repl
//
//  Created by ivan ivanych on 02.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Three.h"


@implementation AppDelegate

// Инициализация приложения
- (void)awakeFromNib {
    // Объект статусной панели
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    // Объект для работы с файлами
    NSBundle *bundle = [NSBundle mainBundle];
    
    // Загрузка изображений для иконки
    statusImage1 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon1" ofType:@"png"]];
    statusImage2 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon2" ofType:@"png"]];
    
    // Параметры объекта статусной панели
    [statusItem setMenu:statusMenu];
    [statusItem setImage:statusImage1];
    [statusItem setAlternateImage:statusImage2];
    [statusItem setHighlightMode:YES];
    [statusItem setToolTip:@"Repl"];
    
    // Дерево меню
    three = [[Three alloc] init];
    
    // Плеер
    player =[[Player alloc] init];
}

// Открыть файлы
- (IBAction)openFile:(id)sender {
    
    // Создать диалог открытия файлов
    NSOpenPanel *fileDialog = [NSOpenPanel openPanel];
    
    // Свойства диалога
    [fileDialog setCanChooseFiles:YES];
    [fileDialog setCanChooseDirectories:YES];
    [fileDialog setAllowsMultipleSelection:YES];
    
    // Вывести диалог
    // Если запуск вернул нажатие кнопки OK - обработать выбранные файлы
    if ( [fileDialog runModal] == NSFileHandlingPanelOKButton ) {
        
        // Список выбранных файлов (url)
        NSArray *urls = [fileDialog URLs];
        
        // Находим меню треков (тег "1" для пункта меню треков задан в редакторе, в файле интерфейса)
        NSMenuItem * trackMenuItem = [statusMenu itemWithTag:1];
        NSMenu * trackMenu = [trackMenuItem submenu];
        
        // Разблокируем пункт меню треков
        [trackMenuItem setEnabled:YES];
        
        // Очищаем меню треков от предыдущего содержимого
        [trackMenu removeAllItems];
        
        // Дерево файлов
        //Three *three = [[Three alloc] init];
        
        // Список треков
        trackList = [[List alloc] init];
        
        // Читаем все выбранные файлы
        for(NSURL *url in urls) {
            NSLog(@"URL:=  %@", url);
            
            // Берем из URL только путь к файлу
            NSString *path = [url path];
            
            // Обход дерева файлов
            [three getPath:path forMenu:trackMenu toList:trackList];
        }
    }
}

// Запустить трек
- (IBAction)playTrack:(id)sender {
    NSLog(@"playTrack --------------------------------");
    NSLog(@"playTrack - item title: %@", [sender title]);
    
    // Путь к файлу трека
    NSString *path = [trackList track:[sender tag]];
    
    // Запустить проигрывание файла по пути
    [player playPath:path];
    
    // Получить старый проигрываемый пункт
    NSMenuItem *oldPlayItem = [three playItem];
    NSLog(@"playTrack - old item title: %@", [oldPlayItem title]);
    
    if ([oldPlayItem state] == NSOnState) {
        NSLog(@"playTrack - old item state: %ld -> mark 0", [oldPlayItem state]);
        
        // Снять отметку в меню со старого проигрываемого трека
        [three markTrack:oldPlayItem state:NSOffState];
    }
    
    // Запомнить проигрываемый пункт
    [three setPlayItem:sender];
    NSLog(@"playTrack - new item title: %@", [[three playItem] title]);
    
    // Отметить в меню новый проигрываемый трек
    [three markTrack:sender state:NSOnState];
}

- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)playbackSuccessful {
    NSLog(@"END!");
}

@end
