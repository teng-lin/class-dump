// -*- mode: ObjC -*-

//  This file is part of class-dump, a utility for examining the Objective-C segment of Mach-O files.
//  Copyright (C) 1997-1998, 2000-2001, 2004-2011 Steve Nygard.

#import "CDLCDylinker.h"

@implementation CDLCDylinker

- (id)initWithDataCursor:(CDMachOFileDataCursor *)cursor;
{
    NSUInteger length;

    if ((self = [super initWithDataCursor:cursor])) {
        dylinkerCommand.cmd = [cursor readInt32];
        dylinkerCommand.cmdsize = [cursor readInt32];
        
        dylinkerCommand.name.offset = [cursor readInt32];
        
        length = dylinkerCommand.cmdsize - sizeof(dylinkerCommand);
        //NSLog(@"expected length: %u", length);
        
        name = [[cursor readStringOfLength:length encoding:NSASCIIStringEncoding] retain];
        //NSLog(@"name: %@", name);
    }

    return self;
}

- (void)dealloc;
{
    [name release];

    [super dealloc];
}

- (uint32_t)cmd;
{
    return dylinkerCommand.cmd;
}

- (uint32_t)cmdsize;
{
    return dylinkerCommand.cmdsize;
}

- (NSString *)name;
{
    return name;
}

@end
