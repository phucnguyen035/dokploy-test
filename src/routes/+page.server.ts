
import { hostname } from 'os';

export function load() {
  return {
		hostname: hostname(),
		pid: process.pid,
		nodeVersion: process.version,
		timestamp: new Date().toISOString(),
 }
}