<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="demo.models.Song" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Library - My Music Stash</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap');
        body { font-family: 'Roboto', sans-serif; }
        html, body { height: 100%; overflow: hidden; }

        /* Custom scrollbar design */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #f1f5f9;
        }
        ::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #4f46e5;
        }
    </style>
</head>
<body class="bg-gray-50 flex flex-col h-screen overflow-hidden">
    <nav class="bg-indigo-600 shadow-lg flex-shrink-0">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center gap-2 group">
                    <div class="bg-white p-1.5 rounded-lg shadow-sm group-hover:bg-indigo-50 transition duration-200">
                        <svg class="h-6 w-6 text-indigo-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19V6l12-3v13M9 19c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zm12-3c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zM9 10l12-3" />
                        </svg>
                    </div>
                    <span class="text-white text-xl font-bold tracking-tight">Music<span class="text-indigo-200">Stash</span></span>
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-indigo-100 flex items-center gap-1">Welcome, <span class="text-white font-bold"><%= request.getAttribute("username") %></span></span>
                    <a href="#" onclick="confirmLogout(event, '<%= request.getContextPath() %>/logout')"
                       class="px-4 py-2 rounded-md text-sm font-medium text-indigo-600 bg-white hover:bg-indigo-50 transition duration-150 shadow-sm">
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <main class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8 flex flex-col min-h-0 overflow-hidden">
        <div class="flex flex-col md:flex-row justify-between items-center mb-6 gap-4 flex-shrink-0">
            <h1 class="text-3xl font-bold text-gray-900">Your Saved Songs</h1>
            <div class="flex items-center gap-3 w-full md:w-auto">
                <div class="relative flex-1 md:w-64 group">
                    <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-400 group-focus-within:text-indigo-500 transition-colors">
                        <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                    </span>
                    <input type="text" id="searchInput" onkeyup="filterSongs()" placeholder="Search songs or singers..."
                           class="block w-full pl-10 pr-10 py-2 border border-gray-300 rounded-md leading-5 bg-white placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm transition duration-150 shadow-sm">
                    <button id="clearSearchBtn" onclick="clearSearch()" class="absolute inset-y-0 right-0 pr-3 flex items-center hidden text-gray-400 hover:text-gray-600 transition-colors focus:outline-none">
                        <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
                <button onclick="openAddModal()"
                   class="whitespace-nowrap px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 transition duration-150 flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                    Add Song
                </button>
            </div>
        </div>

        <!-- The scrollable card -->
        <div class="flex-1 bg-white shadow-xl rounded-xl border border-gray-200 overflow-hidden flex flex-col min-h-0">
            <div class="flex-1 overflow-y-auto overflow-x-hidden relative">
            <% 
                List<Song> songs = (List<Song>) request.getAttribute("songs");
                if (songs == null || songs.isEmpty()) { 
            %>
                <div class="text-center py-12">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19V6l12-3v13M9 19c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zm12-3c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zM9 10l12-3" />
                    </svg>
                    <h3 class="mt-2 text-sm font-medium text-gray-900">No songs found</h3>
                    <p class="mt-1 text-sm text-gray-500">Get started by adding a new song to your stash.</p>
                </div>
            <% } else { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-indigo-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-indigo-600 uppercase tracking-wider">#</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-indigo-600 uppercase tracking-wider">Song Name</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-indigo-600 uppercase tracking-wider">Singer</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-indigo-600 uppercase tracking-wider">Composer</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-indigo-600 uppercase tracking-wider">Lyricist</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-indigo-600 uppercase tracking-wider">Year</th>
                                <th class="px-6 py-3 text-left text-xs font-semibold text-indigo-600 uppercase tracking-wider">Action</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-100">
                            <% int rowNum = 1; for(Song song : songs) { %>
                            <tr class="hover:bg-indigo-50 transition duration-100 even:bg-indigo-50/20">
                                <td class="px-6 py-4 text-sm text-gray-500"><%= rowNum++ %></td>
                                <td class="px-6 py-4 text-sm font-medium text-indigo-700"><%= song.getName() %></td>
                                <td class="px-6 py-4 text-sm text-gray-700"><%= song.getSinger() %></td>
                                <td class="px-6 py-4 text-sm text-gray-700"><%= song.getComposer() != null ? song.getComposer() : "-" %></td>
                                <td class="px-6 py-4 text-sm text-gray-700"><%= song.getLyricist() != null ? song.getLyricist() : "-" %></td>
                                <td class="px-6 py-4 text-sm text-gray-700"><%= song.getYear() > 0 ? song.getYear() : "-" %></td>
                                <td class="px-6 py-4 text-sm font-medium space-x-2 flex items-center">
                                    <button onclick="viewSong(<%= song.getId() %>)" class="text-indigo-600 hover:text-indigo-900 transition" title="View">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                        </svg>
                                    </button>
                                    <button onclick="editSong(<%= song.getId() %>)" class="text-amber-600 hover:text-amber-900 transition" title="Edit">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                        </svg>
                                    </button>
                                    <button onclick="confirmDelete(<%= song.getId() %>)" class="text-red-600 hover:text-red-900 transition" title="Delete">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                        </svg>
                                    </button>
                                </td>
                            </tr>
                            <% } %>
                            
                            <!-- No Results Row -->
                            <tr id="noResultsRow" class="hidden">
                                <td colspan="7" class="px-6 py-12 text-center">
                                    <div class="flex flex-col items-center justify-center text-gray-400">
                                        <svg class="h-12 w-12 mb-3 text-indigo-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607zM10.5 7.5v6m3-3h-6" />
                                        </svg>
                                        <p class="text-lg font-medium text-gray-500">No songs found matching your search</p>
                                        <p class="text-sm">Try using different keywords or add a new song!</p>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            <% } %>
            </div>
        </div>
    </main>

    <!-- Song Modal (Add/Edit/View) -->
    <div id="songModal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
        <div class="bg-white rounded-xl shadow-2xl w-full max-w-lg mx-4 p-8 relative">
            <div class="flex justify-between items-center mb-6 border-b pb-4">
                <h2 id="modalTitle" class="text-2xl font-bold text-gray-800">Add a New Song</h2>
                <button onclick="closeModal()" class="text-gray-400 hover:text-gray-600 transition">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <form id="songForm" action="<%= request.getContextPath() %>/add-song" method="post" class="space-y-4">
                <input type="hidden" id="songId" name="id">
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700">Song Name <span class="text-red-500">*</span></label>
                    <input type="text" id="name" name="name" required
                           class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition disabled:bg-gray-100 disabled:text-gray-500">
                </div>
                <!-- ... grid ... -->
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label for="composer" class="block text-sm font-medium text-gray-700">Composer</label>
                        <input type="text" id="composer" name="composer"
                               class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition disabled:bg-gray-100 disabled:text-gray-500">
                    </div>
                    <div>
                        <label for="lyricist" class="block text-sm font-medium text-gray-700">Lyricist</label>
                        <input type="text" id="lyricist" name="lyricist"
                               class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition disabled:bg-gray-100 disabled:text-gray-500">
                    </div>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label for="singer" class="block text-sm font-medium text-gray-700">Singer <span class="text-red-500">*</span></label>
                        <input type="text" id="singer" name="singer" required
                               class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition disabled:bg-gray-100 disabled:text-gray-500">
                    </div>
                    <div>
                        <label for="year" class="block text-sm font-medium text-gray-700">Release Year</label>
                        <input type="number" id="year" name="year" min="1900" max="2100"
                               class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition disabled:bg-gray-100 disabled:text-gray-500">
                    </div>
                </div>
                <div class="flex justify-end gap-3 pt-4 border-t">
                    <button type="button" onclick="closeModal()"
                            class="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 transition shadow-sm">
                        Cancel
                    </button>
                    <button type="submit" id="submitBtn"
                            class="px-4 py-2 border border-transparent rounded-md text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 transition shadow-sm">
                        Save Song
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function confirmLogout(event, logoutUrl) {
            event.preventDefault();
            Swal.fire({
                title: 'Are you sure?',
                text: "You will be logged out of your session.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#4f46e5',
                cancelButtonColor: '#d1d5db',
                confirmButtonText: 'Yes, log me out!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = logoutUrl;
                }
            });
        }

        // Login success alert
        <% if ("true".equals(request.getParameter("loginsuccess"))) { %>
            // Strip the query param so refresh doesn't re-show the alert
            history.replaceState(null, '', window.location.pathname);
            Swal.fire({
                icon: 'success',
                title: 'Welcome Back!',
                text: 'You have successfully logged in.',
                confirmButtonColor: '#4f46e5',
                timer: 2000,
                timerProgressBar: true
            });
        <% } %>

        <% if ("true".equals(request.getParameter("addsuccess"))) { %>
            history.replaceState(null, '', window.location.pathname);
            Swal.fire({
                icon: 'success',
                title: 'Song Added!',
                text: 'Your new song has been saved to the library.',
                confirmButtonColor: '#4f46e5',
                timer: 2000,
                timerProgressBar: true
            });
        <% } %>

        <% if ("true".equals(request.getParameter("deletesuccess"))) { %>
            history.replaceState(null, '', window.location.pathname);
            Swal.fire({
                icon: 'success',
                title: 'Deleted!',
                text: 'The song has been removed.',
                confirmButtonColor: '#4f46e5',
                timer: 2000,
                timerProgressBar: true
            });
        <% } %>

        <% if ("true".equals(request.getParameter("updatesuccess"))) { %>
            history.replaceState(null, '', window.location.pathname);
            Swal.fire({
                icon: 'success',
                title: 'Updated!',
                text: 'Song details have been saved.',
                confirmButtonColor: '#4f46e5',
                timer: 2000,
                timerProgressBar: true
            });
        <% } %>

        <% if ("true".equals(request.getParameter("updateerror")) || "true".equals(request.getParameter("deleteerror"))) { %>
            history.replaceState(null, '', window.location.pathname);
            Swal.fire({
                icon: 'error',
                title: 'Operation Failed',
                text: 'There was an error processing your request.',
                confirmButtonColor: '#4f46e5'
            });
        <% } %>
        
        // Modal backdrop fix for contained layout
        window.onclick = function(event) {
            const modal = document.getElementById('songModal');
            if (event.target == modal) {
                closeModal();
            }
        }

        function closeModal() {
            document.getElementById('songModal').classList.add('hidden');
            document.getElementById('songForm').reset();
            const inputs = document.getElementById('songForm').querySelectorAll('input');
            inputs.forEach(input => input.disabled = false);
            document.getElementById('submitBtn').classList.remove('hidden');
        }

        function openAddModal() {
            document.getElementById('modalTitle').innerText = 'Add a New Song';
            document.getElementById('songForm').action = '<%= request.getContextPath() %>/add-song';
            document.getElementById('submitBtn').innerText = 'Save Song';
            document.getElementById('songId').value = '';
            document.getElementById('songModal').classList.remove('hidden');
        }

        async function fetchSongDetails(id) {
            try {
                const response = await fetch('<%= request.getContextPath() %>/get-song?id=' + id);
                if (!response.ok) throw new Error('Failed to fetch song');
                return await response.json();
            } catch (err) {
                Swal.fire('Error', 'Could not load song details.', 'error');
                return null;
            }
        }

        async function viewSong(id) {
            const song = await fetchSongDetails(id);
            if (!song) return;

            document.getElementById('modalTitle').innerText = 'View Song Details';
            populateForm(song);
            
            const inputs = document.getElementById('songForm').querySelectorAll('input');
            inputs.forEach(input => input.disabled = true);
            document.getElementById('submitBtn').classList.add('hidden');
            
            document.getElementById('songModal').classList.remove('hidden');
        }

        async function editSong(id) {
            const song = await fetchSongDetails(id);
            if (!song) return;

            document.getElementById('modalTitle').innerText = 'Edit Song';
            document.getElementById('songForm').action = '<%= request.getContextPath() %>/update-song';
            document.getElementById('submitBtn').innerText = 'Update Song';
            
            populateForm(song);
            document.getElementById('songModal').classList.remove('hidden');
        }

        function populateForm(song) {
            document.getElementById('songId').value = song.id;
            document.getElementById('name').value = song.name;
            document.getElementById('composer').value = song.composer || '';
            document.getElementById('lyricist').value = song.lyricist || '';
            document.getElementById('singer').value = song.singer;
            document.getElementById('year').value = song.year || '';
        }

        function confirmDelete(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "This will permanently delete this song.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#ef4444',
                cancelButtonColor: '#d1d5db',
                confirmButtonText: 'Yes, Delete'
            }).then((result) => {
                if (result.isConfirmed) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '<%= request.getContextPath() %>/delete-song';
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'id';
                    input.value = id;
                    form.appendChild(input);
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        }
        function filterSongs() {
            const input = document.getElementById('searchInput');
            const clearBtn = document.getElementById('clearSearchBtn');
            const filter = input.value.toLowerCase();
            const table = document.querySelector('table');
            const trs = table.getElementsByTagName('tr');
            const noResultsRow = document.getElementById('noResultsRow');
            let visibleCount = 0;

            // Toggle clear button visibility
            if (filter.length > 0) {
                clearBtn.classList.remove('hidden');
            } else {
                clearBtn.classList.add('hidden');
            }

            for (let i = 1; i < trs.length; i++) {
                // Skip the 'no results' row itself
                if (trs[i].id === 'noResultsRow') continue;

                let matchFound = false;
                const tds = trs[i].getElementsByTagName('td');
                
                // Start from index 1 to skip the serial number, loop until length-1 to skip the actions column
                for (let j = 1; j < tds.length - 1; j++) {
                    const textValue = tds[j].textContent || tds[j].innerText;
                    if (textValue.toLowerCase().indexOf(filter) > -1) {
                        matchFound = true;
                        break;
                    }
                }

                if (matchFound) {
                    trs[i].style.display = "";
                    visibleCount++;
                } else {
                    trs[i].style.display = "none";
                }
            }

            if (visibleCount === 0) {
                noResultsRow.classList.remove('hidden');
            } else {
                noResultsRow.classList.add('hidden');
            }
        }

        function clearSearch() {
            const input = document.getElementById('searchInput');
            input.value = '';
            filterSongs(); // Re-run filter to show all rows and hide clear button
            input.focus(); // Keep focus on the search bar
        }
    </script>
</body>
</html>
