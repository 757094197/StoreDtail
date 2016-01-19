//
//  CommentCell.h
//  StoreDtail
//
//  Created by 薛焱 on 16/1/13.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (weak, nonatomic) IBOutlet UILabel *commentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentViewCountLabel;

@end
