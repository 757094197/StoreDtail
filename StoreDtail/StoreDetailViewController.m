//
//  StoreDetailViewController.m
//  StoreDtail
//
//  Created by 薛焱 on 16/1/13.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "ServiceDetailViewController.h"
#import "StoreTitleCell.h"
#import "AddressCell.h"
#import "TitleCell.h"
#import "CommentCell.h"
#import "DescriptionCell.h"
#import "MapViewController.h"

@interface StoreDetailViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *headerPageControl;
@property (weak, nonatomic) IBOutlet UITableView *StoreDetailTableView;

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.headerPageControl.currentPage = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 4;
        default:
            return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            StoreTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreTitleCell" forIndexPath:indexPath];
            cell.StoreTitleLabel.text = @"中国和谐控股(武汉)豪华汽车维修中心";
            return cell;
        }else{
            AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
            if (indexPath.row == 1) {
                cell.picImage.image = [UIImage imageNamed:@"StoreAdress"];
                cell.detailLabel.text = @"洪山区珞南街道虎泉街185号, 离虎泉地铁口150米";
            }else{
                cell.picImage.image = [UIImage imageNamed:@"StoreTele"];
                cell.detailLabel.text = @"027-87399799";
            }
            return cell;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
            cell.titleLabel.text = @"推荐套餐";
            return cell;
        }else{
            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
            cell.commentTitleLabel.text = @"仅售15元! 价值50元光亮洗车套餐";
            cell.commentPriceLabel.text = @"￥15";
            cell.commentViewCountLabel.text = @"浏览29";
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
            cell.titleLabel.text = @"商铺介绍";
            return cell;
        }else{
            DescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionCell" forIndexPath:indexPath];
            cell.descriptionLabel.text = @"中国和谐控股豪华汽车维修中心,汽车保养连锁,汽车快修,汽车换油品质一流,行业领先,为爱车一族提供百万公里无大修的保养理念,服务包含:xx养护,xx快修.";
            return cell;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 7)];
    return aView;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return 50;
                default:
                    return 37;
            }
        case 1:
            switch (indexPath.row) {
                case 0:
                    return 29;
                default:
                    return 71;
            }
        default:
            switch (indexPath.row) {
                case 0:
                    return 29;
                default:
                    self.StoreDetailTableView.estimatedRowHeight = 100;
                    return UITableViewAutomaticDimension;
            }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            MapViewController *mapVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MapViewController"];
            [self.navigationController pushViewController:mapVC animated:YES];
        }
    }
    if (indexPath.section == 1 && indexPath.row > 0) {
        ServiceDetailViewController *serviceDetailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ServiceDetailViewController"];
        [self.navigationController pushViewController:serviceDetailVC animated:YES];
    }
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
