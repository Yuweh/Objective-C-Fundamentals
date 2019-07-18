//
//  ATSpeechRecognizer.m
//  e-SMBG
//
//

#import "ATSpeechRecognizer.h"


@interface ATSpeechRecognizer ()

/*This object handles the speech recognition requests. It provides an audio input to the speech recognizer.*/
@property SFSpeechAudioBufferRecognitionRequest *speechAudioRecRequest;

/*The recognition task where it gives you the result of the recognition request. Having this object is handy as you can cancel or stop the task. */
@property SFSpeechRecognitionTask *speechRecogTask;

/*This is your Speech recognizer*/
@property SFSpeechRecognizer *speechRecognizer;

/*This is your audio engine. It is responsible for providing your audio input.*/
@property AVAudioEngine *audioEngine;

@end

@implementation ATSpeechRecognizer

#pragma mark - Constants

//Error Messages
#define kErrorMessageAuthorize  @"You declined the permission to perform speech Permission. Please authorize the operation in your device settings."
#define kErrorMessageRestricted @"Speech recognition isn't available on this OS version. Please upgrade to iOS 10 or later."
#define kErrorMessageNotDetermined  @"Speech recognition isn't authorized yet"
#define kErrorMessageAudioInputNotFound @"This device has no audio input node"
#define kErrorMessageRequestFailed @"Unable to create an SFSpeechAudioBufferRecognitionRequest object"
#define kErrorMessageAudioRecordingFailed   @"Unable to start Audio recording due to failure in Recording Engine"

#pragma mark - Singleton methods

+ (ATSpeechRecognizer *)sharedObject {
    static ATSpeechRecognizer *sharedClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClass = [[self alloc] init];
    });
    return sharedClass;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Recognition methods

-(void) activateSpeechRecognizerWithLocaleIdentifier:(NSString *) localeIdentifier andBlock:(void (^)(BOOL isAuthorized))successBlock{
    //enter Described language here
    if([localeIdentifier length]>0){
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
        _speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
        _speechRecognizer.delegate = self;
        _audioEngine = [[AVAudioEngine alloc] init];
        [self getSpeechRecognizerAuthenticationStatusWithSuccessBlock:^(BOOL isAuthorized) {
            successBlock(isAuthorized);
        }];
    }
    else{
        successBlock(NO);
    }
    
}

/*Microphone usage Must be authorized in the info.plist*/
-(void) toggleRecording{
    if(_audioEngine.isRunning){
        [self stopAudioEngine];
    }
    else{
        [self startAudioEngine];
    }
}


#pragma mark - Internal Methods

/*
 In case different buttons are used for recording and stopping, these methods should be called indiviually. Otherwise use -(void) toggleRecording.
 */

-(void) startAudioEngine{
    if([self isDelegateValidForSelector:NSStringFromSelector(@selector(changeStateIndicator:))]){
        [_delegate changeStateIndicator:ATSpeechRecognizerStateRunning];
    }
    
    [self startRecordingSpeech];
}

-(void) stopAudioEngine{
    if([self isDelegateValidForSelector:NSStringFromSelector(@selector(changeStateIndicator:))]){
        [_delegate changeStateIndicator:ATSpeechRecognizerStateStopped];
    }
    [_audioEngine stop];
    [_speechAudioRecRequest endAudio];
    self.speechRecogTask = nil;
    self.speechAudioRecRequest = nil;
}

/*
 All the voice data is transmitted to Apple’s backend for processing. Therefore, it is mandatory to get the user’s authorization. Speech Recognition Must be authorized in the info.plist
 */

-(void) getSpeechRecognizerAuthenticationStatusWithSuccessBlock:(void (^)(BOOL isAuthorized))successBlock{
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                successBlock(YES);
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                [self sendErrorMessageToDelegate:kErrorMessageAuthorize];
                successBlock(NO);
                
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                [self sendErrorMessageToDelegate:kErrorMessageRestricted];
                successBlock(NO);
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                [self sendErrorMessageToDelegate:kErrorMessageNotDetermined];
                successBlock(NO);
                break;
            default:
                break;
        }
    }];
}

