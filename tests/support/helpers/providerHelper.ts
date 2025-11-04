import logger from '../utils/logger';
import { CustomWorld } from '../world';

export const getHour = (): string => {
  const hour = new Date().toLocaleTimeString('es-AR', {
    timeZone: 'America/Argentina/Buenos_Aires',
    hour12: false
  });

  return hour;
};

export const timeToSeconds = (time: string): number => {
  const [h, m, s] = time.split(':').map(Number);
  return h * 3600 + m * 60 + s;
};
