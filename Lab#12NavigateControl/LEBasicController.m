//
//  LEBasicController.m
//  Lab#12NavigateControl
//  Created by Evgheny on 31.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LEBasicController.h"

@interface LEBasicController ()

@end

@implementation LEBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button.tag = 1;
    self.view.frame = CGRectMake(0, 0, 1280, 960);
    
}

#pragma buttonActionsHandler

- (IBAction)onButtonTouch:(id)sender {
    
    UIButton *button = sender;
    switch (button.tag) {
        case 0: {
            [_delegate restoreView];
            break;
        }
            
        case 1: {
            [_delegate moveRight];
            break;
        }
            
        default:
            break;
    }

}
@end
