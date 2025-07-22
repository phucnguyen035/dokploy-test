<script lang="ts">
	let { data } = $props();
</script>

<h1 class="text-3xl font-bold">Welcome to SvelteKit</h1>
<p class="text-lg font-semibold">Test 8</p>

<div class="mt-8 rounded-lg border-2 border-gray-800 bg-gray-100 p-4">
	<h2 class="mb-4 text-2xl font-bold">Docker Swarm Node Info</h2>

	<div class="my-4 space-y-2 font-mono">
		<p><span class="font-bold">Hostname:</span> {data.hostname}</p>
		<p><span class="font-bold">Process ID:</span> {data.pid}</p>
		<p><span class="font-bold">Node Version:</span> {data.nodeVersion}</p>
		<p><span class="font-bold">Timestamp:</span> {data.timestamp}</p>
	</div>
</div>
