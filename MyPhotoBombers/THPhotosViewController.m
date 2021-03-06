//
//  THPhotosViewController.m
//  Photo Bombers
//
//  Created by Sam Soffes on 1/28/14.
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "THPhotosViewController.h"
#import "THPhotoCell.h"
#import "THDetailViewController.h"
#import "THPresentDetailTransition.h"
#import "THDismissDetailTransition.h"
#import "Images.h"

@interface THPhotosViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSMutableArray *photos;
@property (nonatomic) BOOL loading;
@end

@implementation THPhotosViewController

- (void)setLoading:(BOOL)loading {
	_loading = loading;

	self.navigationItem.rightBarButtonItem.enabled = !_loading;
}

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Photo Bombers";

	// TODO: Add a refresh right bar button item
    
    [self.collectionView registerClass:[THPhotoCell class] forCellWithReuseIdentifier:@"photo"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.photos = [[NSMutableArray alloc] init];
    [self initPhotos];
    
    /*
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];
    if (self.accessToken == nil) {
        [SimpleAuth authorize:@"instagram" options:@{@"scope": @[@"likes"]} completion:^(NSDictionary *responseObject, NSError *error) {
            
            self.accessToken = responseObject[@"credentials"][@"token"];
            
            [userDefaults setObject:self.accessToken forKey:@"accessToken"];
            [userDefaults synchronize];
            
            [self refresh];
        }];
    } else {
        [self refresh];
    }*/
}


-(void)initPhotos{

    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray * dataArr = [responseDictionary valueForKeyPath:@"data"];
    NSArray * imagesArr = dataArr[0][@"images"];
    
    [imagesArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        NSDictionary * imgDic = (NSDictionary *)obj;
        //Images *img = [Images initImageWithDic:imgDic];
        [self.photos addObject:imgDic];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


/**
 *  本来这个工程是从instagram下载图片展示
 *  因为国内网络被墙原因，这里不用这个获取图片信息了
 */
/*
- (void)refresh {
	if (self.loading) {
		return;
	}

	self.loading = YES;

    NSURLSession *session = [NSURLSession sharedSession];
    
    // You can change the hashtag here to make your very own photo browser app!
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/photobomb/media/recent?access_token=%@", self.accessToken];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.photos = [responseDictionary valueForKeyPath:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
			self.loading = NO;
        });
    }];
    [task resume];
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    NSInteger  index = indexPath.row;
    cell.photo = self.photos[index];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSDictionary *photo = self.photos[0][@"images"][indexPath.row];
    NSDictionary *photo = self.photos[indexPath.row];
    THDetailViewController *viewController = [[THDetailViewController alloc] init];
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = self;
    viewController.photo = photo;
    
    [self presentViewController:viewController animated:YES completion:nil];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[THPresentDetailTransition alloc] init];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[THDismissDetailTransition alloc] init];
}

@end















