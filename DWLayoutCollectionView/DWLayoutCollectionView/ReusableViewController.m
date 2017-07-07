//
//  ReusableViewController.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/7/7.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "ReusableViewController.h"
#import "DWCollectionView.h"
#import "Masonry.h"
#import "DWReusableView.h"

#import "DWReusableLayout.h"

@interface ReusableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) DWCollectionView *dwCollectionView;

@property (nonatomic,strong) NSMutableArray *labelWidthArray;

@property (nonatomic,strong) NSArray<NSString*> *titleArray;

@property (nonatomic,strong) NSMutableArray<NSArray*> *allArray;

@end

@implementation ReusableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self caclueHeight];
    [self.view addSubview:self.dwCollectionView];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.allArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"0000000");
    return self.allArray[section].count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DWReusableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    cell.label.text = self.allArray[indexPath.section][indexPath.row];
    cell.backgroundColor = [UIColor redColor];
//    NSLog(@"%f----%f-----%f-----%f",cell.contentView.frame.origin.x,cell.contentView.frame.origin.y,cell.contentView.frame.size.width,cell.contentView.frame.size.height);
    return cell;
}

///**
// *上下，左右滑动时不会调用此方法来重新返回cell的大小，调用reload方法时会调用。
// *此方法的优先级高于layout.itemSize属性。
// */
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


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"DWReusableView";
    //从缓存中获取 Headercell
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DWReusableView *cell = (DWReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld",indexPath.section];
        return cell;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(10, 100);
    }else{
        return CGSizeMake(10, 100);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"====%f",scrollView.contentOffset.y);
}

-(void)caclueHeight{
    
    NSArray<NSString*> *array = @[@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口"];
    NSArray<NSString*> *array1 = @[@"打开进风的快点放假快点减肥待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口"];
    
    NSArray<NSString*> *array2 = @[@"打开进风的快点放假快点口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口"];
    
    NSArray<NSString*> *array3 = @[@"打开进风的快点放假快点减肥待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口"];
    
     NSArray<NSString*> *array4 = @[@"打开进风的快点放假快点减肥待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口"];
    
     NSArray<NSString*> *array5 = @[@"打开进风的快点放假快点减肥待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口"];
    
    __block NSMutableArray *heightArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect  =[obj boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
        [heightArray addObject:@(rect.size.width+10)];
    }];
    self.titleArray = array;
    self.labelWidthArray = heightArray;
    
    [self.allArray addObject:array];
    [self.allArray addObject:array1];
    [self.allArray addObject:array2];
    [self.allArray addObject:array3];
    [self.allArray addObject:array4];
    [self.allArray addObject:array5];


}


-(DWCollectionView*)dwCollectionView{
    
    if (!_dwCollectionView) {
        
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.sectionInset = UIEdgeInsetsMake(10, 10, 5, 10);//section之间的上左下右的间距（即collectionView有一个区，这个区有五十个item，这个区相当于在collectionView中的一个容器，这个容器相对于collectionView上左下右的间距）不是item之间的上下左右的间距。
//        layout.minimumInteritemSpacing = 10;//item之间的最下间距，这个数据设置的时最小的间距，当间距小于这个值时，item就会换行显示，但是如果你设置的是10，世纪间距是20也是不会换行的只有小于这个值时才会换行。
//        layout.estimatedItemSize = CGSizeMake(100, 30);
//        layout.headerReferenceSize = CGSizeMake(100, 30);
        
        DWReusableLayout *layout = [[DWReusableLayout alloc] init];
        ///自定义laout下面属性也是有效的只不过如果重写特定方法重置attributes 下面属性的值会被自定义的方法的新值覆盖
        layout.sectionInset = UIEdgeInsetsMake(20, 10, 5, 10);///本质是将这些值作为attributes的frame
        layout.itemSize = CGSizeMake(100, 60);
        
        _dwCollectionView = [[DWCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-100) collectionViewLayout:layout];
        [_dwCollectionView registerClass:[DWReusableCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        [_dwCollectionView registerClass:[DWReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DWReusableView"];
        _dwCollectionView.delegate = self;
        _dwCollectionView.dataSource = self;
        _dwCollectionView.backgroundColor = [UIColor yellowColor];
    }
    return _dwCollectionView;
}


-(NSMutableArray*)allArray{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

@end


@implementation DWReusableCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        self.label = label;
        
        ///使用layout布局则不需要重写layoutSubviews方法并设置subviews的frame
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView).with.offset(0);
        }];
    }
    return self;
}


/**
 *如果不使用约束来定位subviews的位置，就应该重写下面的方法，在其中来设置subviews的frame
 *如果不重写下面的方法，直接在alloc的时候设置frame，当刷新数据源或则滑动布局的时候会发生布局混乱的。
 */

//-(void)layoutSubviews{
//    ///没有调用之前cell的frame
////    NSLog(@"%f----%f-----%f-----%f",self.contentView.frame.origin.x,self.contentView.frame.origin.y,self.contentView.frame.size.width,self.contentView.frame.size.height);
//    [super layoutSubviews];
//    ///subviews的frame更新后，父类的frame也会更新
////    self.label.frame = self.contentView.bounds;
////    NSLog(@"%f----==%f-----==%f----==-%f",self.contentView.frame.origin.x,self.contentView.frame.origin.y,self.contentView.frame.size.width,self.contentView.frame.size.height);
//}

@end
