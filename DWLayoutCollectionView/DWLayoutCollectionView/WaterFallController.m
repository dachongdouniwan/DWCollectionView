//
//  WaterFallController.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/7/4.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "WaterFallController.h"
#import "DWCollectionView.h"
#import "LayoutStringController.h"
@interface WaterFallController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) DWCollectionView *dwCollectionView;


@property (nonatomic,strong) NSMutableArray *labelWidthArray;

@property (nonatomic,strong) NSArray<NSString*> *titleArray;

@end

@implementation WaterFallController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self caclueHeight];
    [self.view addSubview:self.dwCollectionView];
}


-(void)caclueHeight{
    
    NSArray<NSString*> *array = @[@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减肥肯德基发动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减肥肯德基发动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减肥肯德基发动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减肥肯德基发动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口"];
    
    __block NSMutableArray *heightArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect  =[obj boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
        [heightArray addObject:@(rect.size.width+10)];
    }];
    self.titleArray = array;
    self.labelWidthArray = heightArray;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"0000000");
    return self.labelWidthArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    cell.label.text = self.titleArray [indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    NSLog(@"%f----%f-----%f-----%f",cell.contentView.frame.origin.x,cell.contentView.frame.origin.y,cell.contentView.frame.size.width,cell.contentView.frame.size.height);
    return cell;
}

/**
 *上下，左右滑动时不会调用此方法来重新返回cell的大小，调用reload方法时会调用。
 *此方法的优先级高于layout.itemSize属性。
 */
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"1111111111");
//  
//    NSNumber *widthNumber = self.labelWidthArray[indexPath.row];
//    CGFloat width = widthNumber.floatValue;
//    return CGSizeMake(width, 30);
//}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [self.labelWidthArray removeLastObject];
    [collectionView reloadData];
}


-(DWCollectionView*)dwCollectionView{
    
    if (!_dwCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(100, 30);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//整个section相对于collectionview的上左下右的间距（即collectionView有一个区，这个区有五十个item，这个区相当于在collectionView中的一个容器，这个容器相对于collectionView上左下右的间距）不是item之间的上下左右的间距。
        layout.minimumInteritemSpacing = 10;//item之间的最下间距，这个数据设置的时最小的间距，当间距小于这个值时，item就会换行显示，但是如果你设置的是10，世纪间距是20也是不会换行的只有小于这个值时才会换行。
        
        
        /**
         *1.实现下面的预估size属性，首先要设置cell中contentView的约束，高度可变则定宽，宽度可变则定高，并切设置好其他的约束（上下左右）
         *2.对子控件进行约束
         *3.如需进一步操作size可以在cell中重写preferredLayoutAttributesFittingAttributes方法
         */
        
        /**
         原理：
         
         1.collection view 根据 layout 的 estimatedItemSize 算出估计的 contentSize，有了 contentSize collection view 就开始显示
         
         2.collection view 在显示的过程中，即将被显示的 cell 根据 autolayout 的约束算出自适应内容的 size
         
         3.layout 从 collection view 里获取更新过的 size attribute
         
         4.layout 返回最终的 size attribute 给 collection view
         
         5.collection 使用这个最终的 size attribute 展示 cell
         
         */
        
        layout.estimatedItemSize = CGSizeMake(30, 30);//此属性8.0以后有效，作用：类似一个占位符，当加载item时会先加载这个size，显示的时候 根据 autolayout 的约束算出自适应内容的 size；
        _dwCollectionView = [[DWCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 400) collectionViewLayout:layout];
        [_dwCollectionView registerClass:[DWCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        _dwCollectionView.delegate = self;
        _dwCollectionView.dataSource = self;
        _dwCollectionView.backgroundColor = [UIColor yellowColor];
    }
    return _dwCollectionView;
}


@end
