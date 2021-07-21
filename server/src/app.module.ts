import { HttpModule, Module, OnModuleInit } from '@nestjs/common';
import { OrderController } from './orders/order.controller';
import { OrderService } from './orders/order.service';
import { StiStdController } from './sti_std/sti_std.controller';
import { StiStdService } from './sti_std/sti_std.service';
@Module({
  imports: [HttpModule],
  controllers: [StiStdController, OrderController],
  providers: [StiStdService, OrderService],
})
export class AppModule implements OnModuleInit {
  onModuleInit(): any {
    console.log(`Server initialized`);
  }
}
