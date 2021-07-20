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

export class StiStdList {
  stiStdList: StiStd[];

  constructor(stiStdList: StiStd[]) {
    this.stiStdList = stiStdList;
  }
}