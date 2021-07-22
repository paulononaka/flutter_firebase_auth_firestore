export class Order {
  userUid: string;
  testName: string;
  createdAt: Date;
  resultDate: Date;
  result: string;
  notes: string;

  constructor(
    userUid: string,
    testName: string,
    createdAt: Date,
    resultDate: Date,
    result: string,
    notes: string,
  ) {
    this.userUid = userUid;
    this.testName = testName;
    this.createdAt = createdAt;
    this.resultDate = resultDate;
    this.result = result;
    this.notes = notes;
  }
}

export class OrderList {
  orderList: Order[];

  constructor(orderList: Order[]) {
    this.orderList = orderList;
  }
}
