- (void) viewDidAppear:(BOOL)animated {

_recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
[_recognizer setDelegate:self];
[SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus authStatus) {
    switch (authStatus) {
        case SFSpeechRecognizerAuthorizationStatusAuthorized:
            //User gave access to speech recognition
            NSLog(@"Authorized");
            break;

        case SFSpeechRecognizerAuthorizationStatusDenied:
            //User denied access to speech recognition
            NSLog(@"SFSpeechRecognizerAuthorizationStatusDenied");
            break;

        case SFSpeechRecognizerAuthorizationStatusRestricted:
            //Speech recognition restricted on this device
            NSLog(@"SFSpeechRecognizerAuthorizationStatusRestricted");
            break;

        case SFSpeechRecognizerAuthorizationStatusNotDetermined:
            //Speech recognition not yet authorized

            break;

        default:
            NSLog(@"Default");
            break;
    }
}];

audioEngine = [[AVAudioEngine alloc] init];
_speechSynthesizer  = [[AVSpeechSynthesizer alloc] init];         
[_speechSynthesizer setDelegate:self];
}


-(void)startRecording
{
[self clearLogs:nil];

NSError * outError;

AVAudioSession *audioSession = [AVAudioSession sharedInstance];
[audioSession setCategory:AVAudioSessionCategoryRecord error:&outError];
[audioSession setMode:AVAudioSessionModeMeasurement error:&outError];
[audioSession setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation  error:&outError];

request2 = [[SFSpeechAudioBufferRecognitionRequest alloc] init];

inputNode = [audioEngine inputNode];

if (request2 == nil) {
    NSLog(@"Unable to created a SFSpeechAudioBufferRecognitionRequest object");
}

if (inputNode == nil) {

    NSLog(@"Unable to created a inputNode object");
}

request2.shouldReportPartialResults = true;

_currentTask = [_recognizer recognitionTaskWithRequest:request2
                delegate:self];

[inputNode installTapOnBus:0 bufferSize:4096 format:[inputNode outputFormatForBus:0] block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when){
    NSLog(@"Block tap!");

    [request2 appendAudioPCMBuffer:buffer];

}];

    [audioEngine prepare];
    [audioEngine startAndReturnError:&outError];
    NSLog(@"Error %@", outError);
}

- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishRecognition:(SFSpeechRecognitionResult *)result {

NSLog(@"speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishRecognition");
NSString * translatedString = [[[result bestTranscription] formattedString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

[self log:translatedString];

if ([result isFinal]) {
    [audioEngine stop];
    [inputNode removeTapOnBus:0];
    _currentTask = nil;
    request2 = nil;
}
}
