import { Controller, Get } from '@nestjs/common';
import { StiStdService } from './sti_std.service';
import { StiStd } from './sti_std';

@Controller('sti_std')
export class StiStdController {
  constructor(private readonly stiStdService: StiStdService) {}

  @Get()
  async findAll(): Promise<StiStd[]> {
    return this.stiStdService.findAll();
  }
}
