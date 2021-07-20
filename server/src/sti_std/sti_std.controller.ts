import { Controller, Get, Param } from '@nestjs/common';
import { StiStdList } from './sti_std.models';
import { StiStdService } from './sti_std.service';

@Controller('sti_std')
export class StiStdController {
  constructor(private readonly stiStdService: StiStdService) { }

  @Get(':genitalia')
  async findAll(@Param() params): Promise<StiStdList> {
    return await this.stiStdService.findAll(params.genitalia);
  }
}
