import logger from '../utils/logger';
import { CustomWorld } from '../world';

const getArgentiniaHour = (): Date => {
  const actualHour = new Date();
  const parseHour = new Date(actualHour.getTime() - 3 * 60 * 60 * 1000);
  return parseHour;
};

export const getActivities = (data: any[]): any[] => {
  // restamos un minuto al horario para abarcar todos los activities que necesitamos
  const activitiesHour = new Date(getArgentiniaHour().getTime() - 60 * 1000);

  return data.filter((item) => {
    const itemDate = new Date(item.creationTime);

    // Convertir item a UTC-3 también
    const itemDateArgentina = new Date(itemDate.getTime() - 3 * 60 * 60 * 1000);

    return itemDateArgentina >= activitiesHour;
  });
};
