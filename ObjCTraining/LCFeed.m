//
// Created by George on 13.05.15.
// Copyright (c) 2015 StreamLoan. All rights reserved.
//

#import "LCFeed.h"

@implementation LCFeed

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _feedID= [self fixNilWithObject: dictionary[@"PK01"]];
        _actionType = (LCFeedActionType) [dictionary[@"TF01"] intValue];
        _userID= [self fixNilWithObject: dictionary[@"TF02"]];
        _affectedUserID = [self fixNilWithObject: dictionary[@"TF03"]];
        _externalData = [self fixNilWithObject: dictionary[@"TF04"]];
        _status = [[self fixNilWithObject: dictionary[@"PK01"]] intValue];
        _userMessage = [self fixNilWithObject: dictionary[@"TF06"]];
        NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
        _createdDate = [self dateFromString:dictionary[@"TF07"] format:dateFormat];
        _updatedDate = [self dateFromString:dictionary[@"TF08"] format:dateFormat];
        _descriptionText = [self fixNilWithObject: dictionary[@"text"]];
        _createdDateString = [NSDateFormatter localizedStringFromDate:_createdDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    }
    return self;
}

- (NSString *)imageName {
    switch (_actionType) {
        case LCFeedActionTypeRemindAlert:
            return @"doc-alert";
        case LCFeedActionTypeAcceptContactRequest:
        case LCFeedActionTypeAddContact:
        case LCFeedActionTypeNewMemberRegistered:
            return @"addFriend";
        case LCFeedActionTypeConfirmAlert:
        case LCFeedActionTypeNewRegistration:
        case LCFeedActionTypeAcceptedLifeItem:
            return @"act_check";
        case LCFeedActionTypeAddLifeItem:
            return @"addItem";
        case LCFeedActionTypeDenyContactRequest:
            return @"removeFriend";
        case LCFeedActionTypeDenySharingLifeItem:
            return @"act_error";
        case LCFeedActionTypeShareLifeItem:
        case LCFeedActionTypeInviteNewUser:
        case LCFeedActionTypeShareLifeItemByAdmin:
            return @"act_mail";
        case LCFeedActionTypeEditOwnedLifeItem:
        case LCFeedActionTypeEditSharedLifeItem:
        case LCFeedActionTypeChangeDuration:
        case LCFeedActionTypeChangePermission:
        case LCFeedActionTypeRemoveSharingPermission:
        case LCFeedActionTypeUpdateProfile:
        case LCFeedActionTypeUploadNewVersion:
        case LCFeedActionTypeUploadBundleFile:
            return @"act_edit";
        case LCFeedActionTypeBundleShareNew:
            return @"act_bundle";
        case LCFeedActionTypeBundleShareUpdate:
            return @"act_update";
        case LCFeedActionTypeBundleShareDelete:
        case LCFeedActionTypeDeleteItem:
        case LCFeedActionTypeDeleteFile:
        case LCFeedActionTypeUnlinkItem:
            return @"act_delete";
        default:
            return @"act_check";
    }
}

-(id) fixNilWithObject:(NSObject*)object {
    if(object == [NSNull null]){
        return nil;
    }
    return object;
}

- (NSDate*) dateFromString:(NSString*)dateStr format:(NSString*)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormat setDateFormat:format];
    NSDate *date = [dateFormat dateFromString:dateStr];
    if (!date && dateStr.length > 0) {
        DDLogVerbose(@"Date is nil = %@ %@",dateStr, format);
    }
    return date;
}


@end