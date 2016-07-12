//
//  Images.m
//  MyPhotoBombers
//
//  Created by chang on 16/7/12.
//  Copyright © 2016年 chang. All rights reserved.
//

#import "Images.h"

@implementation Images


+(instancetype)initImageWithDic:(NSDictionary *)dic{

    Images *img = [[Images alloc] init];
    img.url = [dic objectForKey:@"url"];
    img.height = [dic objectForKey:@"height"];
    img.width = [dic objectForKey:@"width"];
    img.imageId = [dic objectForKey:@"id"];
    return img;
}

@end
