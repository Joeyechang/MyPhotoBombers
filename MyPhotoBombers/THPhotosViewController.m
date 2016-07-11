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

//#import <SimpleAuth/SimpleAuth.h>

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

    NSString * photoUrlStr1 = @"http://upload-images.jianshu.io/upload_images/130752-b5feb662e2205b30.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
    NSString * photoUrlStr2 = @"http://upload-images.jianshu.io/upload_images/130752-56e5dd683bba0aa1.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
    NSString * photoUrlStr3 = @"http://upload-images.jianshu.io/upload_images/130752-385e2f9f1f655c09.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
    NSString * photoUrlStr4 = @"http://upload-images.jianshu.io/upload_images/130752-18680819f06ab8a5.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
    NSString * photoUrlStr5 = @"http://upload-images.jianshu.io/upload_images/130752-81a7712034d48374.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
    NSString * photoUrlStr6 = @"http://upload-images.jianshu.io/upload_images/130752-450c5668eaddfcf7.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
    NSString * photoUrlStr7 = @"http://upload-images.jianshu.io/upload_images/130752-b696ce4f5d2651fe.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
    NSString * photoUrlStr8 = @"http://upload-images.jianshu.io/upload_images/130752-8d77cbb35584da75.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
    NSString * photoUrlStr9 = @"http://upload-images.jianshu.io/upload_images/130752-c8b7a54209fc4297.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
    NSString * photoUrlStr10 = @"http://upload-images.jianshu.io/upload_images/130752-79102761996c6b4b.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

    self.photos = [NSMutableArray arrayWithObjects:photoUrlStr1,photoUrlStr2,photoUrlStr3,photoUrlStr4,photoUrlStr5,photoUrlStr6,photoUrlStr7,photoUrlStr8,photoUrlStr9,photoUrlStr10, nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


/**
 *  本来这个工程是从instagram下载图片展示
 *  因为过内网络被墙原因，这里不用这个获取图片信息了
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
    cell.photo = self.photos[indexPath.row];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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















