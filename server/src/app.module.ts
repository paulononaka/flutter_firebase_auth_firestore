import { HttpModule, Module } from '@nestjs/common';
import { StiStdController } from './sti_std/sti_std.controller';
import { StiStdRepository } from './sti_std/sti_std.repository';
import { StiStdService } from './sti_std/sti_std.service';

@Module({
  imports: [HttpModule],
  controllers: [StiStdController],
  providers: [StiStdService, StiStdRepository],
})
export class AppModule { }
