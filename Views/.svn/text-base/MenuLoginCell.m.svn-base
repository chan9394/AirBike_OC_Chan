//
//  MenuLoginCell.m
//  AirBk
//
//  Created by Damo on 2017/1/18.
//  Copyright © 2017年 ZHH. All rights reserved.
//

#import "MenuLoginCell.h"
#import "HintModel.h"
#define margin 15
#define maxW GLOBAL_V(375) - margin * 2

@interface MenuLoginCell ()

@property (weak, nonatomic) UIImageView *iconIv;         //图片
@property (weak, nonatomic) UILabel         *detailLb;     //文字描述
@property (weak, nonatomic) UILabel         *titleLable;   //标题
@property (nonatomic, weak) UIView          *lineView;                       //下划线
@end

@implementation MenuLoginCell

- (void)setModel:(HintModel *)model {
    _model = model;
    _titleLable.text = model.title;
    _detailLb.text = model.detail;
    _iconIv.image = model.image;
    
    CGSize titleSize = [_titleLable sizeThatFits:CGSizeMake(CGFLOAT_MAX, 16)];
    _titleLable.width = titleSize.width;
    _lineView.x = CGRectGetMaxX(_titleLable.frame) + 10;
    _lineView.width = GLOBAL_SCREENW - margin - CGRectGetMaxX(_titleLable.frame) - 10;
    
    _iconIv.height = model.image.size.height;
    
    CGSize size =   [model.detail boundingRectWithSize:CGSizeMake(maxW , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_detailLb.font,NSFontAttributeName, nil] context:nil].size;
    
    _detailLb.y = CGRectGetMaxY(_iconIv.frame) + 10;
    _detailLb.height = size.height;
    
    self.modelHeight = CGRectGetMaxY(_detailLb.frame);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 16)];
        titleLable.textColor = GLOBAL_CONTENTCOLOR;
        self.titleLable = titleLable;
        titleLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLable];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(margin + titleLable.width, CGRectGetMaxY(titleLable.frame) - 3, maxW - titleLable.width, 1)];
        self.lineView = lineView;
        
        lineView.backgroundColor = [UIColor colorWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:1];
        [self.contentView addSubview:lineView];
        
        UIImageView *iconIv = [[UIImageView alloc] initWithFrame:CGRectMake( margin,CGRectGetMaxY(titleLable.frame) + 10, maxW, 250)];
        self.iconIv = iconIv;
        [self.contentView addSubview:iconIv];
        
        UILabel *detailLb = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(iconIv.frame) + 10, maxW, 21)];
        detailLb.numberOfLines = 0;
        self.detailLb = detailLb;
        detailLb.font = [UIFont systemFontOfSize:14];
        _detailLb.preferredMaxLayoutWidth = maxW;
        detailLb.textColor = GLOBAL_CONTENTCOLOR;
        detailLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:detailLb];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end

