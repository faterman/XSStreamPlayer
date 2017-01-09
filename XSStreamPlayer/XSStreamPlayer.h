//
//  XSStreamPlayer.h
//  XSStreamPlayerDemo
//
//  Created by faterman on 17/1/7.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XSStreamPlayer;

typedef NS_OPTIONS(NSInteger, XSStreamPlayerState)
{
    XSStreamPlayerStateReady,
    XSStreamPlayerStateRunning = 1,
    XSStreamPlayerStatePlaying = (1 << 1) | XSStreamPlayerStateRunning,
    XSStreamPlayerStateBuffering = (1 << 2) | XSStreamPlayerStateRunning,
    XSStreamPlayerStatePaused = (1 << 3) | XSStreamPlayerStateRunning,
    XSStreamPlayerStateStopped = (1 << 4),
    XSStreamPlayerStateError = (1 << 5),
    XSStreamPlayerStateDisposed = (1 << 6)
};

typedef NS_ENUM(NSInteger, XSStreamPlayerStopReason)
{
    XSStreamPlayerStopReasonNone = 0,
    XSStreamPlayerStopReasonEof,
    XSStreamPlayerStopReasonUserAction,
    XSStreamPlayerStopReasonPendingNext,
    XSStreamPlayerStopReasonDisposed,
    XSStreamPlayerStopReasonError = 0xffff
};

typedef NS_ENUM(NSInteger, XSStreamPlayerErrorCode)
{
    XSStreamPlayerErrorNone = 0,
    XSStreamPlayerErrorDataSource,
    XSStreamPlayerErrorStreamParseBytesFailed,
    XSStreamPlayerErrorAudioSystemError,
    XSStreamPlayerErrorCodecError,
    XSStreamPlayerErrorDataNotFound,
    XSStreamPlayerErrorOther = 0xffff
};

/// 状态回调方法
@protocol XSStreamPlayerDelegate <NSObject>

@optional
/// 当播放器 状态发生改变的时候调用,暂停-开始播放都会调用
- (void)audioPlayer:(XSStreamPlayer *)audioPlayer stateChanged:(XSStreamPlayerState)state previousState:(XSStreamPlayerState)previousState;

/// 引发的意外和可能发生的不可恢复的错误，极少概率会调用。就是此音频不能加载，或者url是不可用的
- (void)audioPlayer:(XSStreamPlayer *)audioPlayer unexpectedError:(XSStreamPlayerErrorCode)errorCode;

/// 当一个项目开始播放调用
- (void)audioPlayer:(XSStreamPlayer *)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId;

// 一般是歌曲快结束提前5秒调用
- (void)audioPlayer:(XSStreamPlayer *)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId;

///当一个项目完成后，就调用
-(void) audioPlayer:(XSStreamPlayer *)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(XSStreamPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration;

@end

@interface XSStreamPlayer : NSObject

/// 获得当前播放器状态
@property(nonatomic, readonly, assign) XSStreamPlayerState state;
@property(nonatomic, weak) id<XSStreamPlayerDelegate>delegate;
/// 一致就可以判定当前播放控件为正在播放的控件，播放控件需实现钙值并传入
@property (nonatomic, assign) NSString *playingUIHashCode;


+ (instancetype)shareStreamPlayer;

- (void)playWith:(NSString *)urlStr;

- (void)playWith:(NSString *)urlStr PlayingUIHashCode:(NSString *)playingUIHashCode;

- (void)queueWith:(NSString *)urlStr;

@end
