#import "SharePlugin.h"

@implementation SharePlugin

- (void)share:(CDVInvokedUrlCommand*)command {
    NSDictionary* options = [command.arguments objectAtIndex:0];
    NSString* text = options[@"text"] ?: @"";
    NSString* subject = options[@"subject"] ?: @"";

    dispatch_async(dispatch_get_main_queue(), ^{
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[text] applicationActivities:nil];
        activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList];

        if (subject.length > 0) {
            [activityVC setValue:subject forKey:@"subject"];
        }

        UIViewController* rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (rootVC.presentedViewController) {
            rootVC = rootVC.presentedViewController;
        }

        [rootVC presentViewController:activityVC animated:YES completion:^{
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"shared"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    });
}

@end
