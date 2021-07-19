import { Injectable } from '@nestjs/common';
import { StiStd } from './sti_std';
import * as admin from 'firebase-admin';


@Injectable()
export class StiStdRepository {
  async findAll(): Promise<StiStd[]> {
    let result = [];
    const snapshot = await admin.firestore().collection('sti_std').get()
    snapshot.forEach((doc) => result.push(doc.data()));
    return result;
  }
}
