// logger.ts
import winston, { Logger, LoggerOptions } from 'winston';

type CustomLogLevels = {
  fatal: number;
  error: number;
  warn: number;
  info: number;
  debug: number;
};

const customLevel: { levels: CustomLogLevels; colors: Record<keyof CustomLogLevels, string> } = {
  levels: {
    fatal: 0,
    error: 1,
    warn: 2,
    info: 3,
    debug: 4
  },
  colors: {
    fatal: 'magenta',
    error: 'red',
    warn: 'yellow',
    info: 'blue',
    debug: 'cyan'
  }
};

winston.addColors(customLevel.colors);

const loggerOptions: LoggerOptions = {
  levels: customLevel.levels,
  format: winston.format.combine(winston.format.colorize({ colors: customLevel.colors }), winston.format.simple()),
  transports: [
    new winston.transports.Console({ level: 'debug' }),
    new winston.transports.File({
      level: 'fatal',
      filename: './errors.log'
    })
  ]
};

const logger: Logger = winston.createLogger(loggerOptions);

export default logger;
