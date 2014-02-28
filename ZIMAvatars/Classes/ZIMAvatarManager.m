//
//  ZIMAvatarManager.m
//  ZIMAvatars
//
//  Created by kovtash on 28.02.14.
//  Copyright (c) 2014 kovtash.com. All rights reserved.
//

#import "ZIMAvatarManager.h"

static NSString *const kDefaultBundleName = @"ZIMCats";

static inline NSArray *bundleImagePaths(NSBundle *bundle) {
    NSMutableArray *paths = [NSMutableArray array];
    [paths addObjectsFromArray:[bundle pathsForResourcesOfType:@"jpg" inDirectory:nil]];
    [paths addObjectsFromArray:[bundle pathsForResourcesOfType:@"png" inDirectory:nil]];
    return [paths sortedArrayUsingComparator:(NSComparator)^(NSString *obj1, NSString *obj2){
        return [obj1 compare:obj2];
    }];
}

@interface ZIMAvatarManager()
@property (strong, nonatomic) NSArray *imagePaths;
@property (strong, nonatomic) NSMutableDictionary *imageChache;
@end

@implementation ZIMAvatarManager

- (instancetype) initWithBundle:(NSBundle *) bundle {
    self = [super init];
    if (self) {
        _imagePaths = bundleImagePaths(bundle);
        _imageChache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype) init {
    NSString *defaultBundlePath = [[NSBundle mainBundle] pathForResource:kDefaultBundleName
                                                                  ofType:@"bundle"];
    return [self initWithBundle:[NSBundle bundleWithPath:defaultBundlePath]];
}

+ (instancetype) sharedManager {
    static dispatch_once_t pred;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (UIImage *) avatarForTag:(NSUInteger) tag {
    UIImage *avatar = nil;
    if (_imagePaths.count > 0) {
        NSLog(@"%u %u %u",tag % _imagePaths.count, _imagePaths.count, tag);
        NSString *pathForTag = _imagePaths[tag % _imagePaths.count];
        avatar = _imageChache[pathForTag];
        if (!avatar) {
            avatar = [UIImage imageWithData:[NSData dataWithContentsOfFile:pathForTag]];
            [_imageChache setObject:avatar forKey:pathForTag];
        }
    }
    return avatar;
}

- (UIImage *) avatarForIdentifier:(NSString *) identifier {
    return [self avatarForTag:identifier.hash];
}

- (UIImage *) randomAvatar {
    return [self avatarForTag:arc4random_uniform(4294967295)];
}

@end
