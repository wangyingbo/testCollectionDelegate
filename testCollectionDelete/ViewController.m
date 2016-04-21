//
//  ViewController.m
//  testCollectionDelete
//
//  Created by 王迎博 on 16/4/5.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "ViewController.h"
#import "YBWNPhotoCell.h"


#define WNPhoteCell @"photoCell"
//屏幕的宽和高
#define FULL_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define FULL_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define VIEWLAYOUT_W  FULL_SCREEN_WIDTH/375
#define VIEWLAYOUT_H  FULL_SCREEN_HEIGHT/667


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 创建CollectionView
    CGFloat x = 0;
    CGFloat y = 150;
    CGFloat w = self.view.frame.size.width;
    CGFloat h = 270;
    CGRect frame = CGRectMake(x, y, w, h);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerClass:[YBWNPhotoCell class] forCellWithReuseIdentifier:WNPhoteCell];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSArray *a = @[@"1",@"2",@"3",@"4",@"5",@"6"];
        [_dataArray addObjectsFromArray:a];
    }
    return _dataArray;
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YBWNPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WNPhoteCell forIndexPath:indexPath];
    
    return cell;
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    [self.dataArray removeObjectAtIndex:indexPath.item];
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
    if (self.dataArray.count == 3) {
        CGRect rect = self.collectionView.frame;
        rect.size.height -= 135;
        self.collectionView.frame = rect;
    }
    
}

# pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake((FULL_SCREEN_WIDTH - 60)/3, (FULL_SCREEN_WIDTH - 60)/3);
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    return insets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

@end
