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
@property UIColor *activeColor;
@property UIColor *inactiveColor;
@end

static CGFloat const circleLineWidth = 1.5;
static NSString *const checkmarkImageName = @"greenCheckmark";

@implementation StepProgressBar

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

- (void)setNumberOfSteps:(NSInteger)numberOfSteps {
    _numberOfSteps = numberOfSteps;
    [self setNeedsLayout];
}

- (void)setCurrentStep:(NSInteger)currentStep {
    _currentStep = currentStep;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [self redrawViews];
    [super layoutSubviews];
}

#pragma mark - update intrinsicContentSize

- (CGSize)intrinsicContentSize {
    CGFloat height = self.frame.size.height;
    CGFloat distanceBetweenImages = [self calculateDistanceBetweenImages];
    CGFloat width = height * (CGFloat) self.numberOfSteps + distanceBetweenImages * (CGFloat) (self.numberOfSteps - 1);
    return CGSizeMake(width, height);
}

#pragma mark - set default values

- (void)setDefaultValues {
    _numberOfSteps = 1;
    _currentStep = 0;
    _activeColor = [UIColor colorWithRed:42.0f / 255.0f green:181.0f / 255.0f blue:100.0f / 255.0f alpha:1.0f];
    _inactiveColor = [UIColor colorWithRed:221.0f / 255.0f green:221.0f / 255.0f blue:221.0f / 255.0f alpha:1.0f];
    self.translatesAutoresizingMaskIntoConstraints = NO;
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

    if (self.currentStep > 1 && self.numberOfSteps > 0) {
        //add line
        CGFloat lineWidth = (imageWidth + distanceBetweenImages) * (MIN(self.currentStep, self.numberOfSteps) - 1);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(imageWidth / 2, imageHeight / 2, lineWidth, 1.5f)];
        lineView.backgroundColor = self.activeColor;
        [self addSubview:lineView];
    }

    for (int i = 0; i < self.numberOfSteps; i++) {
        CGRect frame = CGRectMake((imageWidth + distanceBetweenImages) * i, 0, imageWidth, imageHeight);

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        if (i <= self.currentStep - 1) {
            circleColor = self.activeColor;
        } else {
            circleColor = self.inactiveColor;
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
#if !TARGET_INTERFACE_BUILDER
            NSBundle *bundle = [NSBundle mainBundle];
#else
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
#endif
            checkmarkImageView.image = [UIImage imageNamed:checkmarkImageName inBundle:bundle compatibleWithTraitCollection:nil];
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
