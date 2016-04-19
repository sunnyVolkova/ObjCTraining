//
//  SteppedSlider.h
//  ObjCTraining
//
//  Created by WeezLabs on 15/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface SteppedSlider : UIView
@property (nonatomic, assign) IBInspectable CGFloat minimumValue;
@property (nonatomic, assign) IBInspectable CGFloat maximumValue;
@property (nonatomic, assign) IBInspectable CGFloat deltaValue;
@property (nonatomic, assign) IBInspectable CGFloat value;
@property (nonatomic, assign) IBInspectable CGFloat scalePointsNumber;
@property (nonatomic, copy) IBInspectable NSString *title;
@property (nonatomic, assign) IBInspectable BOOL isMinStrict;
@property (nonatomic, assign) IBInspectable BOOL isMaxStrict;
@property (nonatomic, strong) NSNumberFormatter *currentValueFormatter;
@property (nonatomic, strong) NSNumberFormatter *scaleFormatter;
@end
