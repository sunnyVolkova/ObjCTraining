//
//  SteppedSlider.m
//  ObjCTraining
//
//  Created by WeezLabs on 15/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "SteppedSlider.h"
#import "UIColor+LCAdditions.h"
#import "UIImage+DrawShape.h"

@interface SteppedSlider ()
@property (nonatomic) UIImageView *thumbImageView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *currentValueLabel;
@property (nonatomic) UIButton *decreaseButton;
@property (nonatomic) UIButton *increaseButton;
@property (nonatomic) UIImageView *trackImageView;

@property UIColor *titleColor;
@property UIColor *currentValueColor;
@property UIColor *buttonsColor;
@end

static NSString * const thumbImageName = @"checkMarkTicked";
static NSString * const trackImageName = @"bar";

static CGFloat const titleFontSize = 12.0;
static CGFloat const currentValueFontSize = 19.0;
//parameters for subviews layout
static CGFloat const buttonRadius = 30.0;
static CGFloat const sliderHeight = 126.0;
static CGFloat const buttonMargin = 8.0;
static CGFloat const thumbMargin = 8.0;
static CGFloat const titleLeadingSpace = 8.0;
static CGFloat const titleTopSpace = 0.0;
static CGFloat const currentValueTopSpace = 38.0;
static CGFloat const currentValueHeight = 26.0;
static CGFloat const currentValueBottomSpace = 12.0;
static CGFloat const trackMargin = 8.0;
static CGFloat const trackHeight = 30.0;
static CGFloat const thumbSize = 30.0;
@implementation SteppedSlider

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
        [self setUpViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaults];
        [self setUpViews];
    }
    return self;
}

#pragma mark - Configuration

- (void)setDefaults
{
    self.titleColor = [UIColor blackColor];
    self.currentValueColor = [UIColor blackColor];
    self.buttonsColor = [UIColor lc_darkSkyBlueColor];
    self.minimumValue = 0.0f;
    self.maximumValue = 6.0f;
    self.value = 3.0f;
}

- (void)setUpViews {
#if !TARGET_INTERFACE_BUILDER
    NSBundle *bundle = [NSBundle mainBundle];
#else
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
#endif
    
    // Init track image
    UIImage *trackImage = [UIImage imageNamed:trackImageName inBundle:bundle compatibleWithTraitCollection:nil];
    self.trackImageView = [[UIImageView alloc] initWithImage:trackImage];
    [self addSubview:self.trackImageView];
    
    // Init thumb image
    UIImage *thumbImage = [UIImage imageNamed:thumbImageName inBundle:bundle compatibleWithTraitCollection:nil];
    self.thumbImageView = [[UIImageView alloc] initWithImage:thumbImage];
    self.thumbImageView.userInteractionEnabled = YES;
    self.thumbImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.thumbImageView];
    
    //Init decreaseButton
    self.decreaseButton = [[UIButton alloc] init];
    [self.decreaseButton setTitle:@"-" forState:UIControlStateNormal];
    [self.decreaseButton setTitleColor:self.buttonsColor forState:UIControlStateNormal];
    [self.decreaseButton setBackgroundImage:[UIImage imageByDrawingCircleOfRadius:buttonRadius color:self.buttonsColor lineWidth:2.0f] forState:UIControlStateNormal];
    [self addSubview:self.decreaseButton];
    
    //Init increaseButton
    self.increaseButton = [[UIButton alloc] init];
    [self.increaseButton setTitle:@"+" forState:UIControlStateNormal];
    [self.increaseButton setTitleColor:self.buttonsColor forState:UIControlStateNormal];
    [self.increaseButton setBackgroundImage:[UIImage imageByDrawingCircleOfRadius:buttonRadius color:self.buttonsColor lineWidth:2.0f] forState:UIControlStateNormal];
    [self addSubview:self.increaseButton];
    
    //Init labels
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont fontWithName:@"OpenSans" size:titleFontSize];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = self.titleColor;
    self.titleLabel.text = self.title;
    [self addSubview:self.titleLabel];
    
    self.currentValueLabel = [[UILabel alloc] init];
    self.currentValueLabel.font = [UIFont fontWithName:@"OpenSans-Semiblod" size:currentValueFontSize];
    self.currentValueLabel.textAlignment = NSTextAlignmentCenter;
    self.currentValueLabel.textColor = self.currentValueColor;
    [self addSubview:self.currentValueLabel];
    
    //Add pan gesture recognizer
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.thumbImageView addGestureRecognizer:panRecognizer];
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
    CGFloat height = sliderHeight;
    CGFloat width = CGRectGetWidth(self.frame);
    return CGSizeMake(width, height);
}

