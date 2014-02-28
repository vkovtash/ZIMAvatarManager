//
//  ZIMAvatarManager.h
//  ZIMAvatars
//
//  Created by kovtash on 28.02.14.
//  Copyright (c) 2014 kovtash.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZIMAvatarManager : NSObject
- (UIImage *) avatarForTag:(NSUInteger) tag;
- (UIImage *) avatarForIdentifier:(NSString *) identifier;
- (UIImage *) randomAvatar;

- (instancetype) initWithBundle:(NSBundle *) bundle;
+ (instancetype) sharedManager;
@end
