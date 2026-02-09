<%@ page contentType="text/html;charset=UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>StudentSphere</title>

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- SweetAlert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

            body {
                font-family: 'Inter', sans-serif;
            }

            /* Custom Tailwind Configuration */
            @layer utilities {
                .glass {
                    background: rgba(255, 255, 255, 0.9);
                    backdrop-filter: blur(10px);
                    -webkit-backdrop-filter: blur(10px);
                }

                .glass-dark {
                    background: rgba(0, 0, 0, 0.05);
                    backdrop-filter: blur(10px);
                    -webkit-backdrop-filter: blur(10px);
                }
            }

            /* Custom SweetAlert Styling */
            .swal2-popup {
                border-radius: 1rem !important;
                padding: 2rem !important;
            }

            .swal2-title {
                font-family: 'Inter', sans-serif !important;
                font-weight: 600 !important;
                font-size: 1.5rem !important;
            }

            .swal2-html-container {
                font-family: 'Inter', sans-serif !important;
            }

            .swal2-confirm {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
                border-radius: 0.5rem !important;
                padding: 0.75rem 2rem !important;
                font-weight: 500 !important;
            }

            .swal2-cancel {
                background: #e5e7eb !important;
                color: #374151 !important;
                border-radius: 0.5rem !important;
                padding: 0.75rem 2rem !important;
                font-weight: 500 !important;
            }

            /* Modal backdrop */
            .modal-backdrop {
                position: fixed;
                inset: 0;
                background: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(4px);
                z-index: 40;
                animation: fadeIn 0.2s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }

                to {
                    opacity: 1;
                }
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px) scale(0.95);
                }

                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }

            .modal-content {
                animation: slideIn 0.3s ease-out;
            }

            /* Dark Mode Styles */
            body.dark {
                background: linear-gradient(135deg, #1f2937 0%, #111827 100%);
            }

            body.dark .bg-white {
                background-color: #1f2937 !important;
                color: #f3f4f6;
            }

            body.dark .text-gray-900 {
                color: #f3f4f6 !important;
            }

            body.dark .text-gray-800 {
                color: #e5e7eb !important;
            }

            body.dark .text-gray-700 {
                color: #d1d5db !important;
            }

            body.dark .text-gray-600 {
                color: #9ca3af !important;
            }

            body.dark .text-gray-500 {
                color: #6b7280 !important;
            }

            body.dark .border-gray-200 {
                border-color: #374151 !important;
            }

            body.dark .border-gray-300 {
                border-color: #4b5563 !important;
            }

            body.dark .bg-gray-50 {
                background-color: #111827 !important;
            }

            body.dark .bg-gray-100 {
                background-color: #1f2937 !important;
            }

            body.dark .hover\:bg-gray-50:hover {
                background-color: #374151 !important;
            }

            body.dark .divide-gray-100>*+* {
                border-color: #374151 !important;
            }

            body.dark #themeButton {
                background-color: #374151 !important;
                color: #f3f4f6 !important;
                border-color: #4b5563 !important;
            }

            body.dark #themeMenu {
                background-color: #1f2937 !important;
                border-color: #4b5563 !important;
            }

            body.dark #themeMenu button:hover {
                background-color: #374151 !important;
            }

            /* Dark mode form inputs */
            body.dark input[type="text"],
            body.dark input[type="email"],
            body.dark input[type="tel"],
            body.dark input[type="number"] {
                background-color: #374151 !important;
                color: #f3f4f6 !important;
                border-color: #4b5563 !important;
            }

            body.dark input:focus {
                border-color: #8b5cf6 !important;
                outline: none !important;
                box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.5) !important;
            }

            /* Dark mode modal headers */
            body.dark .modal-content h2,
            body.dark .modal-content button svg {
                color: #e5e7eb !important;
            }

            /* Dark mode labels */
            body.dark label {
                color: #e5e7eb !important;
            }

            /* Dark mode disabled inputs */
            body.dark input:disabled {
                background-color: #1f2937 !important;
                color: #9ca3af !important;
                cursor: not-allowed;
            }

            /* Dark mode table styles */
            body.dark table thead tr {
                background: linear-gradient(135deg, #374151 0%, #1f2937 100%) !important;
            }

            body.dark table thead th {
                color: #e5e7eb !important;
            }

            body.dark table tbody tr:nth-child(odd) {
                background-color: #1f2937 !important;
            }

            body.dark table tbody tr:nth-child(even) {
                background-color: #111827 !important;
            }

            body.dark table tbody tr:hover {
                background-color: #374151 !important;
            }

            /* Dark mode action button hovers */
            body.dark button.hover\:bg-purple-50:hover {
                background-color: rgba(139, 92, 246, 0.2) !important;
            }

            body.dark button.hover\:bg-blue-50:hover {
                background-color: rgba(59, 130, 246, 0.2) !important;
            }

            body.dark button.hover\:bg-red-50:hover {
                background-color: rgba(239, 68, 68, 0.2) !important;
            }

            /* Light mode striped rows */
            table tbody tr:nth-child(even) {
                background-color: #f9fafb;
            }

            table tbody tr:hover {
                background-color: #f3f4f6;
            }
        </style>
    </head>

    <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
        <div class="container mx-auto px-4 py-8 max-w-7xl">

            <!-- HEADER -->
            <div class="flex justify-between items-center mb-8">
                <div class="flex items-center gap-3">
                    <div
                        class="w-12 h-12 bg-gradient-to-br from-purple-500 to-indigo-600 rounded-xl flex items-center justify-center shadow-lg">
                        <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 14l9-5-9-5-9 5 9 5z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
                        </svg>
                    </div>
                    <h1
                        class="text-3xl font-bold bg-gradient-to-r from-purple-600 to-indigo-600 bg-clip-text text-transparent">
                        StudentSphere
                    </h1>
                </div>
                <div class="flex gap-3">
                    <!-- Theme Toggle -->
                    <div class="relative">
                        <button onclick="toggleThemeMenu()" id="themeButton"
                            class="bg-white hover:bg-gray-50 text-gray-700 px-4 py-2 rounded-lg font-medium shadow border border-gray-200 hover:shadow-md transition-all duration-200 flex items-center gap-2">
                            <svg id="themeIcon" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
                            </svg>
                            <span id="themeText">Light</span>
                        </button>
                        <!-- Theme Dropdown -->
                        <div id="themeMenu"
                            class="hidden absolute right-0 mt-2 w-40 bg-white rounded-lg shadow-lg border border-gray-200 py-1 z-50">
                            <button onclick="setTheme('light')"
                                class="w-full px-4 py-2 text-left text-sm hover:bg-gray-50 flex items-center gap-2">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
                                </svg>
                                Light
                            </button>
                            <button onclick="setTheme('dark')"
                                class="w-full px-4 py-2 text-left text-sm hover:bg-gray-50 flex items-center gap-2">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
                                </svg>
                                Dark
                            </button>
                            <button onclick="setTheme('system')"
                                class="w-full px-4 py-2 text-left text-sm hover:bg-gray-50 flex items-center gap-2">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                </svg>
                                System
                            </button>
                        </div>
                    </div>
                    <button onclick="loadStudents()"
                        class="bg-white hover:bg-gray-50 text-gray-700 px-4 py-2 rounded-lg font-medium shadow border border-gray-200 hover:shadow-md transition-all duration-200 flex items-center gap-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                        </svg>
                        Refresh
                    </button>
                    <button onclick="openAddModal()"
                        class="bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-700 hover:to-indigo-700 text-white px-4 py-2 rounded-lg font-medium shadow-lg hover:shadow-xl transition-all duration-200 flex items-center gap-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                        </svg>
                        Register Student
                    </button>
                </div>
            </div>

            <!-- SEARCH -->
            <div class="mb-6">
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                    </div>
                    <input type="text" id="search"
                        class="w-full pl-12 pr-4 py-2 bg-white border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent shadow-sm transition-all"
                        placeholder="Search by name, roll number, or registration number...">
                </div>
            </div>

            <!-- TABLE -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden border-t border-gray-200">
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                            <tr class="bg-gradient-to-r from-gray-50 to-gray-100 border-b border-gray-200">
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    #</th>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    Name</th>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    Roll</th>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    Reg No</th>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    Email</th>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    Phone</th>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    Stream</th>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    Sem</th>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    Actions</th>
                            </tr>
                        </thead>
                        <tbody id="studentTable" class="divide-y divide-gray-100">
                            <!-- Data will be loaded here -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- ADD MODAL -->
        <div id="addModal" class="hidden fixed inset-0 z-50 overflow-y-auto">
            <div class="modal-backdrop" onclick="closeAddModal()"></div>
            <div class="flex items-center justify-center min-h-screen p-4">
                <div class="modal-content relative bg-white rounded-xl shadow-2xl max-w-lg w-full p-6 z-50">
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-lg font-bold text-gray-900">New Student</h2>
                        <button onclick="closeAddModal()" class="text-gray-400 hover:text-gray-600 transition-colors">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>

                    <form id="addForm" class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-900 mb-2">Full Name</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                    </svg>
                                </div>
                                <input type="text" id="name" required
                                    class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                            </div>
                        </div>

                        <div class="grid grid-cols-2 gap-3">
                            <div>
                                <label class="block text-sm font-medium text-gray-900 mb-2">Roll Number</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14" />
                                        </svg>
                                    </div>
                                    <input type="text" id="roll" required
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-900 mb-2">Registration No</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                        </svg>
                                    </div>
                                    <input type="text" id="reg" required
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                </div>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-900 mb-2">Email Address</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                    </svg>
                                </div>
                                <input type="email" id="email" required
                                    class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-900 mb-2">Phone Number</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                    </svg>
                                </div>
                                <input type="tel" id="phone" required
                                    class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                            </div>
                        </div>

                        <div class="grid grid-cols-3 gap-3">
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-gray-900 mb-2">Stream</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                        </svg>
                                    </div>
                                    <input type="text" id="stream" required placeholder="e.g. CSE"
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-900 mb-2">Semester</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                        </svg>
                                    </div>
                                    <input type="number" id="sem" min="1" max="8" required
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                </div>
                            </div>
                        </div>

                        <div class="flex gap-2 pt-3">
                            <button type="button" onclick="closeAddModal()"
                                class="flex-1 px-4 py-2 text-sm bg-red-50 text-red-600 border border-red-200 rounded-lg font-medium hover:bg-red-100 transition-colors">
                                Cancel
                            </button>
                            <button type="button" onclick="addStudent()"
                                class="flex-1 px-4 py-2 text-sm bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-700 hover:to-indigo-700 text-white rounded-lg font-medium shadow-lg hover:shadow-xl transition-all">
                                Save Student
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- EDIT MODAL -->
        <div id="editModal" class="hidden fixed inset-0 z-50 overflow-y-auto">
            <div class="modal-backdrop" onclick="closeEditModal()"></div>
            <div class="flex items-center justify-center min-h-screen p-4">
                <div class="modal-content relative bg-white rounded-xl shadow-2xl max-w-lg w-full p-6 z-50">
                    <div class="flex justify-between items-center mb-5">
                        <h2 class="text-xl font-bold text-gray-800">Edit Student</h2>
                        <button onclick="closeEditModal()" class="text-gray-400 hover:text-gray-600 transition-colors">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>

                    <form id="editForm" class="space-y-3">
                        <input type="hidden" id="eid">

                        <div>
                            <label class="block text-xs font-medium text-gray-600 mb-1.5">Full Name</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                    </svg>
                                </div>
                                <input type="text" id="ename"
                                    class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                            </div>
                        </div>

                        <div class="grid grid-cols-2 gap-3">
                            <div>
                                <label class="block text-xs font-medium text-gray-600 mb-1.5">Roll Number</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14" />
                                        </svg>
                                    </div>
                                    <input type="text" id="eroll"
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                </div>
                            </div>
                            <div>
                                <label class="block text-xs font-medium text-gray-600 mb-1.5">Registration No</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                        </svg>
                                    </div>
                                    <input type="text" id="ereg"
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                </div>
                            </div>
                        </div>

                        <div>
                            <label class="block text-xs font-medium text-gray-600 mb-1.5">Email Address (Locked)</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                    </svg>
                                </div>
                                <input type="email" id="eemail" disabled
                                    class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg bg-gray-50 text-gray-500 cursor-not-allowed">
                            </div>
                        </div>

                        <div>
                            <label class="block text-xs font-medium text-gray-600 mb-1.5">Phone Number</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                    </svg>
                                </div>
                                <input type="tel" id="ephone"
                                    class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                            </div>
                        </div>

                        <div class="grid grid-cols-3 gap-3">
                            <div class="col-span-2">
                                <label class="block text-xs font-medium text-gray-600 mb-1.5">Stream</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                        </svg>
                                    </div>
                                    <input type="text" id="estream"
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                </div>
                            </div>
                            <div>
                                <label class="block text-xs font-medium text-gray-600 mb-1.5">Semester</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                        </svg>
                                    </div>
                                    <input type="number" id="esem" min="1" max="8"
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all">
                                </div>
                            </div>
                        </div>

                        <div class="flex gap-2 pt-3">
                            <button type="button" onclick="closeEditModal()"
                                class="flex-1 px-4 py-2 text-sm bg-red-50 text-red-600 border border-red-200 rounded-lg font-medium hover:bg-red-100 transition-colors">
                                Cancel
                            </button>
                            <button type="button" onclick="updateStudent()"
                                class="flex-1 px-4 py-2 text-sm bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-700 hover:to-indigo-700 text-white rounded-lg font-medium shadow-lg hover:shadow-xl transition-all">
                                Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- VIEW MODAL -->
        <div id="viewModal" class="hidden fixed inset-0 z-50 overflow-y-auto">
            <div class="modal-backdrop" onclick="closeViewModal()"></div>
            <div class="flex items-center justify-center min-h-screen p-4">
                <div class="modal-content relative bg-white rounded-xl shadow-2xl max-w-lg w-full p-6 z-50">
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-lg font-bold text-gray-900">Student Details</h2>
                        <button onclick="closeViewModal()" class="text-gray-400 hover:text-gray-600 transition-colors">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>

                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-900 mb-2">Full Name</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                    </svg>
                                </div>
                                <input type="text" id="vname" readonly
                                    class="w-full pl-10 pr-3 py-2 text-sm border border-gray-200 rounded-lg bg-gray-50 text-gray-700 pointer-events-none">
                            </div>
                        </div>

                        <div class="grid grid-cols-2 gap-3">
                            <div>
                                <label class="block text-sm font-medium text-gray-900 mb-2">Roll Number</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14" />
                                        </svg>
                                    </div>
                                    <input type="text" id="vroll" readonly
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-200 rounded-lg bg-gray-50 text-gray-700 pointer-events-none">
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-900 mb-2">Registration No</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                        </svg>
                                    </div>
                                    <input type="text" id="vreg" readonly
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-200 rounded-lg bg-gray-50 text-gray-700 pointer-events-none">
                                </div>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-900 mb-2">Email Address</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                    </svg>
                                </div>
                                <input type="email" id="vemail" readonly
                                    class="w-full pl-10 pr-3 py-2 text-sm border border-gray-200 rounded-lg bg-gray-50 text-gray-700 pointer-events-none">
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-900 mb-2">Phone Number</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                    </svg>
                                </div>
                                <input type="tel" id="vphone" readonly
                                    class="w-full pl-10 pr-3 py-2 text-sm border border-gray-200 rounded-lg bg-gray-50 text-gray-700 pointer-events-none">
                            </div>
                        </div>

                        <div class="grid grid-cols-3 gap-3">
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-gray-900 mb-2">Stream</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                        </svg>
                                    </div>
                                    <input type="text" id="vstream" readonly
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-200 rounded-lg bg-gray-50 text-gray-700 pointer-events-none">
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-900 mb-2">Semester</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                        </svg>
                                    </div>
                                    <input type="text" id="vsem" readonly
                                        class="w-full pl-10 pr-3 py-2 text-sm border border-gray-200 rounded-lg bg-gray-50 text-gray-700 pointer-events-none">
                                </div>
                            </div>
                        </div>

                        <div class="pt-3">
                            <button type="button" onclick="closeViewModal()"
                                class="w-full px-4 py-2 text-sm bg-red-50 text-red-600 border border-red-200 rounded-lg font-medium hover:bg-red-100 transition-colors">
                                Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            const searchEl = document.getElementById("search");
            const tableBody = document.getElementById("studentTable");
            const addModal = document.getElementById("addModal");
            const editModal = document.getElementById("editModal");
            const viewModal = document.getElementById("viewModal");
            const addForm = document.getElementById("addForm");
            const editForm = document.getElementById("editForm");

            // Theme Management
            let currentTheme = localStorage.getItem('theme') || 'light';

            function initTheme() {
                const savedTheme = localStorage.getItem('theme') || 'light';
                applyTheme(savedTheme);
            }

            function toggleThemeMenu() {
                const menu = document.getElementById('themeMenu');
                menu.classList.toggle('hidden');
            }

            function setTheme(theme) {
                currentTheme = theme;
                localStorage.setItem('theme', theme);
                applyTheme(theme);
                document.getElementById('themeMenu').classList.add('hidden');
            }

            function applyTheme(theme) {
                const body = document.body;
                const themeIcon = document.getElementById('themeIcon');
                const themeText = document.getElementById('themeText');

                // Remove existing theme
                body.classList.remove('dark');

                if (theme === 'dark') {
                    body.classList.add('dark');
                    updateThemeButton('dark', 'Dark');
                } else if (theme === 'system') {
                    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                    if (prefersDark) {
                        body.classList.add('dark');
                    }
                    updateThemeButton('system', 'System');
                } else {
                    updateThemeButton('light', 'Light');
                }
            }

            function updateThemeButton(theme, text) {
                const themeIcon = document.getElementById('themeIcon');
                const themeText = document.getElementById('themeText');

                themeText.textContent = text;

                if (theme === 'dark') {
                    themeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>';
                } else if (theme === 'system') {
                    themeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>';
                } else {
                    themeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"/>';
                }
            }

            // Close theme menu when clicking outside
            document.addEventListener('click', function (event) {
                const themeButton = document.getElementById('themeButton');
                const themeMenu = document.getElementById('themeMenu');
                if (!themeButton.contains(event.target) && !themeMenu.contains(event.target)) {
                    themeMenu.classList.add('hidden');
                }
            });

            // Listen for system theme changes
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
                if (currentTheme === 'system') {
                    applyTheme('system');
                }
            });

            // Initialize theme on page load
            initTheme();
            loadStudents();

            /* SEARCH */
            searchEl.addEventListener("keyup", () => loadStudents(searchEl.value));

            /* MODAL CONTROLS */
            function openAddModal() {
                addModal.classList.remove("hidden");
                document.body.style.overflow = "hidden";
            }

            function closeAddModal() {
                addModal.classList.add("hidden");
                document.body.style.overflow = "auto";
                addForm.reset();
            }

            function closeEditModal() {
                editModal.classList.add("hidden");
                document.body.style.overflow = "auto";
                editForm.reset();
            }

            function openViewModal(s) {
                document.getElementById('vname').value = s.name;
                document.getElementById('vroll').value = s.roll_no;
                document.getElementById('vreg').value = s.registration_no;
                document.getElementById('vemail').value = s.email;
                document.getElementById('vphone').value = s.phone;
                document.getElementById('vstream').value = s.stream;
                document.getElementById('vsem').value = s.semester;
                viewModal.classList.remove("hidden");
                document.body.style.overflow = "hidden";
            }

            function closeViewModal() {
                viewModal.classList.add("hidden");
                document.body.style.overflow = "auto";
            }

            function openEditModal(s) {
                document.getElementById("eid").value = s.id;
                document.getElementById("ename").value = s.name;
                document.getElementById("eroll").value = s.roll_no;
                document.getElementById("ereg").value = s.registration_no;
                document.getElementById("eemail").value = s.email;
                document.getElementById("ephone").value = s.phone;
                document.getElementById("estream").value = s.stream;
                document.getElementById("esem").value = s.semester;
                editModal.classList.remove("hidden");
                document.body.style.overflow = "hidden";
            }

            /* READ */
            function loadStudents(q = "") {
                // Show loading spinner
                tableBody.innerHTML = `
                    <tr>
                        <td colspan="9" class="px-6 py-12 text-center">
                            <div class="flex flex-col items-center gap-3">
                                <svg class="w-12 h-12 text-purple-600 animate-spin" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                </svg>
                                <div class="text-gray-500 font-medium">Loading students...</div>
                            </div>
                        </td>
                    </tr>`;

                fetch("student?q=" + encodeURIComponent(q))
                    .then(r => {
                        if (!r.ok) return r.json().then(err => { throw new Error(err.error || "Server Error") });
                        return r.json();
                    })
                    .then(data => {
                        if (data.error) throw new Error(data.error);
                        tableBody.innerHTML = "";
                        if (!Array.isArray(data)) return;

                        data.forEach((s, i) => {
                            tableBody.innerHTML += `
                    <tr class="transition-colors">
                        <td class="px-6 py-4 text-sm text-gray-900">${i + 1}</td>
                        <td class="px-6 py-4 text-sm font-medium text-gray-900">${s.name}</td>
                        <td class="px-6 py-4 text-sm text-gray-600">${s.roll_no}</td>
                        <td class="px-6 py-4 text-sm text-gray-600">${s.registration_no}</td>
                        <td class="px-6 py-4 text-sm text-gray-600">${s.email}</td>
                        <td class="px-6 py-4 text-sm text-gray-600">${s.phone}</td>
                        <td class="px-6 py-4 text-sm text-gray-600">${s.stream}</td>
                        <td class="px-6 py-4 text-sm text-gray-600">${s.semester}</td>
                        <td class="px-6 py-4 text-sm">
                            <div class="flex gap-2">
                                    <button onclick='openViewModal(${JSON.stringify(s)})' 
                                            class="p-2 text-purple-600 hover:bg-purple-50 rounded-lg transition-colors">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                        </svg>
                                    </button>
                                    <button onclick='openEditModal(${JSON.stringify(s)})' 
                                            class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                        </svg>
                                    </button>
                                <button onclick="deleteStudent(${s.id})" 
                                        class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                    </svg>
                                </button>
                            </div>
                        </td>
                    </tr>`;
                        });
                    })
                    .catch(err => {
                        console.error("Failed to load students:", err);
                        tableBody.innerHTML = `
                            <tr>
                                <td colspan="9" class="px-6 py-12 text-center">
                                    <div class="flex flex-col items-center gap-3">
                                        <svg class="w-16 h-16 text-red-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                        <div class="text-red-500 font-medium">Failed to load students</div>
                                        <div class="text-gray-400 text-sm">${err.message}</div>
                                    </div>
                                </td>
                            </tr>`;
                    });
            }

            /* CREATE */
            function addStudent() {
                if (!addForm.checkValidity()) {
                    addForm.reportValidity();
                    return;
                }

                const data = {
                    name: document.getElementById("name").value,
                    rollNo: document.getElementById("roll").value,
                    registrationNo: document.getElementById("reg").value,
                    email: document.getElementById("email").value,
                    phone: document.getElementById("phone").value,
                    stream: document.getElementById("stream").value,
                    semester: parseInt(document.getElementById("sem").value) || 0
                };

                fetch("student", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(data)
                })
                    .then(r => {
                        if (!r.ok) return r.json().then(err => { throw new Error(err.error || "Server Error") });
                        return r.json();
                    })
                    .then(data => {
                        if (data.error) throw new Error(data.error);
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: 'Student registered successfully',
                            confirmButtonText: 'OK',
                            customClass: {
                                confirmButton: 'swal2-confirm'
                            }
                        });
                        closeAddModal();
                        addForm.reset();
                        loadStudents();
                    })
                    .catch(err => {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: err.message,
                            confirmButtonText: 'OK',
                            customClass: {
                                confirmButton: 'swal2-confirm'
                            }
                        });
                    });
            }

            /* OPEN EDIT */
            function openEdit(s) {
                document.getElementById("eid").value = s.id;
                document.getElementById("ename").value = s.name;
                document.getElementById("eroll").value = s.roll_no;
                document.getElementById("ereg").value = s.registration_no;
                document.getElementById("eemail").value = s.email;
                document.getElementById("ephone").value = s.phone;
                document.getElementById("estream").value = s.stream;
                document.getElementById("esem").value = s.semester;
                openEditModal();
            }

            /* UPDATE */
            function updateStudent() {
                const data = {
                    id: document.getElementById("eid").value,
                    name: document.getElementById("ename").value,
                    rollNo: document.getElementById("eroll").value,
                    registrationNo: document.getElementById("ereg").value,
                    phone: document.getElementById("ephone").value,
                    stream: document.getElementById("estream").value,
                    semester: parseInt(document.getElementById("esem").value) || 0
                };

                fetch("student?action=update", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(data)
                })
                    .then(r => {
                        if (!r.ok) return r.json().then(err => { throw new Error(err.error || "Server Error") });
                        return r.json();
                    })
                    .then(data => {
                        if (data.error) throw new Error(data.error);
                        Swal.fire({
                            icon: 'success',
                            title: 'Updated!',
                            text: 'Student information updated successfully',
                            confirmButtonText: 'OK',
                            customClass: {
                                confirmButton: 'swal2-confirm'
                            }
                        });
                        closeEditModal();
                        loadStudents();
                    })
                    .catch(err => {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: err.message,
                            confirmButtonText: 'OK',
                            customClass: {
                                confirmButton: 'swal2-confirm'
                            }
                        });
                    });
            }

            /* DELETE */
            function deleteStudent(id) {
                Swal.fire({
                    title: 'Delete Student?',
                    text: "This action cannot be undone",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, delete',
                    cancelButtonText: 'Cancel',
                    customClass: {
                        confirmButton: 'swal2-confirm',
                        cancelButton: 'swal2-cancel'
                    },
                    reverseButtons: true
                }).then(r => {
                    if (r.isConfirmed) {
                        fetch("delete-student", {
                            method: "POST",
                            headers: { "Content-Type": "application/x-www-form-urlencoded" },
                            body: "id=" + id
                        })
                            .then(r => {
                                if (!r.ok) return r.json().then(err => { throw new Error(err.error || "Server Error") });
                                return r.json();
                            })
                            .then(data => {
                                if (data.status === 'error' || data.error) throw new Error(data.message || data.error || "Failed to delete");
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Deleted!',
                                    text: 'Student removed successfully',
                                    confirmButtonText: 'OK',
                                    customClass: {
                                        confirmButton: 'swal2-confirm'
                                    }
                                });
                                loadStudents();
                            })
                            .catch(err => {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: err.message,
                                    confirmButtonText: 'OK',
                                    customClass: {
                                        confirmButton: 'swal2-confirm'
                                    }
                                });
                            });
                    }
                });
            }

            // Close modals on ESC key
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape') {
                    closeAddModal();
                    closeEditModal();
                }
            });
        </script>
    </body>

    </html>