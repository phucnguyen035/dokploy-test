import { hostname } from 'os';
import { json } from '@sveltejs/kit';

export async function GET() {
	return json({
		hostname: hostname(),
		timestamp: new Date().toISOString(),
		pid: process.pid,
		nodeVersion: process.version,
		containerId: process.env.HOSTNAME || process.env.CONTAINER_ID || 'unknown'
	});
}