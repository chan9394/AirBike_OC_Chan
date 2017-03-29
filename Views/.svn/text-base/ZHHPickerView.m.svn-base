//
//  ZHHPickerView.m
//  AirBk
//
//  Created by 郑洪浩 on 2016/12/2.
//  Copyright © 2016年 ZHH. All rights reserved.
//

#import "ZHHPickerView.h"

@interface ZHHPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (nonatomic, strong)NSArray *areaArr;         //地区数组
//@property (nonatomic, strong)NSDictionary *provinceDic;     //选中的省
//@property (nonatomic, strong)NSArray *regionAry;            //区
//@property (nonatomic, strong)NSDictionary *cityDic;             //的市
//@property (nonatomic, strong)NSDictionary *regionDic;       //区的数组
@property (nonatomic, copy)NSString *provinceStr;               //选中的省
@property (nonatomic, copy)NSString *cityStr;                   //选中的市
@property (nonatomic, copy)NSString *regionStr;                 //选中的区
@property (nonatomic, strong) NSMutableArray *cityArr;                         //模型中城市名
@property (nonatomic, strong)NSArray *regionArr;                //模型中区的数组
@property (nonatomic, assign) NSInteger selectRow;             //选中的行
@end


@implementation ZHHPickerView
+(instancetype)pickerView{
    
    ZHHPickerView *view = [[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:nil options:nil].firstObject;
    view.cityArr = [NSMutableArray array];
    view.areaArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"]];
    [view.areaArr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [view.cityArr addObject:obj[@"city"]];
    }];
//    int count = view.areaArr.count / 2;
    view.selectRow = view.areaArr.count / 2;
        [view.pickView selectRow:view.areaArr.count / 2 inComponent:0 animated:YES];
        view.regionArr = view.areaArr[view.areaArr.count / 2][@"region"];
    
    view.cityStr = view.areaArr[view.selectRow][@"city"];
    view.regionStr = view.regionArr[0];
    return view;
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
//    if (component == 0) {
//        return self.areaDic.count;
//    }else
    if(component == 0){
        return self.cityArr.count;
    } else {
        return self.regionArr.count;
    }
    
}
// returns width of column and height of row for each component.
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//    return self.view.width/3;
//}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}


- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    if (component == 0) {
//        NSString *proStr = [[[self.areaDic objectForKey:[NSString stringWithFormat:@"%ld",(long)row]] allKeys] firstObject];
//        return proStr;
//    }else
        if(component == 0){
            NSString *cityStrr = self.cityArr[row];
            return cityStrr;
    } else {
        if (self.regionArr.count > row) {
            NSString *regionstr = self.regionArr[row];
            return regionstr;
        }
    }
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component == 0) {
        self.cityStr = self.cityArr[row];
        self.regionArr = self.areaArr[row][@"region"];
        self.regionStr = self.regionArr[0];
        [pickerView reloadComponent:1];
          [pickerView selectRow:0 inComponent:1 animated:YES];
    } else if (component == 1) {
        self.regionStr = self.regionArr[row];
    }
    
}
- (IBAction)clickOkBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pickerView:clickOkBtnWithProvince:andCity:andRegion:)]) {
            [self.delegate pickerView:self clickOkBtnWithProvince:self.provinceStr andCity:self.cityStr andRegion:self.regionStr];
    }
}
- (IBAction)clickCancleBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pickerViewClickcancleBtn:)]) {
        [self.delegate pickerViewClickcancleBtn:self];
    }
}

@end
