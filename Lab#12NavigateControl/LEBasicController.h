//
//  LEBasicController.h
//  Lab#12NavigateControl
//
//  Created by Evgheny on 31.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LEBasicControllerDelegate <NSObject>

-(void)moveRight;
-(void)restoreView;

@end


@interface LEBasicController : UIViewController

@property (nonatomic,weak) id <LEBasicControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *largeImage;



@end
