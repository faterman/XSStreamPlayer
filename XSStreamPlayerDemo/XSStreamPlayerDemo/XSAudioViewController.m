//
//  XSAudioViewController.m
//  XSStreamPlayerDemo
//
//  Created by faterman on 17/1/8.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSAudioViewController.h"
#import "XSAudioView.h"
#import "XSStreamPlayer.h"

static NSString *demoAudioUrlStr = @"http://wyyimg.aspoontech.com/webimg/mp3/6961357070508281482304117930.mp3";

@interface XSAudioViewController ()<XSStreamPlayerDelegate>
{
    XSStreamPlayer *_streamPlayer;
//    XSAudioView *_audioView;
}

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISlider *processSlider;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@end

@implementation XSAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    _streamPlayer = [XSStreamPlayer shareStreamPlayer];
    _streamPlayer.delegate = self;
    [self.processSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}
- (IBAction)paly:(id)sender {
    
    
    
    if (_streamPlayer.state == XSStreamPlayerStatePlaying) {
        
        
        [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_streamPlayer pause];
        
    }else if (_streamPlayer.state == XSStreamPlayerStatePaused){
    
        
        
        [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [_streamPlayer resume];


    }else{
        
        [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [_streamPlayer playWith:demoAudioUrlStr];

    }
}
- (void)sliderValueChanged:(UISlider *)silder{

    if (_streamPlayer.duration > 0) {
        [_streamPlayer seekToTime:self.processSlider.value * _streamPlayer.duration];
    }
    
}

#pragma mark - XSStreamPlayerDelegate
- (void)audioPlayer:(XSStreamPlayer *)audioPlayer stateChanged:(XSStreamPlayerState)state previousState:(XSStreamPlayerState)previousState{

    
    self.statusLabel.text = [NSString stringWithFormat:@"%ld-->%ld",previousState,state];

}
- (void)audioPlayer:(XSStreamPlayer *)audioPlayer PlayTo:(double)progress Duration:(double)duration{

    NSLog(@"%f/%f",progress,duration);
    self.processSlider.value = progress / duration;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
