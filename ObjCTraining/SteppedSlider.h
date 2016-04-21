//
//  SteppedSlider.h
//  ObjCTraining
//
//  Created by WeezLabs on 15/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface SteppedSlider : UIView
@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;
@property (nonatomic, assign) CGFloat deltaValue;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, assign) CGFloat scalePointsNumber;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isMinStrict;
@property (nonatomic, assign) BOOL isMaxStrict;
@property (nonatomic, strong) NSNumberFormatter *currentValueFormatter;
@property (nonatomic, strong) NSNumberFormatter *scaleFormatter;
@end
