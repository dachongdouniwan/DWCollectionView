//
//  WaterFallController.h
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/7/4.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFallController : UIViewController

@end


@interface DWWaterFallCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *label;

@property (nonatomic,copy) NSString *title;


@end
