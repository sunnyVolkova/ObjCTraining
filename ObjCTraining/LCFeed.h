//
// Created by George on 13.05.15.
// Copyright (c) 2015 StreamLoan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LCFeedActionType) {
    LCFeedActionTypeDenyContactRequest = 3569,
    LCFeedActionTypeDenySharingLifeItem = 3570,
    LCFeedActionTypeShareLifeItem = 3461,
    LCFeedActionTypeShareLifeItemByAdmin = 3462,
    LCFeedActionTypeInviteNewUser = 3470,
    LCFeedActionTypeChangePermission = 3363,
    LCFeedActionTypeChangeDuration = 3364,
    LCFeedActionTypeEditOwnedLifeItem = 3365,
    LCFeedActionTypeEditSharedLifeItem = 3366,
    LCFeedActionTypeUpdateProfile = 3375,
    LCFeedActionTypeUploadNewVersion = 3376,
    LCFeedActionTypeRemoveSharingPermission = 3377,
    LCFeedActionTypeUploadBundleFile = 3378,
    LCFeedActionTypeAddContact = 3267,
    LCFeedActionTypeAddLifeItem = 3274,
    LCFeedActionTypeInvitationAccepted = 3171,
    LCFeedActionTypeAcceptedLifeItem = 3162,
    LCFeedActionTypeAcceptContactRequest = 3168,
    LCFeedActionTypeNewRegistration = 3172,
    LCFeedActionTypeSelectPlan = 3173,
    LCFeedActionTypeConfirmAlert = 3600,
    LCFeedActionTypeRemindAlert = 3601,
    LCFeedActionTypeDismissAlert = 3602,
    LCFeedActionTypeBilledPlan = 3174,
    LCFeedActionTypeDeleteItem = 3701,
    LCFeedActionTypeDeleteFile = 3702,
    LCFeedActionTypeBundleShareNew = 3703,
    LCFeedActionTypeBundleShareUpdate = 3704,
    LCFeedActionTypeBundleShareDelete = 3705,
    LCFeedActionTypeUnlinkItem = 3706,
    LCFeedActionTypeNewMemberRegistered = 5000
};

@interface LCFeed : NSObject

@property(nonatomic, copy) NSString *feedID;
@property(nonatomic, copy) NSString *userID;
@property(nonatomic, copy) NSString *affectedUserID;
@property(nonatomic, copy) NSString *externalData;
@property(nonatomic, copy) NSString *userMessage;
@property(nonatomic, copy) NSString *descriptionText;
@property(nonatomic, copy) NSString *createdDateString;
@property(nonatomic, copy) NSDate *createdDate;
@property(nonatomic, copy) NSDate *updatedDate;
@property(nonatomic, assign) LCFeedActionType actionType;
@property(nonatomic, assign) NSInteger status;
@property(nonatomic, readonly) NSString *imageName;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end