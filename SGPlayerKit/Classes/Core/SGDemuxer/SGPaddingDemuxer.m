//
//  SGPaddingDemuxer.m
//  SGPlayer
//
//  Created by Single on 2019/6/4.
//  Copyright © 2019 single. All rights reserved.
//

#import "SGPaddingDemuxer.h"
#import "SGPacket+Internal.h"
#import "SGError.h"

@interface SGPaddingDemuxer ()

@property (nonatomic, readonly) CMTime lasttime;

@end

@implementation SGPaddingDemuxer

@synthesize tracks = _tracks;
@synthesize options = _options;
@synthesize delegate = _delegate;
@synthesize metadata = _metadata;
@synthesize duration = _duration;
@synthesize finishedTracks = _finishedTracks;

- (instancetype)initWithDuration:(CMTime)duration
{
    if (self = [super init]) {
        self->_duration = duration;
        [self seekToTime:kCMTimeZero];
    }
    return self;
}

#pragma mark - Control

- (id<SGDemuxable>)sharedDemuxer
{
    return nil;
}

- (NSError *)open
{
    return nil;
}

- (NSError *)close
{
    return nil;
}

- (NSError *)seekable
{
    return nil;
}

- (NSError *)seekToTime:(CMTime)time
{
    return [self seekToTime:time toleranceBefor:kCMTimeInvalid toleranceAfter:kCMTimeInvalid];
}

- (NSError *)seekToTime:(CMTime)time toleranceBefor:(CMTime)toleranceBefor toleranceAfter:(CMTime)toleranceAfter
{
    if (!CMTIME_IS_NUMERIC(time)) {
        return SGCreateError(SGErrorCodeInvlidTime, SGActionCodeFormatSeekFrame);
    }
    time = CMTimeMaximum(time, kCMTimeZero);
    time = CMTimeMinimum(time, self->_duration);
    self->_lasttime = time;
    return nil;
}

- (NSError *)nextPacket:(SGPacket **)packet
{
    if (CMTimeCompare(self->_lasttime, self->_duration) >= 0) {
        return SGCreateError(SGErrorCodeDemuxerEndOfFile, SGActionCodeFormatReadFrame);
    }
    CMTime timeStamp = self->_lasttime;
    CMTime duration = CMTimeSubtract(self->_duration, self->_lasttime);
    SGPacket *pkt = [SGPacket packet];
    pkt.flags |= SGDataFlagPadding;
    pkt.core->size = 1;
    pkt.core->pts = av_rescale(AV_TIME_BASE, timeStamp.value, timeStamp.timescale);
    pkt.core->dts = av_rescale(AV_TIME_BASE, timeStamp.value, timeStamp.timescale);
    pkt.core->duration = av_rescale(AV_TIME_BASE, duration.value, duration.timescale);
    SGCodecDescriptor *cd = [[SGCodecDescriptor alloc] init];
    cd.timebase = AV_TIME_BASE_Q;
    [pkt setCodecDescriptor:cd];
    [pkt fill];
    *packet = pkt;
    self->_lasttime = self->_duration;
    return nil;
}

@end
