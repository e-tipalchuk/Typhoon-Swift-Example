//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTReturnValueSetter.h"


@interface MKTCharReturnSetter : MKTReturnValueSetter

- (instancetype)initWithSuccessor:(MKTReturnValueSetter *)successor;

@end
