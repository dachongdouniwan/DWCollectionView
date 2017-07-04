//
//  DWCollectionViewLayout.h
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/6/30.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWCollectionViewLayout : UICollectionViewFlowLayout

-(instancetype)initWithArray:(NSMutableArray*)widthArray edgeInsets:(UIEdgeInsets)insets;

@property (nonatomic,strong) NSMutableArray *widthArray;


@end
