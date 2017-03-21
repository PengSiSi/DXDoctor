//
//  NetTool.m
//  baiduMap
//
//  Created by Mike on 16/4/6.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "HTTPTool.h"

#define setHeaders \
if (headers) { \
    for (id headerField in headers.allKeys) { \
        id headerValue = headers[headerField]; \
        NSAssert([headerField isKindOfClass:[NSString class]] && [headerValue isKindOfClass:[NSString class]], @"Error, class of key/value in headerFieldValueDictionary must be NSString."); \
        [manager.requestSerializer setValue:headerValue forHTTPHeaderField:headerField]; \
    } \
}

#define combineSuccessAndFailure \
^(id responseObject, NSError *error) { \
    if (error) { \
        if (failure) { \
            failure(error); \
        } \
    } else { \
        if (success) { \
            success(responseObject); \
        } \
    } \
}

typedef void (^CompletionBlockType)(id responseObject, NSError *error);

@implementation HTTPTool

+ (NSURLSessionDataTask *)GET:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    setHeaders
    NSURLSessionDataTask *dataTask = [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    return dataTask;
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString headers:(NSDictionary *)headers parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    setHeaders
    NSURLSessionDataTask *dataTask = [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    return dataTask;
}

#pragma mark - 上传

+ (NSURLSessionUploadTask *)uploadFileNoFormWithURLString:(NSString *)urlString fromFile:(NSURL *)fileURL orFromData:(NSData *)bodyData progress:(void (^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    CompletionBlockType completionBlock = combineSuccessAndFailure;
    NSAssert(fileURL || bodyData, @"these two parameters mustn't all be nil");
    NSURLSessionUploadTask *uploadTask = nil;
    if (fileURL) {
        uploadTask = [manager uploadTaskWithRequest:request fromFile:fileURL progress:progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            completionBlock(responseObject, error);
        }];
        [uploadTask resume];
        return uploadTask;
    }
    if (bodyData) {
        uploadTask = [manager uploadTaskWithRequest:request fromData:bodyData progress:progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            completionBlock(responseObject, error);
        }];
        [uploadTask resume];
    }
    return uploadTask;
}

+ (NSURLSessionUploadTask *)uploadFileUseFormWithURLString:(NSString *)urlString parameter:(id)parameter constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block progress:(nullable void (^)(NSProgress * _Nonnull))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionUploadTask *uploadTask = (NSURLSessionUploadTask *)[manager POST:urlString parameters:parameter constructingBodyWithBlock:block progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    return uploadTask;
}

+ (NSURLSessionUploadTask *)uploadFileUseFormWithStreamedRequest:(NSURLRequest *)urlRequest progress:(nullable void (^)(NSProgress * _Nonnull))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:urlRequest progress:progress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        combineSuccessAndFailure(responseObject, error);
    }];
    [uploadTask resume];
    return uploadTask;
}

#pragma mark - DownLoad
+ (void)downLoadWithUrl:(NSString *)url withName:(NSString *)name withFilePath:(NSString *)path {
    
    [CombancHUD show];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *aFilePath = [docPath stringByAppendingPathComponent:path];
    NSString *fileNamePath = [aFilePath stringByAppendingPathComponent:name];
    
    //path 文件url filePath文件夹url
    
    if ([fileManager fileExistsAtPath:aFilePath]) {
        //文件夹路径存在
        if ([fileManager fileExistsAtPath:fileNamePath]) {
            //文件存在
            [CombancHUD showInfoWithStatus:KDOWNLOADALREADY];
        } else {
            //文件不存在
            NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                NSURL *filePathURL = [NSURL fileURLWithPath:aFilePath];
                return [filePathURL URLByAppendingPathComponent:name];
            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                //NSLog(@"File downloaded to: %@", filePath);
                //加载下载后的文件
                [CombancHUD showSuccessWithStatus:KDOWNLOADSUCCESS];
            }];
            [downloadTask resume];
        }
    } else {
        //文件夹路径不存在
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            //创建路径
            [fileManager createDirectoryAtPath:aFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            NSURL *filePathURL = [NSURL fileURLWithPath:aFilePath];
            return [filePathURL URLByAppendingPathComponent:name];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            //NSLog(@"File downloaded to: %@", filePath);
            
            //下载文件
            NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                NSURL *filePathURL = [NSURL fileURLWithPath:aFilePath];
                return [filePathURL URLByAppendingPathComponent:name];
            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                //NSLog(@"File downloaded to: %@", filePath);
                //加载下载后的文件
                [CombancHUD showSuccessWithStatus:KDOWNLOADSUCCESS];
            }];
            [downloadTask resume];
        }];
        [downloadTask resume];
    }
}

+ (void)upLoadMutiWithURL:(NSString *)url headers:(NSDictionary *)headers param:(NSDictionary *)params imageDicArray:(NSArray *)imageDicArray success:(HttpSuccess)success failure:(HttpFailure)failure {

    //存放保存至沙盒中的图片路径
    NSMutableArray *imageUrlArr = [NSMutableArray arrayWithCapacity:10];
    
    dispatch_queue_t queue =  dispatch_queue_create("cccccccccccccc", NULL);
    
    // 将任务添加到队列中
    dispatch_async(queue, ^{
        
        for (NSDictionary *dic in imageDicArray) {
            UIImage *image = dic[@"image"];
            NSString *imageName = dic[@"imageName"];
            //将图片存至Temp文件夹下 并拿到其路径
            NSURL *imageUrl = [self writeImageToFile:image imageName:imageName];
            [imageUrlArr addObject:imageUrl];
        }
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        // 设置请求头
        if (headers != nil) {
            for (id httpHeaderField in headers.allKeys) {
                id value = headers[httpHeaderField];
                if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                    [manager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
                }else if ([value isKindOfClass:[NSNumber class]]) {
                    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",value] forHTTPHeaderField:(NSString *)httpHeaderField];
                }else{
                    NSLog(@"Error, class of key/value in headerFieldValueDictionary should be NSString.");
                }
            }
        }
        // formData是遵守了AFMultipartFormData的对象
        [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //遍历
            for (NSURL *imageUrl in imageUrlArr) {
                [formData appendPartWithFileURL:imageUrl name:imageUrl.absoluteString error:NULL];
            }

        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSString *tempPath = NSTemporaryDirectory();
                NSString *upLoadFilePath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"upLoadFile"]];
                [fileManager removeItemAtPath:upLoadFilePath error:nil];
                success(json);
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             failure(error);
        }];
    });
}

+ (NSURL *)writeImageToFile:(UIImage *)image imageName:(NSString *)imageName{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tempPath = NSTemporaryDirectory();
    NSString *upLoadFilePath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"upLoadFile"]];
    if([fileManager fileExistsAtPath:upLoadFilePath]){
    }else{
        //创建路径
        [fileManager createDirectoryAtPath:upLoadFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSData *data = [[NSData alloc] init];
    if ([image isKindOfClass:[NSString class]]) {
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:(NSString *)image]];
    }else{
        
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 0.2);
        } else {
            data = UIImagePNGRepresentation(image);
        }
        
    }
    //创建文件
    if (data) {
        
        [fileManager createFileAtPath:[upLoadFilePath stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]] contents:data attributes:nil];
    }
    
    //根据路径得到URL
    NSString *thumbUrl = [NSString stringWithFormat:@"%@/%@",upLoadFilePath,imageName];
    //写入文件
    [data writeToFile:thumbUrl atomically:YES];
    NSURL *imgUrl = [NSURL fileURLWithPath:thumbUrl];
    
    return imgUrl;
}

@end
