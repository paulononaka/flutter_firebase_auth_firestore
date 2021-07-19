import * as admin from 'firebase-admin';
export class StiStd {
  name: string;
  genitalia: string;
  information: string;
  duration: number;

  constructor(name: string, genitalia: string, information: string, duration: number) {
    this.name = name;
    this.genitalia = genitalia;
    this.information = information;
    this.duration = duration;
  }
}
