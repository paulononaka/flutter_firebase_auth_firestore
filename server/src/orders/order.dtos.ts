export class OrderDto {
  userUid: string;
  testName: string;

  constructor(userUid: string, testName: string) {
    this.userUid = userUid;
    this.testName = testName;
  }
}
