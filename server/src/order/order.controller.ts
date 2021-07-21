import { Body, Controller, Param, Post } from '@nestjs/common';
import { OrderDto } from './order.dtos';
import { OrderService } from './order.service';

@Controller('order')
export class OrderController {
  constructor(private readonly orderService: OrderService) { }

  @Post()
  async order(@Body() order: OrderDto): Promise<Object> {
    return await this.orderService.save(order);
  }
}
