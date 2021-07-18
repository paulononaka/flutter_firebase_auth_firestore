import { Injectable } from '@nestjs/common';
import { StiStd } from './sti_std';

@Injectable()
export class StiStdService {
  async findAll(): Promise<StiStd[]> {
    return [
      new StiStd('Chlamydia'),
      new StiStd('Gonorrhea'),
      new StiStd('Genital herpes'),
      new StiStd('Syphilis'),
      new StiStd('HPV'),
      new StiStd('Trichomoniasis'),
    ];
  }
}
