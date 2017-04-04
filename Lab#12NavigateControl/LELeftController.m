//
//  LELeftController.m
//  Lab#12NavigateControl
//
//  Created by Evgheny on 31.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LELeftController.h"
#import "LECell.h"

@interface LELeftController ()
@property (strong,nonatomic) NSMutableArray *data;
@property (strong,nonatomic) LECell *cellClass;
@property (strong,nonatomic) NSString *currentCell;
@property (strong,nonatomic) UIColor *viewColor;
@end

@implementation LELeftController

-(void)viewWillAppear:(BOOL)animated{
    
    [self initializeArray];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.multipleTouchEnabled = NO;
    [self.collectionView reloadData];
    
}


-(void)initializeArray{
   
    _data = [NSMutableArray array];
    for (int i =1; i<500; i++) {
        if (i<10)
            [self.data addObject:[NSString stringWithFormat:@"Images/avatar0%d.jpg",i]];
        else  [self.data addObject:[NSString stringWithFormat:@"Images/avatar%d.jpg",i]];    [self.collectionView registerClass:[LECell class] forCellWithReuseIdentifier:@"cellID"];
    }
}

#pragma mark - dataSurce

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.data.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LECell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.data objectAtIndex:indexPath.row]]];
    cell.cellLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];

    
    if (cell.selected) {
        cell.backgroundColor = [UIColor blueColor]; // highlight selection
    }
    else
    {
        cell.backgroundColor = [UIColor clearColor]; // Default color
    }
    return cell;

}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.frame.size.width,collectionView.frame.size.width-20);
}
-(UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 5);//insets between cells
}

#pragma mark  - delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LECell *selectCell = (LECell*)[collectionView cellForItemAtIndexPath:indexPath];
    selectCell.backgroundColor = [UIColor blueColor];
    selectCell.cellLabel.textColor = [UIColor whiteColor];
    self.basiccontroller.largeImage.image = selectCell.imageView.image;
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LECell *selectCell = (LECell*)[collectionView cellForItemAtIndexPath:indexPath];
    selectCell.backgroundColor = [UIColor whiteColor];
    selectCell.cellLabel.textColor = [UIColor blackColor];
    
}

@end
