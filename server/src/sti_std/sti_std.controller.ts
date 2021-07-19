import { Controller, Get, Param } from '@nestjs/common';
import { StiStdService } from './sti_std.service';
import { StiStd } from './sti_std';

@Controller('sti_std')
export class StiStdController {
  constructor(private readonly stiStdService: StiStdService) { }

  @Get(':genitalia')
  async findAll(@Param() params): Promise<StiStd[]> {
    return await this.stiStdService.findAll(params.genitalia);
  }
}
