//
//  ImageViewController.h
//  Tanya
//
//  Created by Tatyana Shut on 24.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ImageViewController : UIViewController
{
    CIContext *context;
    CIFilter *sepiaFilter;
}

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSString *nameAuthor;
@property(nonatomic, strong) NSString *portfolioURL;
@property(nonatomic, strong) UIImage *imageAuthor;

@end


