//
//  StepProgressBar.m
//  ObjCTraining
//
//  Created by Sunny on 31/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "StepProgressBar.h"
#import "UIImageView+DrawShape.h"

@interface StepProgressBar ()
@property CGFloat circleLineWidth;
@end

static CGFloat const circleLineWidth = 1.5;

@implementation StepProgressBar
@synthesize numberOfSteps = _numberOfSteps;
@synthesize currentStep = _currentStep;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        //default values
        self.numberOfSteps = 1;
        self.currentStep = 0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //default values
        self.numberOfSteps = 1;
        self.currentStep = 0;
    }
    return self;
}

- (int)numberOfSteps {
    return _numberOfSteps;
}

- (void)setNumberOfSteps:(int)numberOfSteps {
    _numberOfSteps = numberOfSteps;
    if (self.currentStep > _numberOfSteps) {
        self.currentStep = _numberOfSteps;
    }
    [self redrawViews];
}

- (int)currentStep {
    return _currentStep;
}

- (void)setCurrentStep:(int)currentStep {
    if (currentStep <= self.numberOfSteps) {
        _currentStep = currentStep;
        [self redrawViews];
    }
}

- (void)setCurrentStep:(int)currentStep of:(int)numberOfSteps {
    _numberOfSteps = numberOfSteps;
    if (currentStep <= self.numberOfSteps) {
        _currentStep = currentStep;
    } else {
        _currentStep = 0;
    }
    [self redrawViews];
}

#pragma mark - update intrinsicContentSize

- (CGSize)intrinsicContentSize {
    CGFloat height = self.frame.size.height;
    CGFloat distanceBetweenImages = [self calculateDistanceBetweenImages];
    CGFloat width = height * (CGFloat) self.numberOfSteps + distanceBetweenImages * (CGFloat) (self.numberOfSteps - 1);
    return CGSizeMake(width, height);
}

#pragma mark - update view

- (void)redrawViews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }

    CGFloat imageHeight = self.frame.size.height;
    CGFloat imageWidth = imageHeight;
    CGFloat distanceBetweenImages = [self calculateDistanceBetweenImages];
    UIColor *circleColor;

    if (self.currentStep > 1) {
        //add line
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(imageWidth / 2, imageHeight / 2, (imageWidth + distanceBetweenImages) * (self.currentStep - 1), 1)];
        lineView.backgroundColor = [UIColor greenColor];
        [self addSubview:lineView];
    }
    
    for (int i = 0; i < self.numberOfSteps; i++) {
        CGRect frame = CGRectMake((imageWidth + distanceBetweenImages) * i, 0, imageWidth, imageHeight);

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        //imageView.backgroundColor = [UIColor whiteColor];
        if (i <= self.currentStep - 1) {
            circleColor = [UIColor greenColor];
        } else {
            circleColor = [UIColor grayColor];
        }
        [UIImageView drawCircleOnImageView:imageView withColor:circleColor lineWidth:circleLineWidth];
        [self addSubview:imageView];

        if (i >= self.currentStep - 1) {
            //add text
            NSString *text = [NSString stringWithFormat:@"%d", i + 1];
            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            label.text = text;
            [label setFont:[UIFont systemFontOfSize:[self findFontSizeForHeight:imageHeight / 1.5f]]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:circleColor];
            [self addSubview:label];
        } else {
            //add image
            CGRect checkmarkFrame = CGRectMake((imageWidth + distanceBetweenImages) * i + imageWidth / 4, imageHeight / 4, imageWidth / 2, imageHeight / 2);
            UIImageView *checkmarkImageView = [[UIImageView alloc] initWithFrame:checkmarkFrame];
            checkmarkImageView.image = [UIImage imageNamed:@"greenCheckmark"];
            checkmarkImageView.clipsToBounds = YES;
            [self addSubview:checkmarkImageView];
        }
    }
    [self invalidateIntrinsicContentSize];
}

- (CGFloat)calculateDistanceBetweenImages {
    return self.frame.size.height * 1.0f;
}

- (CGFloat)findFontSizeForHeight:(CGFloat)height {
    NSString *string = @"1";
    UIFont *font = [UIFont systemFontOfSize:12.0]; //find the height of a 12.0pt font
    NSDictionary *attributes = @{NSFontAttributeName : font};
    CGSize size = [string sizeWithAttributes:attributes];
    float pointsPerPixel = 12.0f / size.height; //compute the ratio
    float desiredFontSize = height * pointsPerPixel;
    return desiredFontSize;
}

@end
