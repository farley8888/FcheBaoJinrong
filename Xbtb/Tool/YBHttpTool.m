 //
//  YBHttp.m
//  Wanyingjinrong
//
//  Created by Jason on 15/11/17.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import "YBHttpTool.h"
#import "XBTMD5.h"
#import "UserManager.h"
#import "Define.h"
#import "MBProgressHUD+MJ.h"
#import <objc/runtime.h>
#import "NSUserDefaults+Extension.h"
#import "UIAlertView+Block.h"
#import "XBTNavigationController.h"
#import "DMUserTool.h"
#import "XBTWebRechargeController.h"
//#import <JPUSHService.h>

#define kFileNameKey @"kFileNameKey"
#define kResultKey @"kResultKey"



static char *NSErrorStatusCodeKey = "NSErrorStatusCodeKey";

@implementation NSError (YBHttp)

- (void)setStatusCode:(NSInteger)statusCode
{
    objc_setAssociatedObject(self, NSErrorStatusCodeKey, @(statusCode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)statusCode
{
    return [objc_getAssociatedObject(self, NSErrorStatusCodeKey) integerValue];
}

@end


@implementation YBHttpTool

+ (void)errorHandle:(NSURLSessionDataTask * _Nullable)task error:(NSError * _Nonnull)error failure:(void (^)(NSError *))failure
{
    
    [MBProgressHUD hideHUD];
    DMLog(@"请求出错了------%@", task.originalRequest.URL.absoluteString);
    DMLog(@"请求出错了------%@", error.localizedDescription);
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    
    error.statusCode = statusCode;
    
    if (failure) {
        failure(error);
    }
    
    if (statusCode == 401) {//token过期

        [DMUserTool login:[DMUserTool getCurrentLoginUser]];
        
    } else if (statusCode == 0) {//没有网络
//        UIAlertView *alertView = [UIAlertView alertWithTitle:nil message:@"没有网络！" buttonIndex:^(NSInteger index) {
//            
//        } cancelButtonTitle:@"好" otherButtonTitles:nil];
//        [alertView show];
        if ([UIApplication sharedApplication].windows.count){
            [MBProgressHUD showError:@"没有网络，请检查网络设置！"];
        }
    } else if (statusCode == 500) {//参数错误
//        UIAlertView *alertView = [UIAlertView alertWithTitle:nil message:@"参数错误！" buttonIndex:^(NSInteger index) {
//            
//        } cancelButtonTitle:@"好" otherButtonTitles:nil];
//        [alertView show];
    } else if (statusCode == 404) {
//        UIAlertView *alertView = [UIAlertView alertWithTitle:nil message:@"404！" buttonIndex:^(NSInteger index) {
//            
//        } cancelButtonTitle:@"好" otherButtonTitles:nil];
//        [alertView show];
    } else if (statusCode == 400) {
//        [MBProgressHUD showError:@"操作过于频繁，请稍后再试！"];
    }

}

+ (NSString *)fileName:(NSString *)url params:(NSDictionary *)params
{
    NSMutableString *mStr = [NSMutableString stringWithString:url];
    if (params != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [mStr appendString:str];
    }
    return mStr;
}

+ (AFHTTPSessionManager *)sessionManager
{
    
    static AFHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [AFHTTPSessionManager manager];
//        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/x-json"];
        //    设置请求超时
        sessionManager.requestSerializer.timeoutInterval = 30;
        [sessionManager.requestSerializer setHTTPShouldHandleCookies:YES];
    });

    
//    设置请求头
    UserManager *manager = [UserManager sharedManager];
    if (manager.user.token.length) {
        
        NSString *token = [NSString stringWithFormat:@"_ed_token_=%@",manager.user.token];
        NSString *name = [NSString stringWithFormat:@"_ed_name_=%@",manager.user.userName];
        NSString *phone = [NSString stringWithFormat:@"_ed_phone_=%@",manager.user.userName];
        
        NSString *cookie = [NSString stringWithFormat:@"%@;%@;%@",token,name,phone];
        cookie = [cookie stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [sessionManager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
       
        DMLog(@"----------%@", cookie);
    }else{
         [sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Cookie"];
    }
    

    
    /*****************************HTTPS*****************************/
    
    //    [sessionManager setSecurityPolicy:[self customSecurityPolicy]];

    return sessionManager;
}

+ (AFSecurityPolicy *)customSecurityPolicy
{
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"s" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

+ (void)getDataUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(Data *obj))success failure:(void (^)(NSError *error))failure;
{
     [self get:url params:params cacheType:YBCacheTypeReloadIgnoringLocalCacheData success:success failure:failure];
}


+ (void)get:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params cacheType:(YBCacheType)cacheType success:(void (^_Nullable)(Data *_Nullable))success failure:(void (^_Nullable)(NSError *_Nullable error))failure;
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    NSDictionary *dataDict = [self getCache:cacheType url:url params:params success:success];
    NSString *fileName = dataDict[kFileNameKey];
    if ([dataDict[kResultKey] boolValue]) return;
    NSString *httpStr = [[kAPI_URL stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *httpStr = [kAPI_URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    WeakSelf
    [sessionManager GET:httpStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Data *data = [Data mj_objectWithKeyValues:responseObject];
        
        if (data.code == ResultStatusSuccess) {
            //缓存数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            
            [YBCacheTool cacheForData:data fileName:fileName];
        }else if (([data.message isEqualToString:@"Token已过期"]) || [data.message isEqualToString:@"用户不存在"]){
//            data.code == ResultStatusTockenExpire && 
            UserManager *userManager = [UserManager sharedManager];
            //自动登录
            [DMUserTool login:userManager.user];
        }else{
//            [MBProgressHUD showSuccess:data.message];®
        }
        if (success) {
            success(data);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf errorHandle:task error:error failure:failure];
    }];
}

+ (void)getDataTypeForTextHtmlUrl:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params Success:(void(^_Nullable)(Data *_Nullable obj))success failure:(void(^_Nullable)(NSError *_Nullable error))failure;
{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    //    设置请求超时
    sessionManager.requestSerializer.timeoutInterval = 30;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //设置请求头
    UserManager *manager = [UserManager sharedManager];
    if (manager.user.token.length) {
        [sessionManager.requestSerializer setValue:manager.user.token forHTTPHeaderField:@"token"];
        DMLog(@"----------%@", manager.user.token);
    }
    [sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"%d",KApiVersion] forHTTPHeaderField:@"api-version"];
    NSString *httpStr = [[kAPI_URL stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    WeakSelf
    [sessionManager GET:httpStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Data *data = [Data mj_objectWithKeyValues:responseObject];
        if (data.code == ResultStatusSuccess) {
            //缓存数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];

            //            [YBCacheTool cacheForData:data fileName:fileName];
        }
        if (success) {
            success(data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf errorHandle:task error:error failure:failure];
    }];
}

+ (NSDictionary *)getCache:(YBCacheType)cacheType url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success
{
    //缓存数据的文件名
    NSString *fileName = [self fileName:url params:params];
    NSData *data = [YBCacheTool getCacheFileName:fileName];
    
    BOOL result = NO;
    
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        Data *data = [Data mj_objectWithKeyValues:dict];
        if (cacheType == YBCacheTypeReloadIgnoringLocalCacheData) {//忽略缓存，重新请求
            
        } else if (cacheType == YBCacheTypeReturnCacheDataDontLoad) {//有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
            
        } else if (cacheType == YBCacheTypeReturnCacheDataElseLoad) {//有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
            if (success) {
                success(data);
            }
            result = YES;
            
        } else if (cacheType == YBCacheTypeReturnCacheDataThenLoad) {///有缓存就先返回缓存，同步请求数据
            if (success) {
                success(data);
            }
        } else if (cacheType == YBCacheTypeReturnCacheDataExpireThenLoad) {//有缓存 判断是否过期了没有 没有就返回缓存
            //判断是否过期
            if (![YBCacheTool isExpire:fileName]) {
                if (success) {
                    success(data);
                }
                result = YES;
            }
        }
    }
    return @{kFileNameKey:fileName,
             kResultKey:@(result)};
}


+(void)getDataDifference:(NSString *)url params:(NSDictionary *)params success:(void (^)(id  _Nullable obj))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    NSString *httpStr = [[kAPI_URL stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WeakSelf
    [sessionManager GET:httpStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf errorHandle:task error:error failure:failure];
    }];
    
}

+ (void)getDateSuccess:(void (^)(Data *obj))success failure:(void (^)(NSError *error))failure
{
    NSString *url = @"time/currentTime";
    [self post:url params:nil success:success failure:failure];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params cacheType:(YBCacheType)cacheType success:(void (^)(Data *))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];

    NSString *httpStr = [[kAPI_URL stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    //缓存数据的文件名 data
    NSDictionary *dataDict = [self getCache:cacheType url:url params:params success:success];
    NSString *fileName = dataDict[kFileNameKey];
    if ([dataDict[kResultKey] boolValue]) return;
    
    WeakSelf
    [sessionManager POST:httpStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Data *data = [Data mj_objectWithKeyValues:responseObject];
        
        if (data.code == ResultStatusSuccess) {
            //缓存数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];

            [YBCacheTool cacheForData:data fileName:fileName];
            

        }
        if (success) {
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf errorHandle:task error:error failure:failure];
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(Data *))success failure:(void (^)(NSError *))failure
{
    [self post:url params:params cacheType:YBCacheTypeReloadIgnoringLocalCacheData success:success failure:failure];
}


+ (void)payBackPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(Data *obj))success failure:(void (^)(NSError *error))failure
{
    WeakSelf
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    NSString *httpStr = [[kAPI_BACK_URL stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [sessionManager POST:httpStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Data *data = [Data mj_objectWithKeyValues:responseObject];
        if (success) {
            success(data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf errorHandle:task error:error failure:failure];
    }];
}

+ (void)postWithOriginalUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    NSString *httpStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [sessionManager POST:httpStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        DMLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)uploadImageWithImage:(NSData *)image success:(void (^)(Data *obj))success failure:(void (^)(NSError *))failure
{
    //单独写上传图片的sessionManager因为sessionManager只初始化一次
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //    设置请求超时
    sessionManager.requestSerializer.timeoutInterval = 30;
    UserManager *manager = [UserManager sharedManager];
    if (manager.user.token.length) {
        [sessionManager.requestSerializer setValue:manager.user.token forHTTPHeaderField:@"token"];
        DMLog(@"----------%@", manager.user.token);
    }
    [sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"%d",KApiVersion] forHTTPHeaderField:@"api-version"];
    [sessionManager.requestSerializer setValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
    NSString *httpStr = [[kAPI_URL stringByAppendingString:@"user/uploadImg"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [sessionManager POST:httpStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:image name:@"head_url" fileName:[NSString stringWithFormat:@"%.0f.jpg", [[NSDate date] timeIntervalSince1970]] mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Data *data = [Data mj_objectWithKeyValues:responseObject];
        if (success) {
            success(data);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DMLog(@"%@", error.localizedDescription);
    }];
}

+ (void)uploadImageArrayWithImages:(NSArray<NSData *> *)images success:(void (^)(Data *obj))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    [sessionManager.requestSerializer setValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
    NSString *httpStr = [[kAPI_URL stringByAppendingString:@"user/uploadImg"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [sessionManager POST:httpStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [images enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [formData appendPartWithFileData:obj name:@"head_url" fileName:[NSString stringWithFormat:@"%.0f.jpg", [[NSDate date] timeIntervalSince1970]] mimeType:@"image/jpg"];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Data *data = [Data mj_objectWithKeyValues:responseObject];
        if (success) {
            success(data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)updateRegistrationID
{
//    NSString *registrationID = [JPUSHService registrationID];
//    if (registrationID.length==0) return;
//    [YBHttpTool post:@"busonly/upregistrationid" params:@{@"registrationid":registrationID} success:^(Data *obj) {
//        if (obj.result==1) {
//            [NSUserDefaults saveObject:registrationID key:kJPushRegistrationID];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
}

+ (void)updateAppSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    NSString *updateUrl = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",kAPPID];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];;
    [sessionManager GET:updateUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (success) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postDataDifference:(NSString *)url params:(NSDictionary *)params success:(void (^)(id  _Nullable obj))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];

    NSString *str = nil;
    if ([url containsString:@"bandBank"] ||[url containsString:@"smrz2"]) {
        str = [NSString stringWithFormat:@"%@%@",kAPI_URL,url];
    }else if([url containsString:@"fyPay"]){
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        str = [NSString stringWithFormat:@"%@%@",kAPI_URL,url];
    }else {
        str = [kAPI_APPURL stringByAppendingString:url];
    }
    
    NSString *httpStr = [[str stringByAppendingString:Suffix] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WeakSelf
    [sessionManager POST:httpStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
    
//            if ([httpStr containsString:@"login"]) {  //保存登录后的cookie
//                //获取cookie
//                NSArray*cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//
//                //把cookie进行归档并转换为NSData类型
//
//                NSData*cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
//
//                //存储归档后的cookie
//
//                [NSUserDefaults saveObject:cookiesData key:@"cookie"];
//            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf errorHandle:task error:error failure:failure];
    }];
}


@end
