//
//  ViewController.m
//  UberTest
//
//  Created by KWAME on 15/4/22.
//  Copyright (c) 2015年 KWAME. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController ()
{
    UIView *redView;
}
@property (strong, nonatomic) MPMoviePlayerController * player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect rx = [ UIScreen mainScreen ].bounds;
    CGFloat myW = 2;
    redView=[[UIView alloc]initWithFrame:CGRectMake((rx.size.width-myW)/2, (rx.size.height-myW)/2, myW, myW)];
    redView.layer.borderWidth = 2;
    redView.layer.borderColor = [[UIColor colorWithRed:(33/255.0 ) green: (172/255.0) blue: (204/255.0) alpha:1.0] CGColor];
    [self.view addSubview:redView];
    [self performSelector:@selector(animationOfCABasicAnimation) withObject:nil afterDelay:2.0f];
    [self performSelector:@selector(imgGif) withObject:nil afterDelay:2.0f];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:5.0f];
}

- (void) imgGif{
    CGRect rx = [ UIScreen mainScreen ].bounds;
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame: CGRectMake((rx.size.width-277)/2, (rx.size.height-277)/2, 277,277)];
    NSMutableArray * imgArray = [NSMutableArray array];
    for (int i = 1; i<=67; i++) {
        NSString * img = [NSString stringWithFormat:@"logo-%03d",i];
        UIImage * my = [UIImage imageNamed:img];
        [imgArray addObject:my];
    }
    NSLog(@"%@",imgArray);
    [imgView setImage:[UIImage imageNamed:@"logo-067"]];
    imgView.animationImages = imgArray;
    imgView.animationDuration = 5.0;
    imgView.animationRepeatCount = 1;
    [imgView startAnimating];
    [self.view insertSubview:imgView atIndex:[[self.view subviews] count]];
}
-(void)animationOfCABasicAnimation
{
    CGRect rx = [ UIScreen mainScreen ].bounds;
    CGFloat myW = rx.size.width-20;
    redView.frame = CGRectMake((rx.size.width-myW)/2, (rx.size.height-myW)/2, myW, myW);
    redView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yyy"]];
    //将图层的边框设置为圆脚
    redView.layer.cornerRadius = myW/2;
    redView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    
    redView.layer.borderWidth = 2;
    //    [UIColor colorWithRed: (33/255.0 ) green: (172/255.0) blue: (204/255.0) alpha:1.0];
    
    redView.layer.borderColor = [[UIColor colorWithRed:(33/255.0 ) green: (172/255.0) blue: (204/255.0) alpha:1.0] CGColor];
    
    [self.view addSubview:redView];
    //创建一个CABasicAnimation对象
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    redView.layer.anchorPoint = CGPointMake(.5,.5);
    animation.fromValue = @0.0f;
    animation.toValue = @1.0f;
    
    //动画时间
    animation.duration=0.5;
    //是否反转变为原来的属性值
    //     animation.autoreverses=YES;
    //把animation添加到图层的layer中，便可以播放动画了。forKey指定要应用此动画的属性
    [redView.layer addAnimation:animation forKey:@"scale"];
    [UIView animateWithDuration:3 animations:^{
        redView.alpha = 0;
        
    }];
}
-(void)delayMethod{
    NSString *myFilePath = [[NSBundle mainBundle]pathForResource:@"welcome_video"ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:myFilePath];
    _player =[[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    [self.view insertSubview:_player.view atIndex:[[self.view subviews] count]-1];
    _player.shouldAutoplay=YES;
    [_player setControlStyle:MPMovieControlStyleNone];
    _player.repeatMode = MPMovieRepeatModeOne;
    [_player.view setFrame:self.view.bounds];
    _player.view.alpha = 0;
    [UIView animateWithDuration:3 animations:^{
        _player.view.alpha = 1;
        [_player prepareToPlay];
        
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}
- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
