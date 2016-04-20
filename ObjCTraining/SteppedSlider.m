//
//  SteppedSlider.m
//  ObjCTraining
//
//  Created by WeezLabs on 15/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "SteppedSlider.h"
#import "UIColor+LCAdditions.h"

@interface SteppedSlider ()

@property (nonatomic) UIView *thumbView;
@property (nonatomic) UIView *thumbInteractionView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *currentValueLabel;
@property (nonatomic) UIButton *decreaseButton;
@property (nonatomic) UIButton *increaseButton;
@property (nonatomic) UIView *trackView;
@property (nonatomic) UIView *trackInteractionView;
@property (nonatomic) NSMutableArray *scaleLabels;

@property (nonatomic) UIColor *titleColor;
@property (nonatomic) UIColor *currentValueColor;
@property (nonatomic) UIColor *buttonsColor;

@end

//minimal distance between minimum and maximum value
static CGFloat const minDistance = 10.0;

static CGFloat const titleFontSize = 12.0;
static CGFloat const currentValueFontSize = 25.0;
static CGFloat const labelFontSize = 12.0;

static int const buttonIncreaseTag = 1;
static int const buttonDecreaseTag = 2;

//parameters for subviews layout
static CGFloat const buttonDiameter = 60.0;
static CGFloat const buttonInset = 15.0;
static CGFloat const sliderHeight = 126.0;
static CGFloat const buttonMargin = 0;
static CGFloat const titleLeadingSpace = 15.0;
static CGFloat const titleTopSpace = 0.0;
static CGFloat const currentValueTopSpace = 15.0;
static CGFloat const currentValueHeight = 34.0;
static CGFloat const currentValueBottomSpace = 15.0;
static CGFloat const trackMargin = 2.0;
static CGFloat const trackHeight = 7.0;
static CGFloat const trackInteractionHeight = 37.0;
static CGFloat const thumbDiameter = 25.0;
static CGFloat const thumbInteractionDiameter = 50.0;
static CGFloat const scaleLabelTopSpace = 14.0;
static CGFloat const scaleLabelHorizontalMargin = 10.0;


@implementation SteppedSlider

