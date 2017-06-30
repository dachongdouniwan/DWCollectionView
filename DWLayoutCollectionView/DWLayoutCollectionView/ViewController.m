//
//  ViewController.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/6/30.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "ViewController.h"
#import "DWCollectionView.h"
#import "DWCollectionViewLayout.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) DWCollectionView *dwCollectionView;

@property (nonatomic,strong) DWCollectionViewLayout *dwLayout;

@property (nonatomic,strong) NSArray *labelWidthArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.labelWidthArray = @[@(200),@(60),@(100)];
    [self.view addSubview:self.dwCollectionView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.center = self.view.center;
    titleLabel.numberOfLines = 0;
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"打开进风口大家反馈大家疯狂的积分快到附近的客服即可得分";
    [titleLabel sizeToFit];
    [self.view addSubview:titleLabel];
    
    NSLog(@"---%f",titleLabel.bounds.size.height);
    CGRect frame = titleLabel.frame;
    CGFloat height = titleLabel.bounds.size.height+30;
    frame.size.height = height;
    titleLabel.frame = frame;
    
    titleLabel.text = @"打开进风口大家反馈大家疯狂的积分快到附近的客服即可得分打开进风口大家反馈大家疯狂的积分快到附近的客服即可得分";
    [titleLabel sizeToFit];

}


-(UICollectionViewFlowLayout*)dwLayout{
    if (!_dwLayout) {
        _dwLayout = [[DWCollectionViewLayout alloc] initWithArray:@[@(40),@(60),@(80),@(60),@(100),@(100),@(80),@(65),@(75),@(60),@(120),@(60),@(100),@(55),@(60),@(100),@(80),@(65),@(75),@(95)]];
//        _dwLayout.minimumLineSpacing = 5;
//        _dwLayout.minimumInteritemSpacing = 10;
    }
    return _dwLayout;
}


-(DWCollectionView*)dwCollectionView{
    
    if (!_dwCollectionView) {
        _dwCollectionView = [[DWCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.dwLayout];
        [_dwCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        _dwCollectionView.delegate = self;
        _dwCollectionView.dataSource = self;
    }
    return _dwCollectionView;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSNumber *number = self.labelWidthArray[indexPath.row];
//    CGFloat width = number.floatValue;
//    return CGSizeMake(width, 30);
//}

@end
