//
//  ReusableViewController.h
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/7/7.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReusableViewController : UIViewController

@end


@interface DWReusableCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *label;

@property (nonatomic,copy) NSString *title;


@end
