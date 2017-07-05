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
#import "Masonry.h"
@interface LayoutStringController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) DWCollectionView *dwCollectionView;

@property (nonatomic,strong) DWCollectionViewLayout *dwLayout;

@property (nonatomic,strong) NSMutableArray *labelWidthArray;

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
}


-(void)caclueHeight{
    
    NSArray<NSString*> *array = @[@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减肥肯德基发动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口"];
    
    __block NSMutableArray *heightArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect  =[obj boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
        NSLog(@"****%f",rect.size.width);
        [heightArray addObject:@(rect.size.width+10)];
    }];
    self.titleArray = array;
    self.labelWidthArray = heightArray;
    NSLog(@"====%p",self.labelWidthArray);
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.labelWidthArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    cell.label.text = self.titleArray [indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    
//    NSLog(@"%f----%f-----%f-----%f",cell.contentView.frame.origin.x,cell.contentView.frame.origin.y,cell.contentView.frame.size.width,cell.contentView.frame.size.height);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了哪个cell--%ld",indexPath.row);
    [self.labelWidthArray removeLastObject];
    [collectionView reloadData];
    [self.dwLayout invalidateLayout];
}

-(UICollectionViewFlowLayout*)dwLayout{
    if (!_dwLayout) {
        _dwLayout = [[DWCollectionViewLayout alloc] initWithArray:self.labelWidthArray edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    return _dwLayout;
}

-(DWCollectionView*)dwCollectionView{
    
    if (!_dwCollectionView) {
        _dwCollectionView = [[DWCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 400) collectionViewLayout:self.dwLayout];
        [_dwCollectionView registerClass:[DWCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        _dwCollectionView.delegate = self;
        _dwCollectionView.dataSource = self;
        _dwCollectionView.backgroundColor = [UIColor yellowColor];
    }
    return _dwCollectionView;
}

@end

@implementation DWCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(@(0));
            make.height.mas_equalTo(@(30));
            ///宽度最小为100
            make.width.mas_greaterThanOrEqualTo(@(100)).priority(1000);
        }];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        self.label = label;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView).with.offset(0);
        }];
    }
    return self;
}


//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    
//    ///此处调用父类所等到的attributes 和你最后得到的layoutAttributes的size完全一样，如果只是修改size完全没必要重写,如果layout没有设置layout.estimatedItemSize，则attributes和layoutAttributes的size一样
//    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    NSLog(@"%f====%f",layoutAttributes.size.width,layoutAttributes.size.height);
//    
//    NSLog(@"%f********%f",attributes.size.width,attributes.size.height);
//    
//    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
//    CGRect newFrame = layoutAttributes.frame;
//    newFrame.size.width = size.width;
//    layoutAttributes.frame = newFrame;
//    NSLog(@"%f------%f",size.width,size.height);
//    return layoutAttributes;
//}


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

