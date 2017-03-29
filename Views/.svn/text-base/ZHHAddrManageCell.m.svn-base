//
//  ZHHAddrManageCell.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/2.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHAddrManageCell.h"

@interface ZHHAddrManageCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *defaultAdrBtn;

@end


@implementation ZHHAddrManageCell

+(instancetype)addrmanageCell{
    ZHHAddrManageCell *cell = [[NSBundle mainBundle] loadNibNamed:@"myNibs" owner:nil options:nil][2];
    return cell;
}
-(void)setAddress:(ZHHPostAddress *)address{
    
    _address = address;
    self.nameLab.text = address.consigneeName;
    self.numLab.text = address.consigneeNum;
    self.detailLab.text = address.addDetail;
    
}
-(void)setIsDefaultAdr:(BOOL)isDefaultAdr{
    _isDefaultAdr = isDefaultAdr;
    if (isDefaultAdr) {
        self.defaultAdrBtn.selected = YES;
    }else{
        self.defaultAdrBtn.selected = NO;
    }
    
}
- (IBAction)clickDefaultBtn:(UIButton *)sender {
    if (!self.defaultAdrBtn.selected) {
        if ([self.delegate respondsToSelector:@selector(changeDefaultAddr:)]) {
            [self.delegate changeDefaultAddr:self];
        }
    }
}
- (IBAction)clickDeleteBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteAddr:)]) {
        [self.delegate deleteAddr:self];
    }
}
- (IBAction)clickEditBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(editAddr:)]) {
        [self.delegate editAddr:self];
    }
}

@end
