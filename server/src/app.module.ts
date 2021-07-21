import { HttpModule, Module, OnModuleInit } from '@nestjs/common';
import { OrderController } from './order/order.controller';
import { OrderService } from './order/order.service';
import { StiStdController } from './sti_std/sti_std.controller';
import { StiStdService } from './sti_std/sti_std.service';
@Module({
  imports: [HttpModule],
  controllers: [StiStdController, OrderController],
  providers: [StiStdService, OrderService],
})
export class AppModule implements OnModuleInit {
  onModuleInit() {
    console.log(`Server initialized`);
  }
}
