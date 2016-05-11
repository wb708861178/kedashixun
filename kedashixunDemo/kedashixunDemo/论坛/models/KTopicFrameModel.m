//
//  KTopicFrameModel.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/8.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KTopicFrameModel.h"
#import "Const.h"
#import <MJExtension.h>

#define space 10
#define margin 5
#define MaxSize CGSizeMake(kWidth-2*space,kHeight)

@implementation KTopicFrameModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        self.topicModel = [KTopicModel mj_objectWithKeyValues:dict];
        
    }
    return self;
}

- (void)setTopicModel:(KTopicModel *)topicModel{
    
    _topicModel = topicModel;
    
//--------------------Test
    
    NSString *str1 = @"QQ邮箱QQ邮箱QQ邮箱QQ邮箱QQ邮箱QQ邮箱QQ邮箱QQ邮箱QQ邮箱QQ邮箱QQ邮箱";
    CGSize size = [str1 boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    NSLog(@"--%@",NSStringFromCGSize(size));
    
//--------------------
    //计算坐标
    CGFloat iconW = 40,iconH = iconW;
    
    _iconFrame = CGRectMake(space, space, iconW, iconH);
    
    CGSize nameSize = [topicModel.name boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    _nameFrame = CGRectMake(CGRectGetMaxX(_iconFrame)+margin, space, nameSize.width, nameSize.height);
    
    CGSize timeSize = [topicModel.time boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _timeFrame = CGRectMake(CGRectGetMaxX(_iconFrame)+margin, CGRectGetMaxY(_nameFrame), timeSize.width, timeSize.height);
    
    
    
    CGSize contentSize = [topicModel.content boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    _contentFrame = CGRectMake(space, CGRectGetMaxY(_iconFrame)+space, contentSize.width, contentSize.height);
    
    //如果有图 则计算图片Frame
    if (topicModel.imagesUrlArr.count) {
        
        CGFloat imageStartY = CGRectGetMaxY(_contentFrame)+space;
        CGFloat imageW = (kWidth - 2*space -2*margin)/3,imageH = imageW;
        for (int i = 0; i < 3; i++) {
            
            CGFloat imageX = space+(imageW+margin)*i;
            
            CGRect imageFrame = CGRectMake(imageX, imageStartY, imageW, imageH);
            [self.imagesFrameArr addObject:NSStringFromCGRect(imageFrame)];
        }

    }
    
    CGFloat locationW = 20;
    CGFloat locationH = 20;
    _locationImgViewFrame = CGRectMake(space,
                                       topicModel.imagesUrlArr.count?(CGRectGetMaxY(CGRectFromString(self.imagesFrameArr.lastObject))+space):(CGRectGetMaxY(_contentFrame)+space),
                                       locationW,
                                       locationH);
    
    CGSize locationSize = [topicModel.location boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    _locationlblFrame = CGRectMake(CGRectGetMaxX(_locationImgViewFrame), CGRectGetMaxY(_locationImgViewFrame)-locationSize.height, locationSize.width, locationSize.height);

    
    
    NSString *str = [NSString stringWithFormat:@"%@人浏览",topicModel.viewCount];
    
    CGSize viewCountSize = [str boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    _viewCountFrame = CGRectMake(space,CGRectGetMaxY(_locationImgViewFrame)+margin ,viewCountSize.width,viewCountSize.height);
    
    
    CGFloat btnH = 30;
    CGFloat btnW = 50;
    CGFloat btnY = CGRectGetMidY(_viewCountFrame)-btnH/2;
    _commentFrame = CGRectMake(kWidth-space-btnW, btnY, btnW, btnH);
    _praiseFrame = CGRectMake(kWidth-space-btnW*2, btnY, btnW, btnW);
    _collectFrame = CGRectMake(kWidth-space-btnW*3, btnY, btnW, btnH);
    
    _cellHeight = CGRectGetMaxY(_commentFrame)+space;
}




- (NSMutableArray *)imagesFrameArr{
    
    if (!_imagesFrameArr) {
        
        _imagesFrameArr = [NSMutableArray array];
    }
    
    return _imagesFrameArr;
}




@end
