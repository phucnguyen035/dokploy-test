import { hostname } from 'os';

export function load() {
  console.log('hostname', hostname());

	return {
		hostname: hostname(),
		pid: process.pid,
		nodeVersion: process.version,
		timestamp: new Date().toISOString()
	};
}
