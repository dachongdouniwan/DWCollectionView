//
//  EstimatedItemSizeController.h
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/7/6.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstimatedItemSizeController : UIViewController

@end


@interface EstimatedItemCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *label;

@property (nonatomic,copy) NSString *title;


@end

