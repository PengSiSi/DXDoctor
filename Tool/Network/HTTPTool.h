//
//  NetTool.h
//  baiduMap
//
//  Created by Mike on 16/4/6.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 *  请求成功后的回调
 *
 *  @param json 服务器返回的JSON数据
 */
typedef void (^HttpSuccess)(id json);
/**
 *  请求失败后的回调
 *
 *  @param error 错误信息
 */
typedef void (^HttpFailure)(NSError *error);

@interface HTTPTool : NSObject

+ (NSURLSessionDataTask *)GET:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - 上传

/// 不使用表单.服务端从HTTPBody得到文件内容的二进制
+ (NSURLSessionUploadTask *)uploadFileNoFormWithURLString:(NSString *)urlString fromFile:(NSURL *)fileURL orFromData:(NSData *)bodyData progress:(void (^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/// 使用表单.可能同时传递其他表单参数parameter, 在`constructingBodyWithBlock`中构建文件上传field
+ (NSURLSessionUploadTask *)uploadFileUseFormWithURLString:(NSString *)urlString parameter:(id)parameter constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block progress:(void (^)(NSProgress *))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/// 使用表单.使用提前组装好request，文件和其他参数已经用request构建好
+ (NSURLSessionUploadTask *)uploadFileUseFormWithStreamedRequest:(NSURLRequest *)urlRequest progress:(void (^)(NSProgress *))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  下载文件
 *
 *  @param url     文件路径
 *  @param name 文件保存的名称
 *  @param path 文件的Document下的哪个文件夹下
 */
+ (void)downLoadWithUrl:(NSString *)url withName:(NSString *)name withFilePath:(NSString *)path;

// 上传多张图片

+ (void)upLoadMutiWithURL:(NSString *)url headers:(NSDictionary *)headers param:(NSDictionary *)params imageDicArray:(NSArray *)imageDicArray success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
