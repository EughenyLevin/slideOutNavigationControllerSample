//
//  LECell.h
//  Lab#12NavigateControl
//
//  Created by Evgheny on 31.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LELeftController.h"
@interface LECell : UICollectionViewCell
@property (nonatomic,strong) IBOutlet  UIImageView *imageView;
@property (nonatomic,strong) IBOutlet  UILabel *cellLabel;
@end
