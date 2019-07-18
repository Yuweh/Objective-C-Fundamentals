//
//  ATSpeechRecognizer.h
//  e-SMBG
//
//

#import <Foundation/Foundation.h>
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, ATSpeechRecognizerState) {
    ATSpeechRecognizerStateRunning,
    ATSpeechRecognizerStateStopped
};

@protocol ATSpeechDelegate<NSObject>
@required
/*This method relays parsed text from Speech to the delegate responder class*/
-(void)convertedSpeechToText:(NSString *) parsedText;

/*This method relays change in Speech recognition ability to delegate responder class*/
-(void) speechRecAvailabilityChanged:(BOOL) status;

/*This method relays error messages to delegate responder class*/
-(void) sendErrorInfoToViewController:(NSString *) errorMessage;

@optional
/*This method relays info regarding whether speech rec is running or stopped to delegate responder class. State with be either ATSpeechRecognizerStateRunning or ATSpeechRecognizerStateStopped. You may or may not implement this method*/
-(void) changeStateIndicator:(ATSpeechRecognizerState) state;
@end

@interface ATSpeechRecognizer : NSObject <SFSpeechRecognizerDelegate>

+ (ATSpeechRecognizer *)sharedObject;

/*Delegate to communicate with requesting VCs*/
@property (weak, nonatomic) id<ATSpeechDelegate> delegate;

/*Class Methods*/
-(void) toggleRecording;
-(void) activateSpeechRecognizerWithLocaleIdentifier:(NSString *) localeIdentifier andBlock:(void (^)(BOOL isAuthorized))successBlock;
@end
