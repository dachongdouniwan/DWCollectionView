//
//  DWWateFallLayout.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/7/6.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "DWWateFallLayout.h"

@interface DWWateFallLayout ()

@property (nonatomic,strong) NSMutableArray *attributesArray;

@property (nonatomic,strong) NSArray<NSNumber*> *itemHeightArray;

@property (nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes*> *itemArray;

@end

@implementation DWWateFallLayout

-(instancetype)initWithHeightArray:(NSArray*)heightArray{
    if (self = [super init]) {
        self.itemHeightArray = heightArray;
    }
    return self;
}


-(void)prepareLayout{
        
    ///和init相似，必须call super的prepareLayout以保证初始化正确
    [super prepareLayout];
    ///1.首先被调用
    
    [self.attributesArray removeAllObjects];
    [self.itemArray removeAllObjects];
    
    ///获取当前collectionView对应区的item
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i =0; i<count; i++) {
       UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
    
}

///返回collectionView的内容的尺寸
-(CGSize)collectionViewContentSize{
    ///2.其次被调用(layoutAttributesForElementsInRect 调用后会在此调用此方法)
    
    
    CGFloat maxContentHeight = CGRectGetMaxY([self.itemArray firstObject].frame);
    
    for (UICollectionViewLayoutAttributes *attributes in self.itemArray) {
        if (maxContentHeight<CGRectGetMaxY(attributes.frame)) {
            maxContentHeight = CGRectGetMaxY(attributes.frame);
        }
    }
    return CGSizeMake(self.collectionView.bounds.size.width, maxContentHeight);
}


///返回rect中的所有的元素的布局属性,返回的是包含UICollectionViewLayoutAttributes的NSArray
///UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的
///初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。

///rect 为collectionview 的rect，（高度超出collectionview高度后，rect的height会翻倍）
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    ///3.被调用
    return self.attributesArray;
}

///返回对应于indexPath的位置的cell的布局属性,返回指定indexPath的item的布局信息。子类必须重载该方法,该方法只能为cell提供布局信息，不能为补充视图和装饰视图提供。
-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath*)indexPath{
    UICollectionViewLayoutAttributes *attributs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    ///item的宽度，根据左右间距和中间间距算出item宽度
    CGFloat itemWidth = (self.collectionView.bounds.size.width - (10+10+10+10))/3.0;
    ///item的高度
    CGFloat itemHeight = self.itemHeightArray[indexPath.row].floatValue;
    
    if (self.itemArray.count<3) {
        [self.itemArray addObject:attributs];
        CGRect itemFrame = CGRectMake(10+(itemWidth+10)*(self.itemArray.count-1), 10, itemWidth, itemHeight);
        attributs.frame = itemFrame;
    }else{
        UICollectionViewLayoutAttributes *fristAttri = [self.itemArray firstObject];
        CGFloat minY = CGRectGetMaxY(fristAttri.frame);
        CGFloat Y = minY;
        NSInteger index=0;
        CGRect itemFrame = CGRectMake(fristAttri.frame.origin.x,CGRectGetMaxY(fristAttri.frame)+10, itemWidth, itemHeight);
        for (UICollectionViewLayoutAttributes *attri in self.itemArray) {
            if (minY>CGRectGetMaxY(attri.frame)) {
                minY = CGRectGetMaxY(attri.frame);
                Y = minY;
                itemFrame = CGRectMake(attri.frame.origin.x,Y+10, itemWidth, itemHeight);
                NSInteger currentIndex = [self.itemArray indexOfObject:attri];
                index = currentIndex;
            }
        }
        attributs.frame = itemFrame;
        [self.itemArray replaceObjectAtIndex:index withObject:attributs];
    }
    
    return attributs;
}

-(NSMutableArray*)attributesArray{
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

-(NSMutableArray*)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

@end
