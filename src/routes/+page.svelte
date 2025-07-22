<script lang="ts">
	interface HostnameData {
		hostname: string;
		timestamp: string;
		pid: number;
		nodeVersion: string;
		containerId: string;
	}

	let hostnameData = $state<HostnameData | null>(null);
	let loading = $state(false);

	async function fetchHostname() {
		loading = true;
		try {
			const response = await fetch('/api/hostname');
			hostnameData = await response.json();
		} catch (error) {
			console.error('Failed to fetch hostname:', error);
		} finally {
			loading = false;
		}
	}

	$effect(() => {
		fetchHostname();
	});
</script>

<h1 class="text-3xl font-bold">Welcome to SvelteKit</h1>
<p class="mt-4">
	Visit <a href="https://svelte.dev/docs/kit" class="text-blue-600 hover:underline"
		>svelte.dev/docs/kit</a
	> to read the documentation
</p>
<p class="text-lg font-semibold">Test 7</p>

<div class="mt-8 rounded-lg border-2 border-gray-800 bg-gray-100 p-4">
	<h2 class="mb-4 text-2xl font-bold">Docker Swarm Node Info</h2>

	{#if loading}
		<p class="text-blue-600">Loading hostname...</p>
	{:else if hostnameData}
		<div class="my-4 space-y-2 font-mono">
			<p><span class="font-bold">Hostname:</span> {hostnameData.hostname}</p>
			<p><span class="font-bold">Container ID:</span> {hostnameData.containerId}</p>
			<p><span class="font-bold">Process ID:</span> {hostnameData.pid}</p>
			<p><span class="font-bold">Node Version:</span> {hostnameData.nodeVersion}</p>
			<p><span class="font-bold">Timestamp:</span> {hostnameData.timestamp}</p>
		</div>
	{:else}
		<p class="text-red-600">Failed to load hostname data</p>
	{/if}

	<button
		disabled={loading}
		class="mt-4 rounded bg-blue-600 px-4 py-2 text-white hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-50"
		onclick={fetchHostname}
	>
		{loading ? 'Refreshing...' : 'Refresh Hostname'}
	</button>
</div>
