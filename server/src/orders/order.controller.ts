import { Body, Controller, Delete, Get, Param, Post, Put } from '@nestjs/common';
import { NotesDto, OrderDto } from './order.dtos';
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

  @Delete(':user/:order')
  async delete(@Param('user') user: string, @Param('order') order: string): Promise<OrderList> {
    return await this.orderService.delete(user, order);
  }

  @Put(':user/:order')
  async updateNote(@Param('user') user: string, @Param('order') order: string, @Body() dto: NotesDto): Promise<OrderList> {
    return await this.orderService.updateNote(user, order, dto.notes);
  }
}
