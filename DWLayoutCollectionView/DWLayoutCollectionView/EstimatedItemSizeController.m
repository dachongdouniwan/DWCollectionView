//
//  EstimatedItemSizeController.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/7/6.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "EstimatedItemSizeController.h"
#import "DWCollectionView.h"
#import "Masonry.h"
@interface EstimatedItemSizeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) DWCollectionView *dwCollectionView;

@property (nonatomic,strong) NSMutableArray *labelWidthArray;

@property (nonatomic,strong) NSArray<NSString*> *titleArray;
@end

@implementation EstimatedItemSizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self caclueHeight];
    [self.view addSubview:self.dwCollectionView];
}


-(void)caclueHeight{
    
    NSArray<NSString*> *array = @[@"打开进",@"打开进风口打开进风口打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减肥肯德基发动机等待口快点减肥肯德基发动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减肥肯德基发动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减肥肯德基发动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的快点放假快点减肥肯德基发动机等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口",@"打开进",@"打开进风口",@"打开进风的等待口",@"打开等待进风口"];
    
    __block NSMutableArray *heightArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect  =[obj boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
        [heightArray addObject:@(rect.size.width+10)];
    }];
    self.titleArray = array;
    self.labelWidthArray = heightArray;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.labelWidthArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EstimatedItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    cell.label.text = self.titleArray [indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    //    NSLog(@"%f----%f-----%f-----%f",cell.contentView.frame.origin.x,cell.contentView.frame.origin.y,cell.contentView.frame.size.width,cell.contentView.frame.size.height);
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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
        [_dwCollectionView registerClass:[EstimatedItemCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        _dwCollectionView.delegate = self;
        _dwCollectionView.dataSource = self;
        _dwCollectionView.backgroundColor = [UIColor yellowColor];
    }
    return _dwCollectionView;
}

@end


@implementation EstimatedItemCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        //1.设置self.contentView的约束，设置宽度就定高，设置高度就定宽（无论定宽还是定高，都不能超过collectionview的宽度和高度）
        //以上面控制器为例子：我的需求是定高，自适应宽度（最大宽度为collectionview宽度超过不显示，label不能自动换行）
        //如果不设置contenview的约束：宽度默认就为一个汉子字符的宽度为17.333，高度随着label的换行而增加。如果label不能换行则宽度会一直增加，超出屏幕后继续增加导致约束错误而卡死。

        //如果按照下面的约束设置contenview的约束，设置定高为30，最小宽度为100，
        //问题：因为数据源中第六个元素的宽度超过了collectionview的宽度所以会持续报错导致约束失败。
        //解决方法：不设置最小宽度，设置最大宽度，如果设置了label可以自动换行也是可以将make.height.mas_equalTo(@(30))去掉，这样就可以自动换行了
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(@(0));
            make.height.mas_equalTo(@(30));
            ///宽度最小为100
//            make.width.mas_greaterThanOrEqualTo(@(100)).priority(1000);
            ///设置最大宽度为390，最大宽度不能超过，DWCollectionView的宽度-左右边距-item的间距*item间距个数，超过就会卡死，debug疯狂输出log
            make.width.mas_lessThanOrEqualTo([UIScreen mainScreen].bounds.size.width-19);
        }];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        self.label = label;
        
        //2.设置好subviews的约束
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView).with.offset(0);
        }];
    }
    return self;
}


///3.如果部需要更多关于UICollectionViewLayoutAttributes的操作建议不要重写
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    ///此处调用父类所等到的attributes 和你最后得到的layoutAttributes的size完全一样，如果只是修改size完全没必要重写,如果layout没有设置layout.estimatedItemSize，则attributes和layoutAttributes的size一样
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    NSLog(@"%f====%f",layoutAttributes.size.width,layoutAttributes.size.height);
    NSLog(@"%f********%f",attributes.size.width,attributes.size.height);
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect newFrame = layoutAttributes.frame;
    newFrame.size.width = size.width;
    layoutAttributes.frame = newFrame;
    NSLog(@"%f------%f",size.width,size.height);
    return attributes;
}


@end

