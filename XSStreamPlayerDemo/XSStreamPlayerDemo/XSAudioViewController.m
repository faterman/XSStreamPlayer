//
//  XSAudioViewController.m
//  XSStreamPlayerDemo
//
//  Created by faterman on 17/1/8.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSAudioViewController.h"
#import "XSStreamPlayer.h"
static NSString *demoAudioUrlStr = @"http://wyyimg.aspoontech.com/webimg/mp3/6961357070508281482304117930.mp3";

@interface XSAudioViewController ()
{
    XSStreamPlayer *_streamPlayer;
}

@property (weak, nonatomic) IBOutlet UISlider *audioProgressSlider;

@end

@implementation XSAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _streamPlayer = [XSStreamPlayer shareStreamPlayer];
}
- (IBAction)playAction:(id)sender {
    [_streamPlayer playWith:demoAudioUrlStr];
}
- (IBAction)pauseAction:(id)sender {
}
- (IBAction)stopAction:(id)sender {
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
