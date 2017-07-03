//
//  RambagramPageControl.m
//  BuyTicketsSDK
//
//  Created by i.kvyatkovskiy on 4/14/17.
//  Copyright © 2017 Rambler&Co. All rights reserved.
//

#import "RambagramPageControl.h"
#import "RambagramFlowLayout.h"
#import "RambagramPageControllCell.h"

@interface RambagramPageControl () <UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) RambagramFlowLayout *layout;

@end

@implementation RambagramPageControl

- (void)setCurrentPage:(NSUInteger)currentPage {
    BOOL samePage = currentPage == _currentPage;
    BOOL pageOutOfBounds = currentPage >= [self.collectionView numberOfItemsInSection:0];
    if (pageOutOfBounds) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentPage
                                                 inSection:0];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    [self.collectionView selectItemAtIndexPath:indexPath
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
    if (samePage) {
        return;
    }

    BOOL shouldScroll = cell.frame.size.height < self.collectionView.frame.size.height;
    if (shouldScroll) {
        CGFloat step = [self.layout step];
        CGFloat xOffset = currentPage * step;
        if (currentPage > _currentPage) {
            xOffset -= step * 4;
        } else {
            xOffset -= step * 2;
        }
        CGFloat yOffset = self.collectionView.contentOffset.y;
        CGPoint offset = CGPointMake(xOffset,
                                     yOffset);
        [self.collectionView setContentOffset:offset
                                     animated:YES];
    }
    _currentPage = currentPage;
}

- (void)setNumberOfPages:(NSUInteger)numberOfPages {
    if (numberOfPages == _numberOfPages) {
        return;
    }
    _numberOfPages = numberOfPages;
    [self setupCollectionViewWithFrame:self.frame];
    
    if (numberOfPages < 6) {
        self.layout.ignoreScale = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.layout.ignoreScale) {
        return;
    }
    [self setupInitialCollectionViewState];
}

- (void)setupCollectionViewWithFrame:(CGRect)frame {
    [self.collectionView removeFromSuperview];
    
    if (self.numberOfPages < 2) {
        return;
    }
    RambagramFlowLayout *layout = [RambagramFlowLayout new];
    layout.itemSize = self.dotSize;
    layout.minimumLineSpacing = self.spacing;;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGSize contentSize = CGSizeZero;
    contentSize.width = self.numberOfPages * [layout step] - (self.numberOfPages % 2) * layout.minimumLineSpacing ;
    contentSize.height = layout.itemSize.height;
    CGRect collectionViewFrame = CGRectZero;
    NSUInteger numberOfItems = MIN(7, self.numberOfPages);
    
    collectionViewFrame.size.width = numberOfItems * [layout step] - (numberOfItems % 2) * layout.minimumLineSpacing ;
    collectionViewFrame.size.height = layout.itemSize.height;
    collectionViewFrame.origin = CGPointMake(frame.size.width / 2 - collectionViewFrame.size.width / 2,
                                             frame.size.height / 2 - collectionViewFrame.size.height / 2);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame
                                                          collectionViewLayout:layout];
    collectionView.contentSize = contentSize;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.userInteractionEnabled = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    Class cellClass = [RambagramPageControllCell class];
    [collectionView registerClass:cellClass
       forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
    
    [self addSubview:collectionView];

    self.collectionView = collectionView;
    self.layout = layout;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 2 * [self.layout step], 0, 0);
}

- (void)setupInitialCollectionViewState {
    [self setupCollectionViewWithFrame:self.frame];
    CGFloat xOffset = -2 * [self.layout step] + self.currentPage * [self.layout step];
    [self.collectionView setContentOffset:CGPointMake(xOffset, 0)
                                 animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.numberOfPages;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RambagramPageControllCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RambagramPageControllCell class])
                                                                           forIndexPath:indexPath];
    cell.dotColor = self.dotColor;
    cell.selectedDotColor = self.selectedDotColor;
    cell.selected = self.currentPage == indexPath.row;
    return cell;
}

@end