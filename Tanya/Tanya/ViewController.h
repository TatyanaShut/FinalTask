//
//  ViewController.h
//  Tanya
//
//  Created by Tatyana Shut on 23.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) NSArray *imageArray;
@property(nonatomic, strong) NSMutableArray *array;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *nameAuthorArray;
@property(nonatomic, strong) NSMutableArray *urlPortfolioAuthorArray;
@property(nonatomic, strong) NSMutableArray *profile_imageAuthorArray;
@property(nonatomic, strong)NSUserDefaults *userDefaults;
@property(nonatomic, strong) NSMutableArray *heightArray;

@end

