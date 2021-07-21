import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { OrderDto } from './order.dtos';
import { Order, OrderList } from './order.models';

@Injectable()
export class OrderService {
  async save(orderDto: OrderDto): Promise<any> {
    const order = new Order(
      orderDto.userUid,
      orderDto.testName,
      new Date(),
      new Date(),
      'negative',
    );
    await admin
      .firestore()
      .collection('users')
      .doc(order.userUid)
      .collection('orders')
      .add(JSON.parse(JSON.stringify(order)));
    return {
      statusCode: 201,
      message: 'Ok',
    };
  }

  async findAll(user: string): Promise<OrderList> {
    const orderList = [];
    const snapshot = await admin
      .firestore()
      .collection('users')
      .doc(user)
      .collection('orders')
      .get();
    snapshot.forEach((doc) => orderList.push(doc.data()));
    return new OrderList(orderList);
  }
}
