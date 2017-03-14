//
//  NSString+ExtentedHandler.h
//  YYKit整理
//
//  Created by Mike on 16/6/3.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ExtentedHandler)

- (NSComparisonResult)compareVersion:(NSString *)version;

- (BOOL)allCharactersAreNumber;

- (BOOL)containsEmoji;
/**
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *)stringByTrim;

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 */
- (BOOL)isNotBlank;

/**
 Returns YES if the target string is contained within the receiver.
 @param string A string to test the the receiver.
 
 @discussion Apple has implemented this method in iOS8.
 */
- (BOOL)containsString:(NSString *)string;

/**
 Returns YES if the target CharacterSet is contained within the receiver.
 @param set  A character set to test the the receiver.
 */
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;

// 判断是否是空字符串
- (BOOL) isEmpty:(NSString *) str;

// 字典转JSON字符串
+ (NSString*)DataTOjsonString:(id)object;

// 判断只能输入字母和数字
+ (BOOL) deptIdInputShouldAlphaNum: (NSString *)inputStr;

@end
