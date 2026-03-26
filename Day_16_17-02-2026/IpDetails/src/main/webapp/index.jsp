<%@ page contentType="text/html;charset=UTF-8" isELIgnored="true" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>IP Details Viewer</title>
        <!-- Tailwind CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Lucide Icons -->
        <script src="https://unpkg.com/lucide@latest"></script>
        <style>
            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            .animate-spin-fast {
                animation: spin 0.6s linear infinite;
            }

            /* Lucide icon alignment fix */
            .lucide {
                display: inline-block;
                vertical-align: middle;
            }
        </style>
    </head>

    <body class="bg-slate-950 text-slate-100 flex items-center justify-center min-h-screen font-sans">

        <div class="bg-slate-900 p-8 rounded-2xl shadow-2xl w-full max-w-md border border-slate-800 m-4">
            <header class="text-center mb-8">
                <h1
                    class="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-indigo-400 to-cyan-400 flex items-center justify-center gap-3">
                    <i data-lucide="globe" class="w-8 h-8 text-indigo-400"></i>
                    IP Details
                </h1>
                <p class="text-slate-400 mt-2 text-sm">Discover your network's fingerprint</p>
            </header>

            <div class="space-y-6">
                <button id="fetchBtn" onclick="fetchIpDetails()"
                    class="group relative w-full bg-indigo-600 hover:bg-indigo-500 text-white font-semibold py-3 px-6 rounded-xl transition-all duration-200 ease-in-out transform hover:scale-[1.02] active:scale-95 shadow-lg shadow-indigo-500/20 disabled:opacity-70 disabled:cursor-not-allowed flex items-center justify-center gap-3">
                    <span id="btnText" class="flex items-center gap-2">
                        <i data-lucide="refresh-cw" class="w-4 h-4"></i>
                        Fetch IP Details
                    </span>
                    <div id="loader" class="hidden">
                        <svg class="animate-spin-fast h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24">
                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4">
                            </circle>
                            <path class="opacity-75" fill="currentColor"
                                d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                            </path>
                        </svg>
                    </div>
                </button>

                <div id="result" class="space-y-3 opacity-0 transition-opacity duration-300">
                    <!-- Results will appear here -->
                </div>
            </div>
        </div>

        <script>
            // Initialize Lucide icons
            lucide.createIcons();

            async function fetchIpDetails() {
                const btn = document.getElementById("fetchBtn");
                const loader = document.getElementById("loader");
                const btnText = document.getElementById("btnText");
                const resultDiv = document.getElementById("result");

                // Start Loading
                btn.disabled = true;
                loader.classList.remove("hidden");
                resultDiv.classList.add("opacity-50");

                try {
                    const response = await fetch("api/ip-details");
                    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                    const data = await response.json();

                    // Render Data
                    resultDiv.innerHTML = `
                        <div class="p-4 bg-slate-800/50 rounded-lg border border-slate-700/50 space-y-3">
                            ${createRow("map-pin", "IP Address", data.ip, "text-indigo-400")}
                            ${createRow("navigation", "Location", `${data.city}, ${data.country}`)}
                            ${createRow("map", "Region", data.region)}
                            ${createRow("building-2", "Organization", data.org)}
                            ${createRow("hash", "Postal Code", data.postal)}
                            ${createRow("locate-fixed", "Coordinates", data.loc)}
                            ${createRow("clock", "Timezone", data.timezone)}
                        </div>
                    `;
                    // Re-initialize icons for dynamic content
                    lucide.createIcons();

                    resultDiv.classList.replace("opacity-0", "opacity-100");
                    resultDiv.classList.remove("opacity-50");
                } catch (err) {
                    resultDiv.innerHTML = `
                        <div class="p-4 bg-red-900/20 border border-red-500/50 rounded-lg text-red-400 text-sm flex items-start gap-3">
                            <i data-lucide="alert-circle" class="w-5 h-5 flex-shrink-0"></i>
                            <div>
                                <b class="block mb-1">Error:</b>
                                ${err.message}
                            </div>
                        </div>
                    `;
                    lucide.createIcons();
                    resultDiv.classList.replace("opacity-0", "opacity-100");
                } finally {
                    // Stop Loading
                    btn.disabled = false;
                    loader.classList.add("hidden");
                }
            }

            function createRow(icon, label, value, valueClass = "text-slate-200") {
                return `
                    <div class="flex justify-between items-center text-sm border-b border-slate-800/50 pb-2 last:border-0 last:pb-0">
                        <div class="flex items-center gap-2 text-slate-400 font-medium">
                            <i data-lucide="${icon}" class="w-4 h-4"></i>
                            <span>${label}</span>
                        </div>
                        <span class="${valueClass} font-mono">${value || 'N/A'}</span>
                    </div>
                `;
            }
        </script>

    </body>

    </html>