@synthesize currentValueFormatter = _currentValueFormatter;
@synthesize scaleFormatter = _scaleFormatter;

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
    self.scaleLabels = [NSMutableArray array];
    self.titleColor = [UIColor blackColor];
    self.currentValueColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0  blue:101.0/255.0  alpha:1.0];
    self.buttonsColor = [UIColor lc_darkSkyBlueColor];
    self.minimumValue = 0.0f;
    self.maximumValue = 6.0f;
    self.value = 3.0f;
    self.scalePointsNumber = 2.0;
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setUpViews {
    // Init track view
    self.trackView = [[UIView alloc] init];
    self.trackView.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
    self.trackView.layer.cornerRadius = trackHeight/2;
    [self addSubview:self.trackView];
    
    // Init thumb view
    self.thumbView = [[UIView alloc] init];
    self.thumbView.userInteractionEnabled = YES;
    self.thumbView.backgroundColor = [UIColor lc_darkSkyBlueColor];
    self.thumbView.layer.cornerRadius = thumbDiameter/2;
    [self addSubview:self.thumbView];
    
    //Init decreaseButton
    self.decreaseButton = [[UIButton alloc] init];
    [self.decreaseButton setTitleColor:self.buttonsColor forState:UIControlStateNormal];
    [self.decreaseButton setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    self.decreaseButton.imageEdgeInsets = UIEdgeInsetsMake(buttonInset, buttonInset, buttonInset, buttonInset);
    [self.decreaseButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.decreaseButton.tag = buttonDecreaseTag;
    [self addSubview:self.decreaseButton];
    
    //Init increaseButton
    self.increaseButton = [[UIButton alloc] init];
    [self.increaseButton setTitleColor:self.buttonsColor forState:UIControlStateNormal];
    [self.increaseButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    self.increaseButton.imageEdgeInsets = UIEdgeInsetsMake(buttonInset, buttonInset, buttonInset, buttonInset);
    [self.increaseButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.increaseButton.tag = buttonIncreaseTag;
    [self addSubview:self.increaseButton];
    
    //Init labels
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont fontWithName:@"OpenSans" size:titleFontSize];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = self.titleColor;
    self.titleLabel.text = self.title;
    [self addSubview:self.titleLabel];
    
    self.currentValueLabel = [[UILabel alloc] init];
    self.currentValueLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:currentValueFontSize];
    self.currentValueLabel.textAlignment = NSTextAlignmentCenter;
    self.currentValueLabel.textColor = self.currentValueColor;
    [self addSubview:self.currentValueLabel];
    
    self.trackInteractionView = [[UIView alloc] init];
    [self addSubview:self.trackInteractionView];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.trackInteractionView addGestureRecognizer:singleFingerTap];
    
    self.thumbInteractionView = [[UIView alloc] init];
    [self addSubview:self.thumbInteractionView];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.thumbInteractionView addGestureRecognizer:panRecognizer];
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
    CGFloat trackWidth = width - buttonDiameter * 2 - buttonMargin * 2 - trackMargin * 2;
    CGFloat trackX = buttonMargin + buttonDiameter + trackMargin;
    CGFloat trackY = currentValueTopSpace + currentValueHeight + currentValueBottomSpace;
    self.trackView.frame = CGRectMake(trackX, trackY, trackWidth, trackHeight);
    
    //track interaction
    CGFloat trackInteractionY = currentValueTopSpace + currentValueHeight;
    self.trackInteractionView.frame = CGRectMake(trackX, trackInteractionY, trackWidth, trackInteractionHeight);
    
    //buttons
    CGFloat buttonsY = trackY + trackHeight/2 - buttonDiameter/2;
    self.decreaseButton.frame = CGRectMake(buttonMargin, buttonsY, buttonDiameter, buttonDiameter);
    self.increaseButton.frame = CGRectMake(width - buttonMargin - buttonDiameter, buttonsY, buttonDiameter, buttonDiameter);
    
    //thumb
    CGFloat thumbY = self.trackView.center.y;
    CGFloat thumbOffset = thumbDiameter/2 + (self.value - self.minimumValue) * (trackWidth - thumbDiameter) / (self.maximumValue - self.minimumValue);
    CGFloat thumbX = CGRectGetMinX(self.trackView.frame) + thumbOffset;
    self.thumbView.frame = CGRectMake(thumbX, thumbY, thumbDiameter, thumbDiameter);
    self.thumbView.center = CGPointMake(thumbX , thumbY);
    
    //thumb interaction
    self.thumbInteractionView.frame = CGRectMake(thumbX, thumbY, thumbInteractionDiameter, thumbInteractionDiameter);
    self.thumbInteractionView.center = CGPointMake(thumbX , thumbY);
    
    //scale labels
    int labelsCount = (int)self.scaleLabels.count;
    CGFloat distance = 0;
    if (labelsCount > 1) {
        distance = (trackWidth - scaleLabelHorizontalMargin * 2) / (labelsCount - 1);
    }
    CGFloat labelY = trackY + trackHeight + scaleLabelTopSpace;
    CGSize maxLabelSize = CGSizeMake(distance, 18.0);
    for (int i = 0; i < labelsCount; i++) {
        UILabel *label = self.scaleLabels[i];
        CGFloat labelX = trackX + scaleLabelHorizontalMargin + distance * i;
        CGRect actualLabelSize = [label.text boundingRectWithSize:maxLabelSize options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:label.font} context:nil];
        label.frame = CGRectMake(labelX - actualLabelSize.size.width / 2, labelY, actualLabelSize.size.width, actualLabelSize.size.height);
    }
    
}

#pragma mark - Gesture recognition

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat trackRange = self.maximumValue - self.minimumValue;
        CGFloat width = CGRectGetWidth(self.trackView.frame) - CGRectGetWidth(self.thumbView.frame);
        self.value += round((translation.x / width * trackRange) / self.deltaValue) * self.deltaValue;
        [gesture setTranslation:CGPointZero inView:self];
    }
}

- (void)handleSingleTap:(UIPanGestureRecognizer *)gesture {
        CGPoint location = [gesture locationInView:self.trackView];
        CGFloat trackRange = self.maximumValue - self.minimumValue;
        CGFloat width = CGRectGetWidth(self.trackView.frame) - CGRectGetWidth(self.thumbView.frame);
        self.value = round((location.x / width * trackRange) / self.deltaValue) * self.deltaValue;
}

