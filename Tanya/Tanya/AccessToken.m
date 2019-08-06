//
//  AccessToken.m
//  FinalTask
//
//  Created by Tatyana Shut on 20.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "AccessToken.h"

@implementation AccessToken
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.token = [NSString new];
    }
    return self;
}
@end
