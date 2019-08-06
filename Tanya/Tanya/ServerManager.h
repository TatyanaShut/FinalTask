//
//  ServewManager.h
//  Tanya
//
//  Created by Tatyana Shut on 23.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UserInfo,AccessToken;

@interface ServerManager : NSObject

@property (nonatomic, strong) NSString *accessKey;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) AccessToken *accessToken;
@property (nonatomic, strong) UIWindow *window;

+ (ServerManager *) shareManager;
- (void) loadRequestWithPath:(NSString *)path  comletion:(void(^)(id data, NSError *error))completion;
-(NSURLSession *)session;

- (void) authorizeUser;

@end



