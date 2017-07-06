//
//  DWCollectionViewLayout.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/6/30.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "DWCollectionViewLayout.h"


#define DWScreenH = [UIScreen mainScreen].bounds.size.height
#define DWScreenW = [UIScreen mainScreen].bounds.size.width


@interface DWCollectionViewLayout ()

@property (nonatomic,strong) NSMutableArray *attributesArray;

@property (nonatomic,assign) CGFloat maxY;

@property (nonatomic,assign) CGFloat left;

@property (nonatomic,assign) CGFloat right;

@property (nonatomic,assign) CGFloat top;

@property (nonatomic,assign) CGFloat between;

@end




@implementation DWCollectionViewLayout


-(instancetype)initWithArray:(NSMutableArray*)widthArray edgeInsets:(UIEdgeInsets)insets{
    if (self = [super init]) {
        self.widthArray = widthArray;
        NSLog(@"==***==%p",self.widthArray);

        self.left = insets.left;
        self.right = insets.right;
        self.top = insets.top;
        self.between = insets.bottom;
    }
    return self;
}


/**
 *另外需要了解的是，在初始化一个UICollectionViewLayout实例后，会有一系列准备方法被自动调用，以保证layout实例的正确。
 
 *首先，将被调用，默认下该方法什么没做，但是在自己的子类实现中，一般在该方法中设定一些必要的layout的结构和初始需要的参数等。
 
 */

-(void)prepareLayout{
    
    NSLog(@"---------1");
    
    ///和init相似，必须call super的prepareLayout以保证初始化正确
    [super prepareLayout];
    ///1.首先被调用
    
    [self.attributesArray removeAllObjects];
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (int i =0; i<itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArray addObject:attributes];
        if (i==self.widthArray.count-1) {
            [self loadOldAttributes:attributes.frame];
        }
    }
}


///返回collectionView的内容的尺寸
-(CGSize)collectionViewContentSize{
    ///2.其次被调用(layoutAttributesForElementsInRect 调用后会在此调用此方法)
    NSLog(@"---%f------2",self.maxY);
    return CGSizeMake(self.collectionView.bounds.size.width, self.maxY);
}

///返回rect中的所有的元素的布局属性,返回的是包含UICollectionViewLayoutAttributes的NSArray
///UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的
///初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。

///rect 为collectionview 的rect，（高度超出collectionview高度后，rect的height会翻倍）
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    ///3.被调用
    NSLog(@"---------3");

    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attributes in array) {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
        }
    }
    return self.attributesArray;
}


