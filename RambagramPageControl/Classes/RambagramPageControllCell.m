// Copyright (c) 2017 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "RambagramPageControllCell.h"

@implementation RambagramPageControllCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.shape = RambagramPageControlShapeDot;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.backgroundColor = self.selected ? self.selectedDotColor.CGColor : self.dotColor.CGColor;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    self.contentView.layer.backgroundColor = (selected) ? self.selectedDotColor.CGColor : self.dotColor.CGColor;
    UIColor *borderColor = (selected) ? self.selectedDotBorderColor : self.dotBorderColor;
    
    if (borderColor) {
        self.contentView.layer.borderColor = borderColor.CGColor;
        self.contentView.layer.borderWidth = 1.0;
    } else {
        self.contentView.layer.borderWidth = 0.0;
    }
    
}

- (void)setShape:(RambagramPageControlShape)shape {
    _shape = shape;
    
    switch (_shape) {
        case RambagramPageControlShapeDot:
            self.contentView.layer.cornerRadius = self.contentView.bounds.size.width / 2.0;
            break;
            
        case RambagramPageControlShapeSquare:
            self.contentView.layer.cornerRadius = 0.0;
            break;
    }
}

@end
