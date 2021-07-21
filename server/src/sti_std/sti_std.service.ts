import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { StiStdList } from './sti_std.models';
@Injectable()
export class StiStdService {
  async findAll(genitalia: string): Promise<StiStdList> {
    const stiStdList = [];
    const snapshot = await admin
      .firestore()
      .collection('sti_std')
      .where('genitalia', 'array-contains', genitalia)
      .get();
    snapshot.forEach((doc) => stiStdList.push(doc.data()));
    return new StiStdList(stiStdList);
  }
}
