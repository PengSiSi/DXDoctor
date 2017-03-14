//
//  NSString+Extend.h
//  Ssdfz
//
//  Created by 王楠 on 16/5/13.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)
/**
 * 根据传入的字符串和字体计算高度
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font space:(CGFloat)space;
/**
 * 根据传入的字符串和字体计算高度 含最大size
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize) maxSize;

/**
 * 是否含有Emoji表情
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 * 检测输入的汉字数
 */
+ (NSInteger)stringCount:(NSString*)string;

/**
 *保存传入的图片
 */
+ (NSString *)saveImage:(NSData *)image imageName:(NSString *)imageName;

/**
 *  <#Description#>
 *
 *  @param saveFilePath <#saveFilePath description#>
 */
+ (void)deleteTemSaveImageWithFilePath:(NSString *)imageName;

/**
 * 将未读的人员标红
 */
+ (NSMutableAttributedString *)redStringWithText:(NSString *)text WithArray:(NSArray *)array;

/**
 *  拼接富文本
 */
+ (NSAttributedString *)htmlDetailContentWithText:(NSString *)text;

/**
 *  正则去除网络标签
 */
+ (NSString *)getZZwithString:(NSString *)text;

/**
 去除收尾空格
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *)stringByTrim;
/**
 *  去除文本中包含的节点符号
 *
 *  @param string 带节点的字符串
 *
 *  @return 无节点的字符串
 */
+ (NSString *)characterSet1:(NSString *)string;

/**
 *  SHA-1加密
 *
 *  @param inputString 带节点的字符串
 *
 *  @return 无节点的字符串
 */
+ (NSString *)sha1Encryption:(NSString *)inputString;

@end
