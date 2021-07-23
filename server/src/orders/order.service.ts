import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { PushNotification } from '../firebase/push_notification';
import { OrderDto } from './order.dtos';
import { Order, OrderList } from './order.models';

@Injectable()
export class OrderService {
  constructor(private readonly push: PushNotification) { }

  async save(orderDto: OrderDto): Promise<any> {
    const order = new Order(
      orderDto.userUid,
      orderDto.testName,
      new Date(),
      new Date(),
      '',
      ''
    );
    await admin
      .firestore()
      .collection('to_be_orders')
      .add(JSON.parse(JSON.stringify(order)));
    return {
      statusCode: 201,
      message: 'Ok',
    };
  }

  async proccessOrders(): Promise<any> {
    const _push = this.push;
    const toBeOrders = [];
    const snapshot = await admin
      .firestore()
      .collection('to_be_orders')
      .get();
    snapshot.forEach((doc) => {
      setTimeout(async function () {
        const order = doc.data();

        order.result = ['negative', 'positive'][Math.floor(Math.random() * 2)];
        order.resultDate = new Date();

        const userDoc = admin
          .firestore()
          .collection('users')
          .doc(order.userUid);

        const user = await userDoc.get();
        _push.send(user.data().deviceToken, 'Result of ' + order.testName, 'Result of ' + order.testName + ' is ' + order.result);
        userDoc
          .collection('orders')
          .add(JSON.parse(JSON.stringify(order)));

        doc.ref.delete();
      }, Math.floor(Math.random() * (20 - 5 + 1)) + 5);
    });

    return {
      statusCode: 201,
      message: 'Ok',
    };
  }

  async delete(user: string, order: string): Promise<any> {
    await admin
      .firestore()
      .collection('users')
      .doc(user)
      .collection('orders')
      .doc(order)
      .delete()
    return {
      statusCode: 201,
      message: 'Ok',
    };
  }

  async updateNote(user: string, order: string, notes: string): Promise<any> {
    await admin
      .firestore()
      .collection('users')
      .doc(user)
      .collection('orders')
      .doc(order)
      .update({ 'notes': notes })
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
    snapshot.forEach((doc) => {
      let order = {};
      order = doc.data();
      order['id'] = doc.id;
      return orderList.push(order);
    });
    return new OrderList(orderList);
  }
}
