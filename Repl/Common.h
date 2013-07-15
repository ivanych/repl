//
//  Common.h
//  Repl
//
//  Created by ivanych on 15.07.13.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Common : NSObject

- (NSString*)md5:(NSString*)input;

@end
