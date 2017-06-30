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

@end

@implementation LayoutStringController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.labelWidthArray = @[@(40),@(60),@(80),@(60),@(100),@(100),@(80),@(65),@(75),@(60),@(120),@(60),@(100),@(55),@(60),@(100),@(80),@(65),@(75),@(95)];
    [self.view addSubview:self.dwCollectionView];
}

-(UICollectionViewFlowLayout*)dwLayout{
    if (!_dwLayout) {
        _dwLayout = [[DWCollectionViewLayout alloc] initWithArray:self.labelWidthArray];
    }
    return _dwLayout;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.labelWidthArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了哪个cell--%ld",indexPath.row);
}


-(DWCollectionView*)dwCollectionView{
    
    if (!_dwCollectionView) {
        _dwCollectionView = [[DWCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) collectionViewLayout:self.dwLayout];
        [_dwCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        _dwCollectionView.delegate = self;
        _dwCollectionView.dataSource = self;
    }
    return _dwCollectionView;
}

@end
