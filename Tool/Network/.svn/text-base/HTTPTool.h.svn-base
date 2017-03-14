//
//  NetTool.h
//  baiduMap
//
//  Created by Mike on 16/4/6.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HTTPTool : NSObject

+ (NSURLSessionDataTask *)GET:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - 上传

/// 不使用表单.服务端从HTTPBody得到文件内容的二进制
+ (NSURLSessionUploadTask *)uploadFileNoFormWithURLString:(NSString *)urlString fromFile:(NSURL *)fileURL orFromData:(NSData *)bodyData progress:(void (^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/// 使用表单.可能同时传递其他表单参数parameter, 在`constructingBodyWithBlock`中构建文件上传field
+ (NSURLSessionUploadTask *)uploadFileUseFormWithURLString:(NSString *)urlString parameter:(id)parameter constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block progress:(void (^)(NSProgress *))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/// 使用表单.使用提前组装好request，文件和其他参数已经用request构建好(这个方法使用较少)
+ (NSURLSessionUploadTask *)uploadFileUseFormWithStreamedRequest:(NSURLRequest *)urlRequest progress:(void (^)(NSProgress *))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/// 坑爹:queryString放在url上，只是用表单传文件参数
+ (NSURLSessionUploadTask *)uploadFileWithURLString:(NSString *)urlString queryParameter:(id)parameters formConstructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block progress:(void (^)(NSProgress * ))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 下载

+ (NSURLSessionDownloadTask *)downloadWithURLString:(NSString *)URLString progress:(void (^)(NSProgress *))progress destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination success:(void(^)(id _NonnullresponseObject, NSURL *filePath))success failure:(void(^)(NSError *error))failure;

// 不使用downloadTask
+ (NSURLSessionDataTask *)GET:(NSString *)URLString progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end
