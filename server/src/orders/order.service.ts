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
      ''
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

  async updateNote(user: string, order: string, note: string): Promise<any> {
    await admin
      .firestore()
      .collection('users')
      .doc(user)
      .collection('orders')
      .doc(order)
      .update({ 'note': note })
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
      var order = {};
      order = doc.data();
      order['id'] = doc.id;
      return orderList.push(order);
    });
    return new OrderList(orderList);
  }
}
