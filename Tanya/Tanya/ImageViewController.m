//
//  ImageViewController.m
//  Tanya
//
//  Created by Tatyana Shut on 24.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "ImageViewController.h"
#import "UIColor+CustomColor.h"

@interface ImageViewController ()

@property(nonatomic, strong) UILabel *nameAuthorLabel;
@property(nonatomic, strong) UITextView *portfolioURLLabel;
@property(nonatomic, strong) UIImageView *imageViewAuthor;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UISlider *slider;
@property (nonatomic, assign) CGImageRef cgImage;

@end

@implementation ImageViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    self.slider = [[UISlider alloc]init];
    
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.slider.value = 0.5;
    context = [CIContext contextWithOptions:nil];
    [self applyFilter:0.1];
    [self.view addSubview:self.slider];
    self.slider.tintColor = [UIColor colorWithRed:0x90/255.0f green:0xC2/255.0f blue:0xF5/255.0f  alpha:1];
   
    self.title = @"Image";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backButtonnImage = [UIImage imageNamed:@"arrow_left"];
    [backButton setBackgroundImage:backButtonnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton] ;
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    UIImageView *imageViewAuthor = [[UIImageView alloc] initWithImage:self.imageAuthor];
    [self.view addSubview:imageViewAuthor];
    self.imageViewAuthor = imageViewAuthor;
    self.imageViewAuthor.layer.cornerRadius = 8;
    self.imageViewAuthor.clipsToBounds = YES;
    
    self.nameAuthorLabel = [[UILabel alloc]init];
    self.nameAuthorLabel.text = self.nameAuthor;
    [self.view addSubview:self.nameAuthorLabel];
    self.nameAuthorLabel.textColor = [UIColor darkTextColor];
    
    self.portfolioURLLabel = [[UITextView alloc]init];
    
    self.portfolioURLLabel.text = self.portfolioURL;
    [self.view addSubview:self.portfolioURLLabel];
    self.portfolioURLLabel.backgroundColor = [ UIColor colorWithRed:0xD5/255.0f green:0xF0/255.0f blue:0xFA/255.0f alpha:1];
    [self addConstraint];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveImage)];
}
- (void)goBack{
    [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
                     }];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void) addConstraint{
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSLayoutConstraint *leftImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:16];
  
    NSLayoutConstraint *rightImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-16];

   
        NSLayoutConstraint *topImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:16];
    
        [self.view addConstraints:@[leftImageView, topImageView, rightImageView]];
   
    
    self.slider.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftSlider = [NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:16];

    NSLayoutConstraint *rightSlider = [NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-16];
 
    NSLayoutConstraint *topSlider = [NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:(float)self.imageView.frame.size.height+100];
    
    [self.view addConstraints:@[leftSlider, rightSlider,topSlider]];
   
    self.nameAuthorLabel.textAlignment = NSTextAlignmentCenter;
    self.nameAuthorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftAuthorLabel = [NSLayoutConstraint constraintWithItem:self.nameAuthorLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imageViewAuthor attribute:NSLayoutAttributeLeft multiplier:1 constant:(float)self.imageViewAuthor.frame.size.width+8];
   
    NSLayoutConstraint *rightAuthorLabel  = [NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-16];
   
    NSLayoutConstraint *topAuthorLabel  = [NSLayoutConstraint constraintWithItem:self.nameAuthorLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.portfolioURLLabel attribute:NSLayoutAttributeTop multiplier:1 constant:32];

    
    [self.view addConstraints:@[leftAuthorLabel, rightAuthorLabel,topAuthorLabel]];
    
    
    self.portfolioURLLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.portfolioURLLabel.editable = NO;
    self.portfolioURLLabel.dataDetectorTypes = UIDataDetectorTypeAll;
    self.portfolioURLLabel.textAlignment = NSTextAlignmentNatural;
    [self.portfolioURLLabel setFont: [UIFont systemFontOfSize:14.0]];
    
    
    NSLayoutConstraint *leftPortfolioURLLabel = [NSLayoutConstraint constraintWithItem:self.portfolioURLLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imageViewAuthor attribute:NSLayoutAttributeLeft multiplier:1 constant:(float)self.imageViewAuthor.frame.size.width+4];
    NSLayoutConstraint *rightPortfolioURLLabel  = [NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-16];
  
    NSLayoutConstraint *topPortfolioURLLabel  = [NSLayoutConstraint constraintWithItem:self.portfolioURLLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageViewAuthor attribute:NSLayoutAttributeTop multiplier:1 constant:4];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.portfolioURLLabel
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:300];
  
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.portfolioURLLabel
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:35];

    [self.view addConstraints:@[leftPortfolioURLLabel, rightPortfolioURLLabel,topPortfolioURLLabel]];
    [self.portfolioURLLabel addConstraints:@[widthConstraint,heightConstraint]];
    
   
    self.imageViewAuthor.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageViewAuthor.contentMode = UIViewContentModeScaleAspectFit;
    self.imageViewAuthor.layer.borderWidth = 1;
    self.imageViewAuthor.layer.borderColor = [UIColor darkTextColor].CGColor;
    
    NSLayoutConstraint *leftImageViewAuthor = [NSLayoutConstraint constraintWithItem:self.imageViewAuthor attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:16];
    
    NSLayoutConstraint *topImageViewAuthor = [NSLayoutConstraint constraintWithItem:self.imageViewAuthor attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.slider attribute:NSLayoutAttributeTop multiplier:1 constant:(float)self.slider.frame.size.height];
  
    
    NSLayoutConstraint *heightImageViewAuthor = [NSLayoutConstraint constraintWithItem:self.imageViewAuthor attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
   
    NSLayoutConstraint *widthImageViewAuthor = [NSLayoutConstraint constraintWithItem:self.imageViewAuthor attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
   
    [self.view addConstraints:@[leftImageViewAuthor, topImageViewAuthor]];
    [self.imageViewAuthor addConstraints:@[heightImageViewAuthor, widthImageViewAuthor]];

}

- (void) applyFilter:(float)value {
    
    CIImage *beginImage = [[CIImage alloc]initWithImage:self.image];
    sepiaFilter = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey, beginImage,@"inputIntensity",[NSNumber numberWithFloat:value], nil];
    CIImage *cIImage = [sepiaFilter outputImage];
    self.cgImage = [context createCGImage:cIImage fromRect:[cIImage extent]];
    [self.imageView setImage:[UIImage imageWithCGImage:self.cgImage]];
    
}
- (void) sliderValueChanged:(UISlider *)sender {
    [self applyFilter:sender.value];
}

-(void) saveImage {
    
    UIImageView *image = [[UIImageView alloc]initWithImage:self.imageView.image];
    [image setImage:[UIImage imageWithCGImage:self.cgImage]];
    
    UIImageWriteToSavedPhotosAlbum(image.image, self, nil, nil);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"Your photo has been added to the gallery"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
