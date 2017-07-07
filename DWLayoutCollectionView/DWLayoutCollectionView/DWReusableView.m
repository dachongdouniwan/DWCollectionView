//
//  DWReusableView.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/7/7.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "DWReusableView.h"

@implementation DWReusableView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        [self addSubview:self.headImageView];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}


-(UIImageView*)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _headImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _headImageView.backgroundColor = [UIColor blueColor];
    }
    return _headImageView;
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return _titleLabel;
}

@end
