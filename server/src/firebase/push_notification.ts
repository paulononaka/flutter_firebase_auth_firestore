import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';

@Injectable()
export class PushNotification {
    send(message: string) {
        const registrationToken = 'c6K8WPbmQp61Cls5XLUm7K:APA91bHl-JYxa7sqNIu_ZcPfqY7XdmYKyB7sjDlaIa18nBBF3YlCMd807mbTwjS5ItzIbykMJyCDkAjtSopvgEg_68F5LrbjVVd72_HbZZVO4EtlnZQMnG-72ruvy5Mn7PP5aGHVZm3w';

        const notification = {
            token: registrationToken,
            notification: {
                title: 'notificationObject.data()!.title',
                body: message
            },
            data: {
                click_action: "FLUTTER_NOTIFICATION_CLICK",
                title: 'notificationObject.data()!.title',
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
