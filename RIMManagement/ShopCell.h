//
//  ShopCell.h
//  RIMManagement
//
//  Created by Gong Lingxiao on 13-6-6.
//  Copyright (c) 2013年 Gong Lingxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *shopImage;
@property (nonatomic, retain) IBOutlet UILabel *lblShopName;
@property (nonatomic, weak) IBOutlet UIImageView *cellImage;

@end
