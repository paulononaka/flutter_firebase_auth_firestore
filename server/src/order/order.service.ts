import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { OrderDto } from './order.dtos';
import { Order } from './order.models';

@Injectable()
export class OrderService {

  async save(orderDto: OrderDto): Promise<Object> {
    const order = new Order(orderDto.userUid, orderDto.testName, new Date(), new Date(), 'negative');
    await admin.firestore().collection('users').doc(order.userUid).collection('orders').add(JSON.parse(JSON.stringify(order)));
    return {
      "statusCode": 201,
      "message": "Ok",
    };
  }
}
