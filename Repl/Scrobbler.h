//
//  Scrobbler.h
//  Repl
//
//  Created by ivanych on 28.06.13.
//
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "Menu.h"

@interface Scrobbler : NSObject {
    NSString * apiKey;
    NSString * apiSecret;
    
    // Флаг скробблинга
    NSUInteger scrFlag;
    
    // Меню
    Menu *menu;
    
    // Конфиг
    NSUserDefaults *config;
    
    // Общие методы
    Common * common;
}

- (id)getToken;
- (BOOL)auth:(id)token;
- (id)getSession:(id)token;

- (void)session;

- (void)scrobble:(NSInteger)timestamp artist:(id)artist title:(id)track;

- (void)setScrFlag:(NSInteger)flag;
- (void)turnScrFlag;
- (NSUInteger)scrFlag;

@property NSString * sessionKey;
@property NSString * tokenKey;

- (void)setMenu:(id)m;

@end