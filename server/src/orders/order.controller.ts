import { Body, Controller, Delete, Get, Param, Post, Put } from '@nestjs/common';
import { PushNotification } from '../firebase/push_notification';
import { NotesDto, OrderDto } from './order.dtos';
import { OrderList } from './order.models';
import { OrderService } from './order.service';

@Controller('orders')
export class OrderController {
  constructor(private readonly service: OrderService, private readonly push: PushNotification) { }

  @Post()
  async order(@Body() order: OrderDto): Promise<any> {
    return await this.service.save(order);
  }

  @Get(':user')
  async findAll(@Param('user') user: string): Promise<OrderList> {
    this.push.send('c6K8WPbmQp61Cls5XLUm7K:APA91bHl-JYxa7sqNIu_ZcPfqY7XdmYKyB7sjDlaIa18nBBF3YlCMd807mbTwjS5ItzIbykMJyCDkAjtSopvgEg_68F5LrbjVVd72_HbZZVO4EtlnZQMnG-72ruvy5Mn7PP5aGHVZm3w', 'Hello World');
    return await this.service.findAll(user);
  }

  @Delete(':user/:order')
  async delete(@Param('user') user: string, @Param('order') order: string): Promise<OrderList> {
    return await this.service.delete(user, order);
  }

  @Put(':user/:order')
  async updateNote(@Param('user') user: string, @Param('order') order: string, @Body() dto: NotesDto): Promise<OrderList> {
    return await this.service.updateNote(user, order, dto.notes);
  }
}
