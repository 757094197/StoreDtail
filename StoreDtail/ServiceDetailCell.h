//
//  ServiceDetailCell.h
//  StoreDtail
//
//  Created by 薛焱 on 16/1/13.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceCountLabel;

@end
