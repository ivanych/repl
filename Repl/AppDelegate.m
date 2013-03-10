//
//  AppDelegate.m
//  Repl
//
//  Created by ivan ivanych on 02.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Three.h"
#import "List.h"


@implementation AppDelegate

// Инициализация приложения
- (void)awakeFromNib {

    // Объект статусной панели
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    // Объект для работы с файлами
    NSBundle *bundle = [NSBundle mainBundle];
    
    // Загрузка изображений для иконки
    statusImage1 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon1"
                                                                            ofType:@"png"
                                                                       inDirectory:@"icons"]];
    
    statusImage2 = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon2"
                                                                            ofType:@"png"
                                                                       inDirectory:@"icons"]];
    
    // Параметры объекта статусной панели
    [statusItem setMenu:statusMenu];
    [statusItem setImage:statusImage1];
    [statusItem setAlternateImage:statusImage2];
    [statusItem setHighlightMode:YES];
    [statusItem setToolTip:@"Repl"];
    
    // Дерево меню
    three = [[Three alloc] init];
    
    // Связать дерево с меню
    [three setMenu:statusMenu];
    
    // Список треков
    trackList = [[List alloc] init];
    
    // Связать дерево со списком треков
    [three setList:trackList];
    
    // Плеер
    player =[[Player alloc] init];
    
    // Связать плеер со списком треков
    [player setList:trackList];
    
    // Связать плеер с деревом меню
    [player setMenu:three];
}

// Открыть файлы
- (IBAction)openFile:(id)sender {
    NSLog(@"App.openFile --------------------------------");
    NSLog(@"App.openFile -> sender: %@, ", sender);
    
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
        
        // Останавливаем проигрывание
        [player stop];
        
        // Обнуляем проигрываемый трек
        [trackList setPlayTrack:0];
        
        // Очищаем список треков от предыдущего содержимого
        [trackList reset];
        
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
    NSLog(@"App.playTrack --------------------------------");
    NSLog(@"App.playTrack -> sender: %@, ", sender);
    
    NSLog(@"App.playTrack - item tag: %ld, item title: %@", [sender tag], [sender title]);

    // Определить номер по тегу
    NSUInteger number = [sender tag] - 100;
    NSLog(@"App.playTrack - number: %ld", number);
    
    // Запустить проигрывание трека
    [player playTrack:number];
}

// Переключить флаг случайного режима воспроизведения
- (IBAction)turnRandom:(id)sender {
    NSLog(@"App.turnRandom --------------------------------");
    NSLog(@"App.turnRandom -> sender: %@, ", sender);
    
    [trackList turnRndFlag:sender];
}

@end
