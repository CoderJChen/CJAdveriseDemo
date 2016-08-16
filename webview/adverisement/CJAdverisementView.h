//
//  CJAdverisementView.h
//  CJAdveriseDemo
//
//  Created by chenjie on 16/8/12.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myBlock)(NSString *);

@interface CJAdverisementView : UIView
/**广告数*/
@property(strong,nonatomic)NSArray * numOfAdverises;
@property(copy,nonatomic)myBlock block;
//类方法
+(instancetype)shareAdverise;
@end
