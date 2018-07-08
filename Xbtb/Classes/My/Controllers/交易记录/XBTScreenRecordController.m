//
//  DMScreenRecordController.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTScreenRecordController.h"
#import "XBTScreenRecordCell.h"

@interface XBTScreenRecordController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<NSDictionary *> *dataArray;

@end

@implementation XBTScreenRecordController

- (NSArray<NSDictionary *> *)dataArray
{
    if (_dataArray == nil) {
        if (self.type == 1) {  //交易记录
            _dataArray = @[@{@"title":@"全部",@"type":@"0"},
                           @{@"title":@"充值",@"type":@"1"},
                           @{@"title":@"提现",@"type":@"4"},
                           @{@"title":@"回款",@"type":@"12"},
                           @{@"title":@"收息",@"type":@"13"},
                           @{@"title":@"红包奖励",@"type":@"16"}];
        }else{
            _dataArray = @[@{@"title":@"全部",@"type":@""},
                           @{@"title":@"招标中",@"type":@"3"},
                           @{@"title":@"已还清",@"type":@"6"},
                           @{@"title":@"还款中",@"type":@"5"}];
        }
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI
{
    self.view.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:0.9];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, kScreenH - 45 - SafeAreaBottomHeight, kScreenW, 45);
    [button addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = CGSizeMake((kScreenW - 20) / 3.0, 40);
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kScreenH - 50 - 100 - SafeAreaBottomHeight, kScreenW, 100) collectionViewLayout:layout];
    collection.backgroundColor = kColor(247, 247, 247);
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerNib:[UINib nibWithNibName:@"XBTScreenRecordCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"XBTScreenRecordCell"];
    [self.view addSubview:collection];
}

- (void)cancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XBTScreenRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XBTScreenRecordCell" forIndexPath:indexPath];
    cell.backgroundColor = kColor(241, 176, 66);
    cell.titleString = self.dataArray[indexPath.row][@"title"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    WeakSelf
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.selectBlock) {
            weakSelf.selectBlock(weakSelf.dataArray[indexPath.row][@"type"]);
        }
    }];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 5, 0, 5);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
