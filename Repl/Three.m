//
//  Three.m
//  Repl
//
//  Created by ivan ivanych on 10.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Three.h"

@implementation Three

- (void)getPath:(id)path {
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isDir;
    
    // Если файл является каталогом
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        NSLog(@"dir-> %@", path);
        
        //Читаем содержимое каталога
        NSArray * dir = [fileManager contentsOfDirectoryAtPath:path error:nil];
        
        // Перебор содержимого каталога
        for (NSArray *d in dir) {
            //NSLog(@"      %@", d);
            // Полный путь к файлу каталога
            NSString *fullpath = [NSString stringWithFormat:@"%@/%@", path, d];
            //NSLog(@"      (%@)", fullpath);
            
            [self getPath:fullpath];
        }
    }
    // Если файл является файлом
    else {
        NSLog(@"file: %@", path);
    }
}

@end
