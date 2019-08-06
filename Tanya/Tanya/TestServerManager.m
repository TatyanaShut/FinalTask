//
//  TestServerManager.m
//  TanyaTests
//
//  Created by Tatyana Shut on 27.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ServerManager.h"
#import "LoginViewController.h"
#import "ImageViewController.h"
#import "CollectionViewCell.h"
#import "ViewController.h"

@interface TestServerManager : XCTestCase
@property(nonatomic, strong) ServerManager *serverManager;

@property(nonatomic, strong) LoginViewController *loginVC;
@property(nonatomic, strong) CollectionViewCell *collectionVC;
@property(nonatomic, strong) ImageViewController *imageVC;
@property(nonatomic, strong) ViewController *vc;
@property (nonatomic, retain) XCTestExpectation *expectation;

@end

@implementation TestServerManager

- (void)setUp {
    [super setUp];
    self.serverManager = [ServerManager new];
    self.loginVC = [LoginViewController new];
    self.collectionVC = [CollectionViewCell new];
    self.imageVC = [ImageViewController new];
    self.vc = [ViewController new];
  
    NSLog(@"SetUp");
    
}

- (void)tearDown {
    [super tearDown];
    NSLog(@"tearDown");
}

- (void)testServerManagSing {
    
    ServerManager * obj = [ServerManager shareManager];
    XCTAssertNotNil(obj);
}

- (void) testSession {
    
    ServerManager *obj2 = [ServerManager new];
    NSURLSession *sessionCurrent = [obj2 session];
    XCTAssertNotNil(sessionCurrent);
    
}
-(void)testKey {
    NSString *key = @"9332410230f83ee1f35c5b4d9acedc94b3686e1dfd51faf93fd58005b4a961e8";
    NSString *accessKey = [self.serverManager accessKey];
    XCTAssertTrue([key isEqualToString:accessKey]);
}

- (void) testURLRequest {
    NSString *urlrequest = @"https://unsplash.com/oauth/authorize?client_id=9332410230f83ee1f35c5b4d9acedc94b3686e1dfd51faf93fd58005b4a961e8&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=public&response_type=code";
    NSString *urlString = [self.loginVC urlRequest];
    XCTAssertTrue([urlrequest isEqualToString:urlString]);
}
-(void) testImage {
    UIImage *image = [[UIImage alloc]init];
    image = [self.collectionVC imageView].image;
    XCTAssertNotNil(image);
    
}

- (void) testLoadImage {
    NSArray *currentArray = [self.vc array];
    XCTAssertNotNil(currentArray);
}

//- (void) testImageDownload {
//    __block BOOL connect = NO;
//    [[ServerManager shareManager]loadRequestWithPath:@"https://api.unsplash.com/photos?per_page=30&page="  comletion:^(id data, NSError * _Nonnull error) {
//        if(data){
//            connect = YES;
//        }
//    }];
//    XCTAssertTrue(connect);
//}


@end
