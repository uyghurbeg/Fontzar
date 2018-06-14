//
//  BGAppsController.m
//  otkurname
//
//  Created by UyghurbegPro on 16/1/8.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "BGAppsController.h"
#import "BGApps.h"
#import "BGApp.h"
#import "BGAppsCell.h"
#import "AFHTTPSessionManager.h"
//#import "BGPosts.h"
//#import "BGSettings.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"


@interface BGAppsController ()<UITableViewDataSource, UITableViewDelegate>
{
    
    NSString *imgUrl;
    UILabel *loadingLabel;
    UIActivityIndicatorView *indicator;
    UIImageView *aramAl;
    int page;
    int pages;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *appList;
@property (nonatomic, strong) UIView *hudeView;
@property (nonatomic, strong) UILabel *mesageLabel;
@property (nonatomic, strong) UIImageView *mesageImage;

@end

@implementation BGAppsController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIView *)hudeView
{
    if (_hudeView == nil) {
        _hudeView = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_hudeView];
        _hudeView.backgroundColor = [UIColor whiteColor];
        _hudeView.hidden = NO;
    }
    return _hudeView;
}

- (UILabel *)mesageLabel
{
    if (_mesageLabel == nil) {
        
        _mesageLabel = [[UILabel alloc] init];
        CGFloat x = 0;
        CGFloat w = self.view.bounds.size.width;
        CGFloat h = 50;
        CGFloat y = self.view.bounds.size.height * 0.5 - h * 0.5;
        _mesageLabel.frame = CGRectMake(x, y, w, h);
        _mesageLabel.textAlignment = NSTextAlignmentCenter;
        _mesageLabel.textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1];
        _mesageLabel.text = @"مەزمۇننى توردىن ئېلىش مەغلۇب بولدى، تورغا يېڭى باغلانغان بولسىڭىز ئېكراننى چىكىپ قايتا سىناڭ.";
        _mesageLabel.font = [UIFont fontWithName:@"UKIJ Tuz Tom" size:16.0f];
        _mesageLabel.numberOfLines = 0;
        _mesageLabel.hidden = YES;
        
        
    }
    return _mesageLabel;
}

- (UIImageView *)mesageImage
{
    if (_mesageLabel == nil) {
        _mesageImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"update"]];
        CGFloat w = 30;
        CGFloat h = 30;
        CGFloat x = self.view.bounds.size.width * 0.5 - w * 0.5;
        CGFloat y = self.view.bounds.size.height * 0.5 - 2 * h;
        _mesageImage.frame = CGRectMake(x, y, w, h);
        _mesageImage.hidden = YES;
        
    }
    return _mesageImage;
}

- (NSMutableArray *)appList
{
    if (_appList == nil) {
        
        _appList = [NSMutableArray array];
    }
    return _appList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    
    self.tableView.rowHeight = 80;
    [self loadDataFromInternet];
    [self setNavigationBar];//start to set navigation bar

}

/**
 *  Here to set some information about navigation bar
 */
- (void)setNavigationBar
{
    self.navigationItem.title = @"ئۇيغۇربەگ ئەپلىرى";
 

}


//这里开始从网络加载数据
- (void)loadDataFromInternet
{
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"http://apps.uyghurbeg.cn/api/get_recent_posts/"];
    
    self.tableView.hidden = NO; //如果有网络，就把hiddi去掉
    
    [manager GET:url_string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.hudeView.hidden = YES;
        
        if (self.appList.count != 0) {
            [self.appList removeAllObjects];
        }
        
        //get data from here and transferred Json to NSArray here
        NSArray *newsList = responseObject[@"posts"];
        
        
        NSMutableArray *dataPost = [NSMutableArray array];
        
        for (NSDictionary *dict in newsList) {
            
            BGApp *posts = [BGApp appsWithDict:dict];
            
            [dataPost addObject:posts];
            
            //to get info from the costum-field
            
            
        }
        
        page = 1;
        pages = [responseObject[@"pages"] integerValue];
        
        [self.appList addObjectsFromArray:dataPost];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [SVProgressHUD dismiss];

        
        self.tableView.hidden = YES; //如果有网络，就把hiddi去掉
        self.hudeView.hidden = NO;
        
        /**
         *  当请求失败时这里出现的是失败提示
         */
        [self.hudeView addSubview:self.mesageImage];
        [self.hudeView addSubview:self.mesageLabel];
        self.mesageLabel.hidden = NO;
        self.mesageImage.hidden = NO;
        
        
        //点击刷新按钮
        UIButton *hudeButton = [[UIButton alloc] initWithFrame:self.view.bounds];
        [self.hudeView addSubview:hudeButton];
        [hudeButton addTarget:self action:@selector(refreshDataWhileNoInternet) forControlEvents:UIControlEventTouchUpInside];
        
    }];
}

/**
 *  没有网络的时候怎么办，重新加载数据
 */
- (void)refreshDataWhileNoInternet
{
    [SVProgressHUD show];
    
    self.hudeView.hidden = NO;
    self.mesageLabel.hidden = YES;
    self.mesageImage.hidden = YES;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        [self loadDataFromInternet];
    });
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.appList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    BGAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BGAppsCell" owner:nil options:nil] lastObject];
    }
    
    BGApp *app = self.appList[indexPath.row];
    
    cell.nameLabel.text = app.title;
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:app.thumbnail] placeholderImage:nil];
    cell.iconView.layer.cornerRadius = 10;
    cell.iconView.layer.masksToBounds = YES;
    
    NSArray *DetailArray = app.costumField[@"app-info"];
    NSString *DetailString = [DetailArray firstObject];
    
    cell.descLabel.text = DetailString;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BGApp *app = self.appList[indexPath.row];
    
    NSArray *URLArray = app.costumField[@"app-url"];

    
    NSString *URLString = [URLArray firstObject];

    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
