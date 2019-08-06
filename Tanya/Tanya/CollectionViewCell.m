//
//  CollectionViewCell.m
//  Tanya
//
//  Created by Tatyana Shut on 23.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "CollectionViewCell.h"
//#import "UIColor+CustomColor.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [UIImageView new];
        self.imageView.image = [UIImage imageNamed:@"no_image"];
        self.imageView.layer.cornerRadius = 8;
        self.imageView.layer.borderWidth = 2;
        self.imageView.layer.borderColor = [UIColor colorWithRed:0x90/255.0f green:0xC2/255.0f blue:0xF5/255.0 alpha:1].CGColor;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
       
            [NSLayoutConstraint activateConstraints:@[
                                                      [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16],
                                                      [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16],
                                                      [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                                      [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                                      
                                                      ]];
        
    }
    return self;
}
@end


