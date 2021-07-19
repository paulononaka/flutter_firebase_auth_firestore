import { Injectable } from '@nestjs/common';
import { StiStd } from './sti_std';
import * as admin from 'firebase-admin';

@Injectable()
export class StiStdRepository {
  async findAll(genitalia: String): Promise<StiStd[]> {
    const result = [];
    const snapshot = await admin.firestore().collection('sti_std').where('genitalia', 'array-contains', genitalia).get();
    snapshot.forEach((doc) => result.push(doc.data()));
    return result;
  }
}
