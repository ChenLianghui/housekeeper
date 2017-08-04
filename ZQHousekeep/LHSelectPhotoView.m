//
//  LHSelectPhotoView.m
//  ZQHousekeep
//
//  Created by 陈良辉 on 2017/7/10.
//  Copyright © 2017年 礼邻网络. All rights reserved.
//

#import "LHSelectPhotoView.h"
#import "LHPhotoCollectionViewCell.h"
#import "JJPhotoManeger.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "HWImagePickerSheet.h"

#define kPhotoItemWidth kWidthIphone7(80)

@interface LHSelectPhotoView ()<UICollectionViewDataSource,UICollectionViewDelegate,JJPhotoDelegate,HWImagePickerSheetDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UILabel *addImageStrLabel;
//选择的图片数据
@property(nonatomic,strong) NSMutableArray *arrSelected;
@property (nonatomic,strong)NSMutableArray *bigImgDataArray;
@property (nonatomic,strong)HWImagePickerSheet *imgPickerActionSheet;
//图片总数量限制
@property(nonatomic,assign) NSInteger maxCount;
@property (nonatomic,assign)CGFloat currentHeight;

@end

@implementation LHSelectPhotoView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createSubViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(kPhotoItemWidth,kPhotoItemWidth);
    layout.sectionInset = UIEdgeInsetsMake(kHeightIphone7(10), kWidthIphone7(10), kHeightIphone7(10), kWidthIphone7(10));
    layout.minimumLineSpacing = kHeightIphone7(10);
    layout.minimumInteritemSpacing = kWidthIphone7(10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = NO;
    [_collectionView registerClass:[LHPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"LHPhotoCollectionViewCell"];
    [self addSubview:_collectionView];
    
    if(_imageArray.count == 0)
    {
        _imageArray = [NSMutableArray array];
    }
    if(_bigImageArray.count == 0)
    {
        _bigImageArray = [NSMutableArray array];
    }
    //上传图片提示
    _addImageStrLabel = [[UILabel alloc]init];
    _addImageStrLabel.text = @"upload pictures";
    _addImageStrLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    [_collectionView addSubview:_addImageStrLabel];
    
    [_collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
        make.bottom.equalTo(self).priority(1);
        make.height.equalTo(kPhotoItemWidth+kHeightIphone7(10)*2).priority(999);
    }];
    
    [_addImageStrLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kPhotoItemWidth+kWidthIphone7(20));
        make.top.equalTo(kHeightIphone7(50));
        make.width.equalTo(kWidthIphone7(120));
        make.height.equalTo(kHeightIphone7(20));
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Set up the reuse identifier
    LHPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"LHPhotoCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row == _imageArray.count) {
        [cell.profilePhoto setImage:[UIImage imageNamed:@"plus"]];
        cell.closeButton.hidden = YES;
        
        //没有任何图片
        if (_imageArray.count == 0) {
            _addImageStrLabel.hidden = NO;
        }
        else{
            _addImageStrLabel.hidden = YES;
        }
    }
    else{
        
        [cell.profilePhoto setImage:[_imageArray[indexPath.item] roundImageWithCornerRadius:kWidthIphone7(10)]];
        cell.closeButton.hidden = NO;
    }
    [cell setBigImageViewWithImage:nil];
    cell.profilePhoto.tag = [indexPath item];
    
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.profilePhoto .userInteractionEnabled = YES;
    [cell.profilePhoto  addGestureRecognizer:singleTap];
    cell.closeButton.tag = [indexPath item];
    [cell.closeButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    [self changeCollectionViewHeight];
    return cell;
}

- (void)changeCollectionViewHeight{
    CGFloat height = (_arrSelected.count/3+1)*(kPhotoItemWidth+kHeightIphone7(10))+kHeightIphone7(10);
    if (_currentHeight != height) {
        _currentHeight = height;
        [_collectionView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(height).priority(999);
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(getNowHeight:)]) {
            [self.delegate getNowHeight:height];
        }
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

#pragma mark - 图片cell点击事件
//点击图片看大图
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == (_imageArray.count)) {
        //添加新图片
        [self addNewImg];
    }
    else{
        //点击放大查看
        LHPhotoCollectionViewCell *cell = (LHPhotoCollectionViewCell*)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        if (!cell.BigImageView || !cell.BigImageView.image) {
            
            [cell setBigImageViewWithImage:[self getBigIamgeWithALAsset:_arrSelected[index]]];
        }
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        [mg showLocalPhotoViewer:@[cell.BigImageView] selecImageindex:0];
    }
}
- (UIImage*)getBigIamgeWithALAsset:(ALAsset*)set{
    //压缩
    // 需传入方向和缩放比例，否则方向和尺寸都不对
    UIImage *img = [UIImage imageWithCGImage:set.defaultRepresentation.fullResolutionImage
                                       scale:set.defaultRepresentation.scale
                                 orientation:(UIImageOrientation)set.defaultRepresentation.orientation];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
    [_bigImgDataArray addObject:imageData];
    
    return [UIImage imageWithData:imageData];
}

#pragma mark - 添加照片
- (void)addNewImg{
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(addNewImages)]) {
//        [self.delegate addNewImages];
//    }
    if (!_imgPickerActionSheet) {
        _imgPickerActionSheet = [[HWImagePickerSheet alloc] init];
        _imgPickerActionSheet.delegate = self;
    }
    if (_arrSelected) {
        _imgPickerActionSheet.arrSelected = _arrSelected;
    }
    _imgPickerActionSheet.maxCount = _maxCount;
    [_imgPickerActionSheet showImgPickerActionSheetInView:self.window.rootViewController];
}

#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    
    [_imageArray removeObjectAtIndex:sender.tag];
    [_arrSelected removeObjectAtIndex:sender.tag];
    
    
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]]];
    
    for (NSInteger item = sender.tag; item <= _imageArray.count; item++) {
        LHPhotoCollectionViewCell *cell = (LHPhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
        cell.closeButton.tag--;
        cell.profilePhoto.tag--;
    }
    
    [self changeCollectionViewHeight];
}

/**
 *  相册完成选择得到图片
 */
-(void)getSelectImageWithALAssetArray:(NSArray *)ALAssetArray thumbnailImageArray:(NSArray *)thumbnailImgArray{
    //（ALAsset）类型 Array
    _arrSelected = [NSMutableArray arrayWithArray:ALAssetArray];
    //正方形缩略图 Array
    _imageArray = [NSMutableArray arrayWithArray:thumbnailImgArray] ;
    
    [self.collectionView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(getBigImagesWithArray:)]) {
        [self.delegate getBigImagesWithArray:[self getBigImageArray]];
    }
}
//获得大图
- (NSArray*)getBigImageArrayWithALAssetArray:(NSArray*)ALAssetArray{
//    _bigImgDataArray = [NSMutableArray array];
    NSMutableArray *bigImgArr = [NSMutableArray array];
    for (ALAsset *set in ALAssetArray) {
        [bigImgArr addObject:[self getBigIamgeWithALAsset:set]];
    }
    self.bigImageArray = bigImgArr;
    return _bigImageArray;
}
 
- (NSArray*)getBigImageArray{
    
    return [self getBigImageArrayWithALAssetArray:_arrSelected];
}


-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
    NSLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}


@end