-(void) startRecordingSpeech{
    
    /*
     Check if the Task is running. If yes, Cancel it and start anew
     */
    if(_speechRecogTask!=nil){
        [_speechRecogTask cancel];
        _speechRecogTask = nil;
    }
    
    /*
     Prepare for the audio recording. Here we set the category of the session as recording, the mode as measurement, and activate it
     */
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    @try {
        [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
        [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
        [audioSession setActive:YES error:nil];
    } @catch (NSException *exception) {
        [self sendErrorMessageToDelegate:exception.reason];
    }
    
    
    /*
     Instantiate the recognitionRequest. Here we create the SFSpeechAudioBufferRecognitionRequest object. Later, we use it to pass our audio data to Apple’s servers.
     */
    @try {
        _speechAudioRecRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    } @catch (NSException *exception) {
        [self sendErrorMessageToDelegate:kErrorMessageRequestFailed];
    }
    
    
    /*
     Check if the audioEngine (your device) has an audio input for recording.
     */
    if(_audioEngine.inputNode!=nil){
        AVAudioInputNode *inputNode = _audioEngine.inputNode;
        
        /*If true, partial (non-final) results for each utterance will be reported.
         Default is true*/
        _speechAudioRecRequest.shouldReportPartialResults = YES;
        
        /*Start the recognition by calling the recognitionTask method of our speechRecognizer. This function has a completion handler. This completion handler will be called every time the recognition engine has received input, has refined its current recognition, or has been canceled or stopped, and will return a final transcript.*/
        
        _speechRecogTask = [_speechRecognizer recognitionTaskWithRequest:_speechAudioRecRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
            
            BOOL isFinal = NO;
            if(result!=nil){
                if([self isDelegateValidForSelector:NSStringFromSelector(@selector(convertedSpeechToText:))]){
                    [_delegate convertedSpeechToText:[[result bestTranscription] formattedString]];
                }
                isFinal = [result isFinal]; //True if the hypotheses will not change; speech processing is complete.
                
            }
            
            //If Error of Completed, end it.
            if(error!=nil || isFinal){
                [_audioEngine stop];
                [inputNode removeTapOnBus:0];
                self.speechRecogTask = nil;
                self.speechAudioRecRequest = nil;
                if(error!=nil){
                    [self stopAudioEngine];
                    [self sendErrorMessageToDelegate:[NSString stringWithFormat:@"%li - %@",error.code, error.localizedDescription]];
                    
                }
            }
            
        }];
        
        /* Add an audio input to the recognitionRequest. Note that it is ok to add the audio input after starting the recognitionTask. The Speech Framework will start recognizing as soon as an audio input has been added.*/
        
        AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
        [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
            [self.speechAudioRecRequest appendAudioPCMBuffer:buffer];
        }];
        
        /*Prepare and start the audioEngine.*/
        [_audioEngine prepare];
        @try {
            [_audioEngine startAndReturnError:nil];
        } @catch (NSException *exception) {
            [self sendErrorMessageToDelegate:kErrorMessageAudioRecordingFailed];
        }
        
    }
    else{
        [self sendErrorMessageToDelegate:kErrorMessageAudioInputNotFound];
    }
    
    
}

-(BOOL) isDelegateValidForSelector:(NSString*)selectorName{
    if(_delegate!=nil && [_delegate respondsToSelector:NSSelectorFromString(selectorName)]){
        return YES;
    }
    return NO;
}

-(void) sendErrorMessageToDelegate:(NSString*) errorMessage{
    if([self isDelegateValidForSelector:NSStringFromSelector(@selector(sendErrorInfoToViewController:))]){
        [_delegate sendErrorInfoToViewController:errorMessage];
    }
}

#pragma mark - Speech Recognizer Delegate Methods

-(void) speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if(!available){
        [self stopAudioEngine];
    }
    [_delegate speechRecAvailabilityChanged:available];
}
