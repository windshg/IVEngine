//
//  FTCoreTextStyle.h
//  FTCoreText
//
//  Created by Francesco Freezone <cescofry@gmail.com> on 20/07/2011.
//  Copyright 2011 Fuerte International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//abstracts from Apple's headers.
/*!
 @enum		FTCoreTextAlignement
 @abstract	These constants specify text alignment.
 
 @constant	FTCoreTextAlignementLeft
 Text is visually left-aligned.
 
 @constant	FTCoreTextAlignementRight
 Text is visually right-aligned.
 
 @constant	FTCoreTextAlignementCenter
 Text is visually center-aligned.
 
 @constant	FTCoreTextAlignementJustified
 Text is fully justified. The last line in a paragraph is
 naturally aligned.
 
 @constant	FTCoreTextAlignementNatural
 Use the natural alignment of the text's script.
 */


typedef void (^FTCoreTextCallbackBlock)(NSDictionary*);

enum
{
	FTCoreTextAlignementLeft = 0,
	FTCoreTextAlignementRight = 1,
	FTCoreTextAlignementCenter = 2,
	FTCoreTextAlignementJustified = 3,
	FTCoreTextAlignementNatural = 4
};
typedef uint8_t FTCoreTextAlignement;

@interface FTCoreTextStyle : NSObject <NSCopying>

@property (nonatomic, copy) NSString			*name;
@property (nonatomic, copy) NSString			*appendedCharacter;
@property (nonatomic, copy) UIFont			*font;
@property (nonatomic, copy) UIColor			*color;
@property (nonatomic, getter=isUnderLined, assign) BOOL underlined;
@property (nonatomic) FTCoreTextAlignement textAlignment;
@property (nonatomic) UIEdgeInsets		paragraphInset;
@property (nonatomic) CGFloat			leading;
@property (nonatomic) CGFloat			maxLineHeight;
@property (nonatomic) CGFloat			minLineHeight;
//for bullet styles only
@property (nonatomic, copy) NSString			*bulletCharacter;
@property (nonatomic, copy) UIFont			*bulletFont;
@property (nonatomic, copy) UIColor			*bulletColor;
//called when the style is parsed for extra actions
@property (nonatomic, copy) FTCoreTextCallbackBlock       block;

//if NO, the paragraph styling of the enclosing style is used. Default is YES.
@property (nonatomic, assign) BOOL applyParagraphStyling;

+ (id)styleWithName:(NSString *)name;

@end
