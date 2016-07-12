//
//  Images.h
//  MyPhotoBombers
//
//  Created by chang on 16/7/12.
//  Copyright © 2016年 chang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Images : NSObject

@property(nonatomic,strong) NSString * url;
@property(nonatomic,strong) NSNumber *height;
@property(nonatomic,strong) NSNumber *width;
@property(nonatomic,strong) NSString *imageId;


/**
 *  字典转化为对象
 *
 *  @param dic 入参字典
 *
 *  @return 出参 对象
 */
+(instancetype)initImageWithDic:(NSDictionary *)dic;

@end
