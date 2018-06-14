//
//  BGAppsCell.h
//  otkurname
//
//  Created by UyghurbegPro on 16/1/8.
//  Copyright © 2016年 BG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGAppsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
- (IBAction)download:(UIButton *)sender;

@end
