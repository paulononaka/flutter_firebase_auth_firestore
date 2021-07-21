import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as admin from 'firebase-admin';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors();
  const initialized = admin.apps.some((app) => app.name === '[DEFAULT]');
  if (!initialized) {
    admin.initializeApp();
  }
  await app.listen(process.env.PORT || 3000);
}
bootstrap();
