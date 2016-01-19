//
//  ServiceDetailPriceCell.h
//  StoreDtail
//
//  Created by 薛焱 on 16/1/13.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceDetailPriceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UIButton *appointButton;
@property (weak, nonatomic) IBOutlet UILabel *sellCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@end
