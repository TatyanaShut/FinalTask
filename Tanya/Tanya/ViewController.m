//
//  ViewController.m
//  Tanya
//
//  Created by Tatyana Shut on 23.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "ViewController.h"
#import "ServerManager.h"
#import "CollectionViewCell.h"
#import "UIColor+CustomColor.h"
#import "ImageViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

static NSString *const reuseIdentifier = @"Cell";
static NSString *const urlImageKey = @"urlImageKey";
static NSString *const authorNameKey = @"authorNameKey";
static NSString *const portfolioURLKey = @"portfolioURLKey";
static NSString *const profileImageKey = @"profileImageKey";
static NSString *const heightImageKey = @"heightImageKey";


@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        self.array = [NSMutableArray new];
        self.heightArray = [NSMutableArray new];
        self.nameAuthorArray = [NSMutableArray new];
        self.urlPortfolioAuthorArray = [NSMutableArray new];
        self.profile_imageAuthorArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.array addObjectsFromArray:[self.userDefaults objectForKey:urlImageKey]];
    [self.heightArray addObjectsFromArray:[self.userDefaults objectForKey:heightImageKey]];
    [self.nameAuthorArray addObjectsFromArray:[self.userDefaults objectForKey:authorNameKey]];
    [self.urlPortfolioAuthorArray addObjectsFromArray:[self.userDefaults objectForKey:portfolioURLKey]];
    [self.profile_imageAuthorArray addObjectsFromArray:[self.userDefaults objectForKey:profileImageKey]];
    
   self.title = @"ImageStock";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView =[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [ UIColor colorWithRed:0xD5/255.0f green:0xF0/255.0f blue:0xFA/255.0f alpha:1];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.collectionView];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self addConstraint];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backButtonnImage = [UIImage imageNamed:@"arrow_left"];
    [backButton setBackgroundImage:backButtonnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton] ;
    self.navigationItem.leftBarButtonItem = backBarButtonItem;



//    - (void)saveImage:(UIImage *)image withName:(NSString *)name {
//
//        //grab the data from our image
//        NSData *data = UIImageJPEGRepresentation(image, 1.0);
//        //get a path to the documents Directory
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,  YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//
//        // Add out name to the end of the path with .PNG
//        NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
//
//        //Save the file, over write existing if exists.
//        [fileManager createFileAtPath:fullPath contents:data attributes:nil];
//
//    }
//
//
//    - (NSString *) nameImage {
//        NSString *name = [NSString new];
//        for(NSInteger i = 0; i< self.array.count; i++){
//
//            //NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:self.array[i]]];
//            name = [NSString stringWithFormat:@"image%ld",(long)i];
//        }
//        return name;
//    }
//
//    - (UIImage *) imageFromArray {
//        UIImage *curremtImage = [UIImage new];
//        for(NSInteger i = 0; i< self.array.count; i++){
//
//            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:self.array[i]]];
//            curremtImage = [UIImage imageWithData:imageData];
//        }
//
//        return curremtImage;
//
//    }
//
[self.userDefaults removeObjectForKey:heightImageKey];
[self.userDefaults removeObjectForKey:authorNameKey];
[self.userDefaults removeObjectForKey:profileImageKey];
[self.userDefaults removeObjectForKey:urlImageKey];
}



- (void)goBack{
 [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
                     }];
    [self.navigationController popViewControllerAnimated:NO];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(self.urlPortfolioAuthorArray.count > 0 ){
        
    }else{
        
        [self getInfoFromServer];
        
    }

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[ServerManager shareManager]authorizeUser];
  
}

-(void) getInfoFromServer {
   
     [[ServerManager shareManager]loadRequestWithPath:@"https://api.unsplash.com/photos?per_page=30&page="  comletion:^(id data, NSError * _Nonnull error) {
        if(data){

            id imageData = [data valueForKeyPath:@"urls"];
            id heightData =[data valueForKeyPath:@"height"];
            [self.heightArray addObjectsFromArray:heightData];
            [self.userDefaults setObject:self.heightArray forKey:heightImageKey];
            
            self.imageArray = [imageData valueForKey:@"small"];
            [self.array addObjectsFromArray:self.imageArray];
            [self.userDefaults setObject:self.array forKey:urlImageKey];
            
            id nameDataUser = [data valueForKeyPath:@"user"];
            id name = [nameDataUser valueForKey:@"name"];
            [self.nameAuthorArray addObjectsFromArray:name];
           
            [self.userDefaults setObject:self.nameAuthorArray forKey:authorNameKey];
            
            id insta  = [nameDataUser valueForKey:@"instagram_username"];
            [self.urlPortfolioAuthorArray addObjectsFromArray:insta];
           
            
            id profileeImageData = [nameDataUser valueForKeyPath:@"profile_image"];
            id profileImage = [profileeImageData valueForKey:@"medium"];
            [self.profile_imageAuthorArray addObjectsFromArray:profileImage];
            [self.userDefaults setObject:self.profile_imageAuthorArray forKey:profileImageKey];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];

            });
        }
    }
     ];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    return self.array.count ;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if(indexPath.item == self.array.count - 1){
        [self getInfoFromServer];
    }
      NSURL *url = [NSURL URLWithString:[self.array objectAtIndex:indexPath.item]];
    
    [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, NSData *data) {
        if (succeeded) {
            cell.imageView.image = [[UIImage alloc] initWithData:data];
        }
        else{
             cell.imageView.image = [UIImage imageNamed:@"no_image"];
        }
    }];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return ([[self.heightArray objectAtIndex: indexPath.item]floatValue]/20 < 130 ) ?CGSizeMake((float)self.view.bounds.size.width/2.1,[[self.heightArray objectAtIndex:indexPath.item] floatValue]/10) : CGSizeMake((float)self.view.bounds.size.width/2.1,[[self.heightArray objectAtIndex:indexPath.item] floatValue]/20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ImageViewController *imageVC = [[ImageViewController alloc]init];
    NSString *urlPortfolio = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@", self.urlPortfolioAuthorArray[indexPath.item]]];
    NSString *nameAuthor = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@", self.nameAuthorArray[indexPath.item]]];
    NSString * imageAuthorString = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@", self.profile_imageAuthorArray[indexPath.item]]];
    NSData * imageAuthorData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imageAuthorString]];
    NSString * imageString = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@", self.array[indexPath.item]]];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imageString]];
    UIImage *imageAuthor = [[UIImage alloc]initWithData:imageAuthorData];
    UIImage *image = [[UIImage alloc]initWithData:imageData];
   
   
    imageVC.image = image;
    imageVC.imageAuthor = imageAuthor;
    imageVC.nameAuthor = nameAuthor;
    
    if([urlPortfolio isEqualToString:@"<null>"]){
        imageVC.portfolioURL =@"https://instagram.com";
    }else{
       imageVC.portfolioURL = [NSString stringWithFormat:@"https://instagram.com/%@",urlPortfolio];
    }
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [self.navigationController pushViewController:imageVC animated:NO];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }];
  
}

-(void) addConstraint {
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
   
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                                  [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                                  [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                                  [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
                                                  ]];
}


- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, NSData *data))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (!error) {
            completionBlock(YES, data);
        } else {
            completionBlock(NO, nil);
        }
    }];
}
@end
