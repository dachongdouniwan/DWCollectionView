//
//  ViewController.m
//  DWLayoutCollectionView
//
//  Created by duyawei on 2017/6/30.
//  Copyright © 2017年 duyawei. All rights reserved.
//

#import "ViewController.h"
#import "LayoutStringController.h"
#import "WaterFallController.h"
#import "CommonController.h"
#import "EstimatedItemSizeController.h"
#import "ReusableViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray<NSString*> *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[CommonController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[EstimatedItemSizeController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[LayoutStringController alloc] init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[WaterFallController alloc] init] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[[ReusableViewController alloc] init] animated:YES];
            break;
        default:
            break;
    }
    
}



-(NSArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"普通collectionView",@"estimatedItemSize-Controller",@"自适应String的layout",@"WaterFallController-瀑布流",@"collectionView区头", nil];
    }
    return _dataArray;
}

@end
