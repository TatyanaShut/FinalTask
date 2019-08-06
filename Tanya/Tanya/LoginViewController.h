//
//  LoginViewController.h
//  FinalTask
//
//  Created by Tatyana Shut on 20.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccessToken;

typedef void(^LoginCompleytionBlock)(AccessToken *token);

@interface LoginViewController : UIViewController
@property (nonatomic, strong) NSString *urlRequest;
- (id) initWithCompletionBlock:(LoginCompleytionBlock) completionBlock;
@end


