import { NestFactory } from '@nestjs/core';
import { ExpressAdapter } from '@nestjs/platform-express';
import { AppModule } from './app.module';
import * as express from 'express';
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

const expressServer = express();

const createFunction = async (expressInstance): Promise<void> => {
  const initialized = admin.apps.some((app) => app.name === '[DEFAULT]');
  if (!initialized) {
    admin.initializeApp({
      credential: admin.credential.applicationDefault(),
    });
  }
  const app = await NestFactory.create(AppModule, new ExpressAdapter(expressInstance));
  await app.init();
};

export const api = functions.region('europe-west2').https.onRequest(async (request, response) => {
  await createFunction(expressServer);
  expressServer(request, response);
});

exports.scheduledFunctionCrontab = functions.region('europe-west2').pubsub
  .schedule('every 2 minutes')
  .timeZone('America/Sao_Paulo')
  .onRun(() => {
    console.log('This will be run every 2 minutes');
  });