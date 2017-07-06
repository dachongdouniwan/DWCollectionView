//
//  CommonController.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/7/6.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "CommonController.h"
#import "DWCollectionView.h"
#import "Masonry.h"
@interface CommonController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) DWCollectionView *dwCollectionView;

@property (nonatomic,strong) NSMutableArray *labelWidthArray;

@property (nonatomic,strong) NSArray<NSString*> *titleArray;
@end

@implementation CommonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self caclueHeight];
    [self.view addSubview:self.dwCollectionView];

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"0000000");
    return self.labelWidthArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DWCommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    cell.label.text = self.titleArray [indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    NSLog(@"%f----%f-----%f-----%f",cell.contentView.frame.origin.x,cell.contentView.frame.origin.y,cell.contentView.frame.size.width,cell.contentView.frame.size.height);
    return cell;
}

/**
 *上下，左右滑动时不会调用此方法来重新返回cell的大小，调用reload方法时会调用。
 *此方法的优先级高于layout.itemSize属性。
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"1111111111");

    NSNumber *widthNumber = self.labelWidthArray[indexPath.row];
    CGFloat width = widthNumber.floatValue;
    return CGSizeMake(width, 30);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    [self.labelWidthArray removeLastObject];
    [collectionView reloadData];
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


-(DWCollectionView*)dwCollectionView{
    
    if (!_dwCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //        layout.itemSize = CGSizeMake(100, 30);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//整个section相对于collectionview的上左下右的间距（即collectionView有一个区，这个区有五十个item，这个区相当于在collectionView中的一个容器，这个容器相对于collectionView上左下右的间距）不是item之间的上下左右的间距。
        layout.minimumInteritemSpacing = 10;//item之间的最下间距，这个数据设置的时最小的间距，当间距小于这个值时，item就会换行显示，但是如果你设置的是10，世纪间距是20也是不会换行的只有小于这个值时才会换行。
        
        _dwCollectionView = [[DWCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) collectionViewLayout:layout];
        [_dwCollectionView registerClass:[DWCommonCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        _dwCollectionView.delegate = self;
        _dwCollectionView.dataSource = self;
        _dwCollectionView.backgroundColor = [UIColor yellowColor];
    }
    return _dwCollectionView;
}



@end


@implementation DWCommonCollectionViewCell

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



