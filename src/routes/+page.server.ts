
import { hostname } from 'os';

export function load({getClientAddress}) {
  const clientAddress = getClientAddress();
  console.log(`Hello ${clientAddress}`)

  return {
		hostname: hostname(),
		pid: process.pid,
		nodeVersion: process.version,
		timestamp: new Date().toISOString(),
 }
}