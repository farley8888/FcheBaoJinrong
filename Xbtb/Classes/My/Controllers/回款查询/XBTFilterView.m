//
//  DMFilterView.m
//  CheBaoJinRong
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XBTFilterView.h"
#import "DMFilterViewCell.h"

@interface XBTFilterView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation XBTFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setCollectionUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = CGSizeMake((kScreenW - 15)/3.0, 30);
    
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.height * 0.7, self.width, self.height * 0.3)collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerNib:[UINib nibWithNibName:@"DMFilterViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"DMFilterViewCell"];
//    [collection  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self addSubview:collection];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DMFilterViewCell" forIndexPath:indexPath];
    
    return cell;
}

@end
