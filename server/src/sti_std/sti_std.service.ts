import { Injectable } from '@nestjs/common';
import { StiStd } from './sti_std';
import { StiStdRepository } from './sti_std.repository';

@Injectable()
export class StiStdService {
  constructor(private readonly stiStdRepository: StiStdRepository) { }

  async findAll(): Promise<StiStd[]> {
    return this.stiStdRepository.findAll();
  }
}
