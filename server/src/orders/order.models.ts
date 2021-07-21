export class Order {
  userUid: string;
  testName: string;
  createdAt: Date;
  resultDate: Date;
  result: string;

  constructor(
    userUid: string,
    testName: string,
    createdAt: Date,
    resultDate: Date,
    result: string,
  ) {
    this.userUid = userUid;
    this.testName = testName;
    this.createdAt = createdAt;
    this.resultDate = resultDate;
    this.result = result;
  }
}

export class OrderList {
  orderList: Order[];

  constructor(orderList: Order[]) {
    this.orderList = orderList;
  }
}
