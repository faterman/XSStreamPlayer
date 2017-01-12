//
//  XSAudioCell.h
//  XSStreamPlayerDemo
//
//  Created by faterman on 17/1/12.
//  Copyright © 2017年 faterman. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const XSAudioCellIdentifier;

@interface XSAudioCell : UITableViewCell
@property (copy, nonatomic) NSString *audioUrl;
@property (weak, nonatomic) IBOutlet UILabel *audioStatuLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@end