- (void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    //title
    CGSize maxTitleSize = CGSizeMake(width, height);
    CGRect actualTitleSize = [self.titleLabel.text boundingRectWithSize:maxTitleSize options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];    
    self.titleLabel.frame = CGRectMake(titleLeadingSpace, titleTopSpace, actualTitleSize.size.width, actualTitleSize.size.height);
    
    //currentValue
    self.currentValueLabel.frame = CGRectMake(0, currentValueTopSpace, width, currentValueHeight);
    
    //track
    CGFloat trackWidth = width - buttonRadius * 2 - buttonMargin * 2 - trackMargin * 2;
    CGFloat trackX = buttonMargin + buttonRadius + trackMargin;
    CGFloat trackY = currentValueTopSpace + currentValueHeight + currentValueBottomSpace;
    self.trackImageView.frame = CGRectMake(trackX, trackY, trackWidth, trackHeight);
    
    //buttons
    self.decreaseButton.frame = CGRectMake(buttonMargin, trackY, buttonRadius, buttonRadius);
    
    self.increaseButton.frame = CGRectMake(width - buttonMargin - buttonRadius, trackY, buttonRadius, buttonRadius);
    NSLog(@"title %@ %lu", self.increaseButton.currentTitle, (unsigned long)self.increaseButton.state);
    //thumb
    CGFloat thumbY = self.trackImageView.center.y;
    CGFloat thumbOffset = (self.value - self.minimumValue) * trackWidth / (self.maximumValue - self.minimumValue);
    CGFloat thumbX = CGRectGetMinX(self.trackImageView.frame) + thumbOffset;
    self.thumbImageView.center = CGPointMake(thumbX , thumbY);
}

#pragma mark - Gesture recognition

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        //Fix when minimumDistance = 0.0 and slider is move to 1.0-1.0
        [self bringSubviewToFront:self.thumbImageView];
        
        CGPoint translation = [gesture translationInView:self];
        CGFloat trackRange = self.maximumValue - self.minimumValue;
        CGFloat width = CGRectGetWidth(self.frame) - CGRectGetWidth(self.thumbImageView.frame);
        
        // Change left value
        self.value += translation.x / width * trackRange;
        
        [gesture setTranslation:CGPointZero inView:self];
        
        //[self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - Setters

//- (void)setMinimumValue:(CGFloat)minimumValue
//{
//    if (minimumValue >= self.maximumValue) {
//        minimumValue = self.maximumValue - self.minimumDistance;
//    }
//    
//    if (self.value < minimumValue) {
//        self.value = minimumValue;
//    }
//    
//    _minimumValue = minimumValue;
//    
//    [self checkMinimumDistance];
//    
//    [self setNeedsLayout];
//}
//
//- (void)setMaximumValue:(CGFloat)maximumValue
//{
//    if (maximumValue <= self.minimumValue) {
//        maximumValue = self.minimumValue + self.minimumDistance;
//    }
//    
//    if (self.value > maximumValue) {
//        self.value = self.minimumValue;
//    }
//    
//    if (self.value > maximumValue) {
//        self.value = maximumValue;
//    }
//    
//    _maximumValue = maximumValue;
//    
//    [self checkMinimumDistance];
//    
//    [self setNeedsLayout];
//}


- (void)setValue:(CGFloat)value
{
    if (value < self.minimumValue) {
        value = self.minimumValue;
    }
    
    if (value > self.maximumValue) {
        value = self.maximumValue;
    }
    
    _value = value;
    self.currentValueLabel.text = [self.currentValueFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = self.title;
    [self setNeedsLayout];
}

#pragma mark - Getters
- (NSFormatter *)currentValueFormatter {
    if (!_currentValueFormatter) {
        _currentValueFormatter = [[NSNumberFormatter alloc] init];
    }
    return _currentValueFormatter;
}
@end
