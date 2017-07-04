//
//  LayoutStringController.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/6/30.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "LayoutStringController.h"
#import "DWCollectionView.h"
#import "DWCollectionViewLayout.h"
@interface LayoutStringController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) DWCollectionView *dwCollectionView;

@property (nonatomic,strong) DWCollectionViewLayout *dwLayout;

@property (nonatomic,strong) NSArray *labelWidthArray;

@property (nonatomic,strong) NSArray<NSString*> *titleArray;


@end

@implementation LayoutStringController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
//    self.labelWidthArray = @[@(40),@(60),@(80),@(60),@(100),@(100),@(80),@(65),@(75),@(60),@(120),@(60),@(100),@(55),@(60),@(100),@(80),@(65),@(75),@(95),@(55),@(60),@(100),@(80),@(65),@(75)];
    [self caclueHeight];
    [self.view addSubview:self.dwCollectionView];
    
    [self caclueHeight];
}


-(void)caclueHeight{
    
    NSArray<NSString*> *array = @[@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开",@"打开进口",@"打开进风口",@"打开进风口",@"打开进风口",@"打开进风等待口",@"打开的豆腐豆腐豆腐豆腐放方法风口",@"打开的等待进风口",@"打开点点滴滴风口",@"打开进豆腐豆腐豆腐风口",@"打开进风口",@"打开进的疯狂减肥风口",@"打开进风口",@"打开进对方的风口",@"打开进风放豆腐豆腐口",@"打开进风口",@"打开",@"打开进风口疯狂"];
    
    __block NSMutableArray *heightArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect  =[obj boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
        NSLog(@"****%f",rect.size.width);
        [heightArray addObject:@(rect.size.width+10)];
    }];
    self.titleArray = array;
    self.labelWidthArray = heightArray;
}

-(UICollectionViewFlowLayout*)dwLayout{
    if (!_dwLayout) {
        _dwLayout = [[DWCollectionViewLayout alloc] initWithArray:self.labelWidthArray edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    return _dwLayout;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.labelWidthArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    [cell.contentView addSubview:titleLabel];
    titleLabel.text = self.titleArray [indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了哪个cell--%ld",indexPath.row);
//    [self.dwLayout invalidateLayout];
    [collectionView reloadData];
}


-(DWCollectionView*)dwCollectionView{
    
    if (!_dwCollectionView) {
        _dwCollectionView = [[DWCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 400) collectionViewLayout:self.dwLayout];
        [_dwCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        _dwCollectionView.delegate = self;
        _dwCollectionView.dataSource = self;
        _dwCollectionView.backgroundColor = [UIColor yellowColor];
    }
    return _dwCollectionView;
}

@end