///返回对应于indexPath的位置的cell的布局属性,返回指定indexPath的item的布局信息。子类必须重载该方法,该方法只能为cell提供布局信息，不能为补充视图和装饰视图提供。
-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath*)indexPath{
    UICollectionViewLayoutAttributes *attributs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSNumber *currentWidthNumber = self.widthArray[indexPath.row];
    CGFloat width = currentWidthNumber.floatValue;
    CGFloat height = 30;
    CGRect currentFrame = CGRectZero;

    if (1) {
        if (self.attributesArray.count!=0) {
            ///1.取出上一个item的attributes
            UICollectionViewLayoutAttributes *lastAttributs = [self.attributesArray lastObject];
            CGRect lastFrame = lastAttributs.frame;
            
            ///判断当前item和上一个item是否在同一个row
            if (CGRectGetMaxX(lastAttributs.frame)+self.right==self.collectionView.bounds.size.width) {
                ///不在同一row
                currentFrame.origin.x = self.left;
                currentFrame.origin.y = CGRectGetMaxY(lastFrame) +self.top;
                currentFrame.size.width = width;
                currentFrame.size.height = height;
                attributs.frame = currentFrame;
                
            }else{
                ///上一个item的最大x值+当前item的宽度和左边距
                CGFloat totleWidth = CGRectGetMaxX(lastFrame)+(self.between+width+self.right);
                ///判断上一个item所在row的剩余宽度是否还够显示当前item
                if (totleWidth>=self.collectionView.bounds.size.width) {
                    ///不足以显示当前item的宽度
                    
                    ///将和上一个item在同一个row的item的放在同一个数组
                    NSMutableArray *sameYArray = [NSMutableArray array];
                    for (UICollectionViewLayoutAttributes *subAttributs in self.attributesArray) {
                        if (subAttributs.frame.origin.y==lastFrame.origin.y) {
                            [sameYArray addObject:subAttributs];
                        }
                    }
                    
                    ///判断出上一row还剩下多少宽度
                    CGFloat sameYWidth = 0.0;
                    for (UICollectionViewLayoutAttributes *sameYAttributs in sameYArray) {
                        sameYWidth += sameYAttributs.size.width;
                    }
                    sameYWidth = sameYWidth + (self.left+self.right+(sameYArray.count-1)*self.between);
                    ///上一个row所剩下的宽度
                    CGFloat sameYBetween = (self.collectionView.bounds.size.width-sameYWidth)/sameYArray.count;
                    
                    for (UICollectionViewLayoutAttributes *sameYAttributs in sameYArray) {
                        CGFloat sameAttributeWidth = sameYAttributs.size.width;
                        CGFloat sameAttributeHeight = sameYAttributs.size.height;
                        
                        CGRect sameYAttributsFrame = sameYAttributs.frame;
                        ///更新sameYAttributs宽度使之均衡显示
                        sameAttributeWidth += sameYBetween;
                        sameYAttributs.size = CGSizeMake(sameAttributeWidth, sameAttributeHeight);
                        NSInteger index = [sameYArray indexOfObject:sameYAttributs];
                        
                        sameYAttributsFrame.origin.x += (sameYBetween*index);
                        sameYAttributsFrame.size.width = sameAttributeWidth;
                        sameYAttributs.frame = sameYAttributsFrame;
                    }
                    currentFrame.origin.x = self.left;
                    currentFrame.origin.y = CGRectGetMaxY(lastFrame)+self.top;
                    currentFrame.size.width = width;
                    currentFrame.size.height = height;
                    attributs.frame = currentFrame;
                    
                }else{
                    currentFrame.origin.x = CGRectGetMaxX(lastFrame)+self.between;
                    currentFrame.origin.y = lastFrame.origin.y;
                    currentFrame.size.width = width;
                    currentFrame.size.height = height;
                    attributs.frame = currentFrame;
                }
            }
        }else{
            currentFrame.origin.x = self.left;
            currentFrame.origin.y = self.top;
            currentFrame.size.width = width;
            currentFrame.size.height = height;
            attributs.frame = currentFrame;
        }
    }
    
    attributs.size = CGSizeMake(width, 30);
    self.maxY = CGRectGetMaxY(attributs.frame)+10;
    
    NSLog(@"%f===%f===%f===%f",attributs.frame.origin.x,attributs.frame.origin.y,attributs.frame.size.width,attributs.frame.size.height);
    
    return attributs;
}

///返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   return [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
}

///返回对应于indexPath的位置的装饰视图的布局属性，如果没有装饰视图可不重载
-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath*)indexPath{
    return [super layoutAttributesForDecorationViewOfKind:decorationViewKind atIndexPath:indexPath];
}

///当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}


/**
  另外，在需要更新layout时，需要给当前layout发送 -invalidateLayout，该消息会立即返回，并且预约在下一个loop的时候刷新当前layout，这一点和UIView的setNeedsLayout方法十分类似。在-invalidateLayout后的下一个collectionView的刷新loop中，又会从prepareLayout开始，依次再调用-collectionViewContentSize和-layoutAttributesForElementsInRect来生成更新后的布局。
 */



-(void)loadOldAttributes:(CGRect)lastFrame{
    ///将和上一个item在同一个row的item的放在同一个数组
    NSMutableArray *sameYArray = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *subAttributs in self.attributesArray) {
        if (subAttributs.frame.origin.y==lastFrame.origin.y) {
            [sameYArray addObject:subAttributs];
        }
    }
    
    ///判断出上一row还剩下多少宽度
    CGFloat sameYWidth = 0.0;
    for (UICollectionViewLayoutAttributes *sameYAttributs in sameYArray) {
        sameYWidth += sameYAttributs.size.width;
    }
    sameYWidth = sameYWidth + (self.left+self.right+(sameYArray.count-1)*self.between);
    ///上一个row所剩下的宽度
    CGFloat sameYBetween = (self.collectionView.bounds.size.width-sameYWidth)/sameYArray.count;
    
    for (UICollectionViewLayoutAttributes *sameYAttributs in sameYArray) {
        CGFloat sameAttributeWidth = sameYAttributs.size.width;
        CGFloat sameAttributeHeight = sameYAttributs.size.height;
        
        CGRect sameYAttributsFrame = sameYAttributs.frame;
        ///更新sameYAttributs宽度使之均衡显示
        sameAttributeWidth += sameYBetween;
        sameYAttributs.size = CGSizeMake(sameAttributeWidth, sameAttributeHeight);
        NSInteger index = [sameYArray indexOfObject:sameYAttributs];
        
        sameYAttributsFrame.origin.x += (sameYBetween*index);
        sameYAttributsFrame.size.width = sameAttributeWidth;
        sameYAttributs.frame = sameYAttributsFrame;
    }
}

-(NSMutableArray*)attributesArray{
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

@end