#pragma mark - Buttons interaction

- (void)buttonTapped:(UIButton *)sender {
    switch(sender.tag) {
        case buttonIncreaseTag:
            self.value = self.value + self.deltaValue;
            break;
        case buttonDecreaseTag:
            self.value = self.value - self.deltaValue;
            break;
        default:
            break;
    }
}

#pragma mark - Setters

- (void)setMinimumValue:(CGFloat)minimumValue
{
    if (minimumValue >= self.maximumValue) {
        _maximumValue = minimumValue + minDistance;
    }
    _minimumValue = minimumValue;
    if (self.value < minimumValue) {
        self.value = minimumValue;
    }
    [self updateScaleLabelsText];
    [self setNeedsLayout];
}

- (void)setMaximumValue:(CGFloat)maximumValue
{
    if (maximumValue <= self.minimumValue) {
        _minimumValue = maximumValue - minDistance;
    }
    _maximumValue = maximumValue;
    
    if (self.value > maximumValue) {
        self.value = maximumValue;
    }
    [self updateScaleLabelsText];
    [self setNeedsLayout];
}


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
}

- (void)setScalePointsNumber:(CGFloat)scalePointsNumber {
    _scalePointsNumber = scalePointsNumber;
    while(self.scaleLabels.count > scalePointsNumber) {
        [self.scaleLabels.lastObject removeFromSuperview];
        [self.scaleLabels removeLastObject];
    }
    while(self.scaleLabels.count < scalePointsNumber) {
        UILabel *label = self.createScaleLabel;
        [self.scaleLabels addObject:label];
        [self addSubview:label];
    }
    [self updateScaleLabelsText];
    [self setNeedsLayout];
}

- (void) setCurrentValueFormatter:(NSNumberFormatter *)currentValueFormatter {
    _currentValueFormatter = currentValueFormatter;
    self.currentValueLabel.text = [self.currentValueFormatter stringFromNumber:[NSNumber numberWithDouble:self.value]];
}

- (void) setScaleFormatter:(NSNumberFormatter *)scaleFormatter {
    _scaleFormatter = scaleFormatter;
    [self updateScaleLabelsText];
    [self setNeedsLayout];
}

- (void) setIsMaxStrict:(BOOL)isMaxStrict {
    _isMaxStrict = isMaxStrict;
    [self updateScaleLabelsText];
}

- (void) setIsMinStrict:(BOOL)isMinStrict {
    _isMinStrict = isMinStrict;
    [self updateScaleLabelsText];
}

#pragma mark - Getters

- (NSFormatter *)currentValueFormatter {
    if (!_currentValueFormatter) {
        _currentValueFormatter = [[NSNumberFormatter alloc] init];
    }
    return _currentValueFormatter;
}

- (NSFormatter *)scaleFormatter {
    if (!_scaleFormatter) {
        _scaleFormatter = [[NSNumberFormatter alloc] init];
    }
    return _scaleFormatter;
}

#pragma mark - Helpers

- (UILabel *)createScaleLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"OpenSans" size:labelFontSize];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    return label;
}

- (void)updateScaleLabelsText {
    int labelsCount = (int)self.scaleLabels.count;
    CGFloat step = 0;
    if (labelsCount > 1) {
        step = (self.maximumValue - self.minimumValue) / (labelsCount - 1);
    }
    for (int i = 0; i < labelsCount; i++) {
        CGFloat value = self.minimumValue + step * i;
        UILabel *label = self.scaleLabels[i];
        label.text = [self.scaleFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    }
    if (self.isMaxStrict) {
        UILabel *label = self.scaleLabels[labelsCount - 1];
        NSMutableString *mutableText = [label.text mutableCopy];
        [mutableText appendString:@"+"];
        label.text = [NSString stringWithString:mutableText];
    }
    if (self.isMinStrict) {
        UILabel *label = self.scaleLabels[0];
        NSMutableString *mutableText = [label.text mutableCopy];
        [mutableText appendString:@"-"];
        label.text = [NSString stringWithString:mutableText];
    }
}
@end
