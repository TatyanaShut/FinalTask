//
//  ServewManager.m
//  Tanya
//
//  Created by Tatyana Shut on 23.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "ServerManager.h"
#import "LoginViewController.h"
#import "AccessToken.h"

@implementation ServerManager
NSInteger countPage = 1;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _accessKey = [[NSString alloc]initWithFormat:@"9332410230f83ee1f35c5b4d9acedc94b3686e1dfd51faf93fd58005b4a961e8"];
    }
    return self;
}

+ (ServerManager *) shareManager {
    
    static ServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc]init] ;
    });
    return manager;
}
- (NSURLSession *)session {
    if(!_session)
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    return _session;
}

- (void) loadRequestWithPath:(NSString *)path  comletion:(void(^)(id data, NSError *error))completion {
    path = [path stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%ld", (long)countPage]];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:[NSString stringWithFormat:@"Client-ID %@", self.accessKey] forHTTPHeaderField:@"Authorization"];
    request.HTTPMethod = @"GET";
    countPage ++;
    
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error)
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,error);
            });
        else{
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(json,nil);
            });
        }
    }]resume];
}

- (void) authorizeUser {
    self.accessToken = [[AccessToken alloc]init];
    LoginViewController *loginVc = [[LoginViewController alloc]initWithCompletionBlock:^(AccessToken *token) {
        NSURL *url = [NSURL URLWithString:@"https://unsplash.com/oauth/token"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:@"9332410230f83ee1f35c5b4d9acedc94b3686e1dfd51faf93fd58005b4a961e8",@"client_id",@"dbeb5c7221637ee967628b0d601217e01eeb4f7d6f2de19a3bbc213e4064e167",@"client_secret",@"urn:ietf:wg:oauth:2.0:oob",@"redirect_uri",token,@"code",@"authorization_code",@"grant_type", nil];
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
        [request setHTTPBody:data];
        
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
}
@end
