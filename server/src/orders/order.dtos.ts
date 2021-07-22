export class OrderDto {
  userUid: string;
  testName: string;

  constructor(userUid: string, testName: string) {
    this.userUid = userUid;
    this.testName = testName;
  }
}

export class NotesDto {
  notes: string;

  constructor(notes: string) {
    this.notes = notes;
  }
}
