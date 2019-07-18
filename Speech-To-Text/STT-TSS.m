
@interface ViewController ()<AVCaptureAudioDataOutputSampleBufferDelegate,SFSpeechRecognitionTaskDelegate>
@property (nonatomic, strong) AVCaptureSession *capture;
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *speechRequest;
@end

@implementation ViewController
- (void)startRecognizer
{
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        if (status == SFSpeechRecognizerAuthorizationStatusAuthorized){
            NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
            SFSpeechRecognizer *sf =[[SFSpeechRecognizer alloc] initWithLocale:local];
            self.speechRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
            [sf recognitionTaskWithRequest:self.speechRequest delegate:self];
            // should call startCapture method in main queue or it may crash
            dispatch_async(dispatch_get_main_queue(), ^{
                [self startCapture];
            });
        }
    }];
}

- (void)endRecognizer
{
    // END capture and END voice Reco
    // or Apple will terminate this task after 30000ms.
    [self endCapture];
    [self.speechRequest endAudio];
}

- (void)startCapture
{
    NSError *error;
    self.capture = [[AVCaptureSession alloc] init];
    AVCaptureDevice *audioDev = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    if (audioDev == nil){
        NSLog(@"Couldn't create audio capture device");
        return ;
    }

    // create mic device
    AVCaptureDeviceInput *audioIn = [AVCaptureDeviceInput deviceInputWithDevice:audioDev error:&error];
    if (error != nil){
        NSLog(@"Couldn't create audio input");
        return ;
    }

    // add mic device in capture object
    if ([self.capture canAddInput:audioIn] == NO){
        NSLog(@"Couldn't add audio input");
        return ;
    }
    [self.capture addInput:audioIn];
    // export audio data
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    [audioOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    if ([self.capture canAddOutput:audioOutput] == NO){
        NSLog(@"Couldn't add audio output");
        return ;
    }
    [self.capture addOutput:audioOutput];
    [audioOutput connectionWithMediaType:AVMediaTypeAudio];
    [self.capture startRunning];
}

-(void)endCapture
{
    if (self.capture != nil && [self.capture isRunning]){
        [self.capture stopRunning];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    [self.speechRequest appendAudioSampleBuffer:sampleBuffer];
}
// some Recognition Delegate
@end
