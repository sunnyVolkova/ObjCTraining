//
//  StepProgressBar.m
//  ObjCTraining
//
//  Created by Sunny on 31/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "StepProgressBar.h"
//static const CGFloat distanceBetweenImages = 8;

@implementation StepProgressBar
@synthesize numberOfSteps = _numberOfSteps;
@synthesize currentStep = _currentStep;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    NSLog(@"initWithCoder");
    self = [super initWithCoder:coder];
    if (self) {
        //default values
        self.numberOfSteps = 1;
        self.currentStep = 0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        //default values
        self.numberOfSteps = 1;
        self.currentStep = 0;
    }
    return self;
}


- (int) numberOfSteps {
    return _numberOfSteps;
}

- (void)setNumberOfSteps:(int)numberOfSteps {
    _numberOfSteps = numberOfSteps;
}

- (int) currentStep {
    return _currentStep;
}

- (void)setCurrentStep:(int)currentStep {
    if(currentStep <= self.numberOfSteps) {
        _currentStep = currentStep;
    }
}

- (void)setCurrentStep:(int)currentStep of:(int)numberOfSteps {
    _numberOfSteps = numberOfSteps;
    if(currentStep <= self.numberOfSteps) {
        _currentStep = currentStep;
    } else {
        _currentStep = 0;
    }
    [self redrawViews];
}

- (void)redrawViews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    CGFloat imageHeight = self.frame.size.height;
    CGFloat imageWidth = imageHeight;
    CGFloat distanceBetweenImages = imageHeight*1.2;
    UIColor *circleColor;
    for (int i=0; i<self.numberOfSteps; i++){
        CGRect frame = CGRectMake((imageWidth + distanceBetweenImages)*i, 0, imageWidth, imageHeight);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.backgroundColor = [UIColor whiteColor];
        if(i <= self.currentStep) {
            circleColor = [UIColor greenColor];
        } else {
            circleColor = [UIColor grayColor];
        }
        [self drawCircleOnImageView:imageView withColor:circleColor];
        [self addSubview:imageView];
        
        
        if(i >= self.currentStep) {
            //add text
            NSString *text = [NSString stringWithFormat:@"%d", i];
            UILabel *label = [[UILabel alloc]initWithFrame:frame];
            label.text = text;
            [label setFont:[UIFont systemFontOfSize:[self findFontSizeForHeight:imageHeight/1.5]]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:circleColor];
            [self addSubview:label];
        } else {
            //add image
            CGRect checkmarkFrame = CGRectMake((imageWidth + distanceBetweenImages)*i + imageWidth/4, imageHeight/4, imageWidth/2, imageHeight/2);
            UIImageView *checkmarkImageView = [[UIImageView alloc] initWithFrame:checkmarkFrame];
            checkmarkImageView.image = [UIImage imageNamed:@"greenCheckmark"];
            checkmarkImageView.clipsToBounds = YES;
            //checkMarkImageView.contentMode = UISc
            [self addSubview:checkmarkImageView];
        }
    }
    [self invalidateIntrinsicContentSize];
}

- (CGFloat)findFontSizeForHeight:(CGFloat)height {
    NSString *string = @"1";
    UIFont *font = [UIFont systemFontOfSize:12.0]; //find the height of a 12.0pt font
    NSDictionary *attributes = @{ NSFontAttributeName: font};
    CGSize size = [string sizeWithAttributes:attributes];
    float pointsPerPixel = 12.0 / size.height; //compute the ratio
    float desiredFontSize = height * pointsPerPixel;
    return desiredFontSize;
}

- (CGSize)intrinsicContentSize
{
    CGFloat height = self.frame.size.height;
    CGFloat distanceBetweenImages = height*1.2;
    CGFloat width = height * (CGFloat)self.numberOfSteps + distanceBetweenImages * (CGFloat)(self.numberOfSteps - 1);
    return CGSizeMake(width, height);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = self.frame.size.height;
    CGFloat distanceBetweenImages = height*1.2;
    CGFloat width = height * (CGFloat)self.numberOfSteps + distanceBetweenImages * (CGFloat)(self.numberOfSteps - 1);
    return CGSizeMake(width, height);
}

- (void)drawCircleOnImageView:(UIImageView*)imageView withColor:(UIColor*)color {
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    CGFloat width = [imageView bounds].size.width;
    CGFloat height = [imageView bounds].size.height;
    CGFloat lineWidth = 2.0f;

    [circleLayer setBounds:CGRectMake(0.0f, 0.0f, width, height)];
    [circleLayer setPosition:CGPointMake(width/2.0f + lineWidth, height/2.0f + lineWidth)];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(0.0f, 0.0f, width - 2*lineWidth, height - 2*lineWidth)];
    [circleLayer setPath:[path CGPath]];
    [circleLayer setStrokeColor:[color CGColor]];
    [circleLayer setLineWidth:lineWidth];
    [circleLayer setFillColor:[[UIColor whiteColor] CGColor]];
    [[imageView layer] addSublayer:circleLayer];
}
@end
