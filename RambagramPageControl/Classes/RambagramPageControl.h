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

#import <UIKit/UIKit.h>
#import "RambagramPageControlShape.h"

/**
 PageControl ala Instagram
 */
@interface RambagramPageControl : UIView

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger numberOfPages;

/**
 Hide the page control when numberOfPages is <= 1
 */
@property (nonatomic, assign) IBInspectable BOOL hidesForSinglePage;

/**
 Page dot size
 */
@property (nonatomic, assign) IBInspectable CGSize dotSize;

/**
 Dot color
 */
@property (nonatomic, strong) IBInspectable UIColor *dotColor;

/**
 Selected dot color
 */
@property (nonatomic, strong) IBInspectable UIColor *selectedDotColor;

/**
 Dot border color (nil = no border)
 */
@property (nonatomic, strong) IBInspectable UIColor *dotBorderColor;

/**
 Selected dot border color (nil = no border)
 */
@property (nonatomic, strong) IBInspectable UIColor *selectedDotBorderColor;

/**
 Spacing between dots
 */
@property (nonatomic, assign) IBInspectable CGFloat spacing;

/**
 Override the shape at an index

 @param shape shape to use
 @param index the index to apply the shape
 */
- (void)setShape:(RambagramPageControlShape)shape atIndex:(NSInteger)index;

@end
