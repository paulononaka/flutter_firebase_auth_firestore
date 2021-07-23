import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';

@Injectable()
export class PushNotification {
    send(registrationToken: string, title: string, message: string) {
        const notification = {
            token: registrationToken,
            notification: {
                title: title,
                body: message
            },
            data: {
                click_action: "FLUTTER_NOTIFICATION_CLICK",
                title: title,
                body: message
            },
            apns: {
                payload: {
                    aps: {
                        contentAvailable: true,
                    },
                },
                headers: {
                    "apns-push-type": "background",
                    "apns-priority": "5", // Must be `5` when `contentAvailable` is set to true.
                    "apns-topic": "com.paulononaka.flutfire",
                },
            }
        };

        admin.messaging().send(notification)
            .then((response) => {
                console.log('Successfully sent message:', response);
            })
            .catch((error) => {
                console.log('Error sending message:', error);
            });
    }
}
