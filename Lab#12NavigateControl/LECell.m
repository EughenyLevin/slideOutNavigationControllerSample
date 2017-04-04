//
//  LECell.m
//  Lab#12NavigateControl
//
//  Created by Evgheny on 31.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LECell.h"

@implementation LECell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-50, self.contentView.frame.origin.y+25, 120, 120)];
        _cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, self.bounds.size.width, 40)];
        _cellLabel.textColor = [UIColor greenColor];
        _cellLabel.textAlignment = NSTextAlignmentCenter;
        _cellLabel.font = [UIFont boldSystemFontOfSize:16];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.cellLabel];
        
    }
    return self;
    
}
@end
