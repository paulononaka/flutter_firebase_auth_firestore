import { HttpModule, Module, OnModuleInit } from '@nestjs/common';
import { StiStdController } from './sti_std/sti_std.controller';
import { StiStdRepository } from './sti_std/sti_std.repository';
import { StiStdService } from './sti_std/sti_std.service';
import * as admin from 'firebase-admin';
@Module({
  imports: [HttpModule],
  controllers: [StiStdController],
  providers: [StiStdService, StiStdRepository],
})
export class AppModule implements OnModuleInit {
  onModuleInit() {
    console.log(`Initialization...`);
    admin.initializeApp();
  }
}
