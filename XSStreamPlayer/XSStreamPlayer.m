//  XSStreamPlayer.m
//  XSStreamPlayerDemo
//
//  Created by faterman on 17/1/7.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import "XSStreamPlayer.h"
#import <StreamingKit/STKAudioPlayer.h>

static XSStreamPlayer *streamPlayer = nil;

@interface XSStreamPlayer () <STKAudioPlayerDelegate>
{
    NSTimer *_timer;
}
@property (nonatomic, strong) STKAudioPlayer *audioPlayer;
@end

@implementation XSStreamPlayer

+ (instancetype)shareStreamPlayer {
    if (streamPlayer == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            streamPlayer = [[super allocWithZone:NULL]init];
            streamPlayer.audioPlayer = [[STKAudioPlayer alloc] init];
            streamPlayer.audioPlayer.delegate = streamPlayer;
        });
    }
    return streamPlayer;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [XSStreamPlayer shareStreamPlayer];
}

- (id)copy {
    return [XSStreamPlayer shareStreamPlayer];
}

- (XSStreamPlayerState)state {
    return (NSInteger)self.audioPlayer.state;
}

- (double)progress {

    return self.audioPlayer.progress;
}

- (double)duration {
    return self.audioPlayer.duration;
}


- (void)playWith:(NSString *)urlStr PlayingUIHashCode:(NSString *)playingUIHashCode {
    self.playingUIHashCode = playingUIHashCode;
    [self.audioPlayer play:urlStr];
}

- (void)playWith:(NSString *)urlStr {
    [self.audioPlayer play:urlStr];
    [self startProgressTimer];
    
}

- (void)pause {
    [self.audioPlayer pause];
}

- (void)resume {
    [self.audioPlayer resume];
}

- (void)queueWith:(NSString *)urlStr {
    [self.audioPlayer queue:urlStr];
}

- (void)seekToTime:(double)time {

    [self.audioPlayer seekToTime:time];
}


- (void)startProgressTimer {

    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressCallBack) userInfo:nil repeats:YES];
    [_timer fire];
}


- (void)progressCallBack {
    if ([self.delegate respondsToSelector:@selector(audioPlayer:PlayTo:Duration:)]) {
        [self.delegate audioPlayer:self PlayTo:self.progress Duration:self.duration];
    }

}



#pragma mark - STKAudioPlayerDelegate
- (void)audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState
{
    if ([self.delegate respondsToSelector:@selector(audioPlayer:stateChanged:previousState:)]) {
        [self.delegate audioPlayer:self stateChanged:(NSInteger)state previousState:(NSInteger)previousState];
    }
}

- (void)audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode
{
    if ([self.delegate respondsToSelector:@selector(audioPlayer:unexpectedError:)]) {
        [self.delegate audioPlayer:self unexpectedError:(NSInteger)errorCode];
    }
    
}

- (void)audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    if ([self.delegate respondsToSelector:@selector(audioPlayer:didStartPlayingQueueItemId:)]) {
        [self.delegate audioPlayer:self didStartPlayingQueueItemId:queueItemId];
    }
}

- (void)audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    if ([self.delegate respondsToSelector:@selector(audioPlayer:didFinishBufferingSourceWithQueueItemId:)]) {
        [self.delegate audioPlayer:self didFinishBufferingSourceWithQueueItemId:queueItemId];
    }
    
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
    if ([self.delegate respondsToSelector:@selector(audioPlayer:didFinishPlayingQueueItemId:withReason:andProgress:andDuration:)]) {
        [self.delegate audioPlayer:self didFinishPlayingQueueItemId:queueItemId withReason:(NSInteger)stopReason andProgress:progress andDuration:duration];
    }
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didCancelQueuedItems:(NSArray*)queuedItems{
    
    if ([self.delegate respondsToSelector:@selector(audioPlayer:didCancelQueuedItems:)]) {
    }
    
}

@end
