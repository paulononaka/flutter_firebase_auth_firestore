import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { OrderDto } from './order.dtos';
import { OrderList } from './order.models';
import { OrderService } from './order.service';

@Controller('orders')
export class OrderController {
  constructor(private readonly orderService: OrderService) { }

  @Post()
  async order(@Body() order: OrderDto): Promise<any> {
    return await this.orderService.save(order);
  }

  @Get(':user')
  async findAll(@Param('user') user: string): Promise<OrderList> {
    return await this.orderService.findAll(user);
  }
}
