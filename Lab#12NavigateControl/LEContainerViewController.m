//
//  LEContainerViewController.m
//  Lab#12NavigateControl
//
//  Created by Evgheny on 31.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//
#import "LEContainerViewController.h"
#import "LEBasicController.h"
#import "LELeftController.h"

@interface LEContainerViewController ()<LEBasicControllerDelegate, UIGestureRecognizerDelegate>

@property (strong,nonatomic) LEBasicController *basicView;
@property (strong,nonatomic) LELeftController *leftControl;
@property (assign,nonatomic) BOOL showingLeftView;
@property (assign,nonatomic) BOOL showWithGesture;
@property (assign, nonatomic) BOOL showingRightPanel;;
@property (assign, nonatomic) CGPoint velocity;


@end

static NSInteger centerTag  = 1;
static NSInteger radius = 4;
static NSInteger leftPanTag = 2;
static float slideTiming = 0.25;
static NSInteger width = 380;


@implementation LEContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
 
}

-(void)setupView{
    
    self.basicView = [[LEBasicController alloc]initWithNibName:@"basic" bundle:nil];
    self.basicView.view.tag = centerTag;
    self.basicView.delegate = (id)self;

    [self.view addSubview:self.basicView.view];
    [self addChildViewController:self.basicView];
    
    [self.basicView didMoveToParentViewController:self];
    
    [self gesturesInit];
}


- (void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset
{
    
    if (value)
    {
        [self.basicView.view.layer setCornerRadius:radius];
        [self.basicView.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.basicView.view.layer setShadowOpacity:0.8];
        [self.basicView.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    }
    else
    {
        [self.basicView.view.layer setCornerRadius:0.0f];
        [self.basicView.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
    
}
#pragma mark leftViewSlide

- (UIView *)getLeftView
{
    if (self.leftControl == nil)
    {
        self.leftControl = [[LELeftController alloc] initWithNibName:@"left" bundle:nil];
        self.leftControl.view.tag = leftPanTag;
        self.leftControl.basiccontroller = self.basicView;
        
        [self.view addSubview:self.leftControl.view];
        
        [self addChildViewController:self.leftControl];
        [self.leftControl didMoveToParentViewController:self];
        self.basicView.button.titleLabel.text = @"Back";
        self.leftControl.view.frame = CGRectMake(0, 0, self.view.frame.size.width-200, self.view.frame.size.height);
    }
    
    self.showingLeftView = YES;
    
    [self showCenterViewWithShadow:YES withOffset:-2];
    
    UIView *view =self.leftControl.view;
    return view;
}

-(void)moveRight{
    
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:slideTiming delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _basicView.view.frame = CGRectMake(self.view.frame.size.width - width, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             _basicView.button.tag = 0;
                         }
                     }];
}
#pragma mark backTransition

- (void)restoreView
{
    
    [UIView animateWithDuration:slideTiming delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.basicView.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             [self resetMainView];
                         }
                     }];
}

- (void)resetMainView
{
    
    if (self.leftControl != nil)
    {
        [self.leftControl.view removeFromSuperview];
        [self.leftControl removeFromParentViewController];
        self.leftControl = nil;
        self.basicView.button.tag = 1;
        self.showingLeftView = NO;
    }
    
    [self showCenterViewWithShadow:NO withOffset:0];
    
}

#pragma mark Gestures

-(void)gesturesInit{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveWithGesture:)];
    [pan setMinimumNumberOfTouches:1];
    [pan setMaximumNumberOfTouches:1];
    [pan setDelegate:self];
    
    [self.basicView.view addGestureRecognizer:pan];
}

-(void)moveWithGesture:(id)sender{
 
    NSLog(@"moveWithGesture");
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        UIView *childView = nil;
        
        if(velocity.x > 0) {
            if (!_showingRightPanel) {
                childView = [self getLeftView];
            }
        }
        
        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }

    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if(velocity.x > 0) {
             NSLog(@"gesture went right");
        }
        if (!self.showingRightPanel) [self restoreView];//closing
        
        if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
    
            self.showingRightPanel  = fabsf([sender view].center.x -  self.basicView.view.frame.size.width/2) > self.basicView.view.frame.size.width/2;
    
            [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
            [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
            
            
            
            _velocity = velocity;
        }
    
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
