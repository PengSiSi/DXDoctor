//
//  NSString+Extend.m
//  Ssdfz
//
//  Created by 王楠 on 16/5/13.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extend)

NSString *const saveFilePath = @"uploadPhoto";

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font space:(CGFloat)space {
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - space, 90000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    return rect.size;
}

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize) maxSize {
    CGRect rect = [string boundingRectWithSize:maxSize//限制最大的宽度和高度
                                       options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    return rect.size;
}


//过滤表情
+ (NSString *)filterEmoji:(NSString *)string {
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [string UTF8String];
    char *newUTF8 = malloc( sizeof(char) * len );
    int j = 0;
    
    //0xF0(4) 0xE2(3) 0xE3(3) 0xC2(2) 0x30---0x39(4)
    for ( int i = 0; i < len; i++ ) {
        unsigned int c = utf8;
        BOOL isControlChar = NO;
        if ( c == 4294967280 ||
            c == 4294967089 ||
            c == 4294967090 ||
            c == 4294967091 ||
            c == 4294967092 ||
            c == 4294967093 ||
            c == 4294967094 ||
            c == 4294967095 ||
            c == 4294967096 ||
            c == 4294967097 ||
            c == 4294967088 ) {
            i = i + 3;
            isControlChar = YES;
        }
        if ( c == 4294967266 || c == 4294967267 ) {
            i = i + 2;
            isControlChar = YES;
        }
        if ( c == 4294967234 ) {
            i = i + 1;
            isControlChar = YES;
        }
        if ( !isControlChar ) {
            newUTF8[j] = utf8;
            j++;
        }
    }
    newUTF8[j] = '\0';
    NSString *encrypted = [NSString stringWithCString:(const char*)newUTF8
                                             encoding:NSUTF8StringEncoding];
    free( newUTF8 );
    return encrypted;
}

//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
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

//检测输入的汉字数 （汉字占 2位 表情占 4位 其余占1位）
+ (NSInteger)stringCount:(NSString*)string {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [string dataUsingEncoding:enc];
    return [da length];
}

+ (NSString *)saveImage:(NSData *)imageData imageName:(NSString *)imageName {
    NSString *resultPath;

    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *tempPath = NSTemporaryDirectory();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [tempPath stringByAppendingPathComponent:saveFilePath];
    // 创建目录
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    //创建文件
    if (imageData) {
        resultPath = [testDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]];
        [fileManager createFileAtPath:resultPath contents:imageData attributes:nil];
    }
    NSLog(@"resultPath-----:%@",resultPath);
    return resultPath;
}

+ (void)deleteTemSaveImageWithFilePath:(NSString *)imageName {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *tempPath = NSTemporaryDirectory();
    NSString *testDirectory = [tempPath stringByAppendingPathComponent:saveFilePath];
    NSString *resultPath = [testDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]];    
    // 删除文件/文件夹
    [fileManager removeItemAtPath:resultPath error:nil];
}

+ (NSMutableAttributedString *)redStringWithText:(NSString *)text WithArray:(NSArray *)array {
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:TEXT_COLOR_DARKGRAY,
                              NSFontAttributeName:[UIFont systemFontOfSize:15]
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    for (int i = 0; i < array.count; i++) {
        NSRange redTextRange =[text rangeOfString:array[i]];
        [attributedText setAttributes:@{NSForegroundColorAttributeName:F_RED,NSFontAttributeName:[UIFont systemFontOfSize:15]} range:redTextRange];
    }
    return attributedText;
}

+ (NSAttributedString *)htmlDetailContentWithText:(NSString *)text {
    NSString *htmlStr = [NSString stringWithFormat:@"<html><body>%@<body/><html>", text];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}

+ (NSString *)getZZwithString:(NSString *)text {
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    text = [regularExpretion stringByReplacingMatchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length) withTemplate:@""];
    return text;
}

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

+ (NSString *)characterSet1:(NSString *)string {
    
#if 0
    NSCharacterSet *characterSet1 = [NSCharacterSet characterSetWithCharactersInString:@"<p/brh>"];
    // 将string1按characterSet1中的元素分割成数组
    NSArray *array1 = [string componentsSeparatedByCharactersInSet:characterSet1];
    
    for(NSString *string1 in array1) {
        if ([string1 length]>0) {
            // 此处string即为中文字符串
            return string1;
        }
    }
    return string;
#endif
    
    NSScanner * scanner = [NSScanner scannerWithString:string];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return string;
}

+ (NSString *)sha1Encryption:(NSString *)inputString {
    const char *cstr = [inputString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:inputString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes,data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end
