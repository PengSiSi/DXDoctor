//
//  NSString+ExtentedHandler.m
//  YYKit整理
//
//  Created by Mike on 16/6/3.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "NSString+ExtentedHandler.h"

@implementation NSString (ExtentedHandler)

// 比较版本 ，如果当前的大于version返回1 如果小于返回-1 如果相等返回0，注意“5.2.0”与“5.2”相等
- (NSComparisonResult)compareVersion:(NSString *)version {
    NSArray *vs0 = [self componentsSeparatedByString:@"."];
    NSArray *vs1 = [version componentsSeparatedByString:@"."];
    NSInteger maxSize = vs0.count > vs1.count ? vs0.count : vs1.count;
    for (NSInteger i = 0; i < maxSize; i++) {
        NSInteger v0, v1;
        if (i >= vs0.count) {
            if (i >= vs1.count) return NSOrderedSame;
            else {
                [[NSScanner scannerWithString:[vs1 objectAtIndex:i]] scanInteger:&v1];
                if (v1 == 0) return NSOrderedSame;
                return NSOrderedAscending;
            }
        } else {
            [[NSScanner scannerWithString:[vs0 objectAtIndex:i]] scanInteger:&v0];
        }
        
        if (i >= vs1.count) {
            if (i >= vs0.count) return NSOrderedSame;
            else {
                [[NSScanner scannerWithString:[vs0 objectAtIndex:i]] scanInteger:&v0];
                if (v0 == 0) return NSOrderedSame;
                return NSOrderedDescending;
            }
        } else {
            [[NSScanner scannerWithString:[vs1 objectAtIndex:i]] scanInteger:&v1];
        }
        
        if (v0 > v1) {
            return NSOrderedDescending;
        } else if (v0 < v1) {
            return NSOrderedAscending;
        } else {
            continue;
        }
    }
    return NSOrderedSame;
}

- (BOOL)allCharactersAreNumber {
//    if (self.length == 0) return NO;
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (!(c >= '0' && c <= '9')) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)containsEmoji {
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (BOOL)isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)containsCharacterSet:(NSCharacterSet *)set {
    if (set == nil) return NO;
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}


//判断内容是否全部为空格  yes 全部为空格  no 不是
- (BOOL) isEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

#pragma mark - 字典转json字符串

+ (NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

// 判断仅输入字母或数字：

+ (BOOL) deptIdInputShouldAlphaNum: (NSString *)inputStr
{
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:inputStr]) {
        return YES;
    }
    return NO;
}

@end
