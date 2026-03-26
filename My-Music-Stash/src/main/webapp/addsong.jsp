<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Song - My Music Stash</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap');
        body { font-family: 'Roboto', sans-serif; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <nav class="bg-indigo-600 shadow-lg mb-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center space-x-4 h-16">
                <a href="<%= request.getContextPath() %>/library" class="text-indigo-200 hover:text-white transition duration-150">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                </a>
                <span class="text-white text-xl font-bold tracking-wider">Back to Library</span>
            </div>
        </div>
    </nav>

    <div class="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-white p-8 rounded-xl shadow-xl border border-gray-200">
            <div class="mb-8 border-b pb-4">
                <h2 class="text-2xl font-bold text-gray-800">Add a New Song</h2>
                <p class="text-sm text-gray-500 mt-1">Fill in the details to add this track to your stash.</p>
            </div>

            <form action="<%= request.getContextPath() %>/add-song" method="post" class="space-y-6">
                <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
                    <div class="sm:col-span-2">
                        <label for="name" class="block text-sm font-medium text-gray-700">Song Name</label>
                        <input type="text" id="name" name="name" required 
                               class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition duration-150">
                    </div>

                    <div class="sm:col-span-1">
                        <label for="composer" class="block text-sm font-medium text-gray-700">Composer</label>
                        <input type="text" id="composer" name="composer"
                               class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition duration-150">
                    </div>

                    <div class="sm:col-span-1">
                        <label for="lyricist" class="block text-sm font-medium text-gray-700">Lyricist</label>
                        <input type="text" id="lyricist" name="lyricist"
                               class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition duration-150">
                    </div>

                    <div>
                        <label for="singer" class="block text-sm font-medium text-gray-700">Singer</label>
                        <input type="text" id="singer" name="singer" required
                               class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition duration-150">
                    </div>

                    <div>
                        <label for="year" class="block text-sm font-medium text-gray-700">Release Year</label>
                        <input type="number" id="year" name="year" min="1900" max="2100" 
                               class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition duration-150">
                    </div>
                </div>

                <div class="pt-5 border-t">
                    <div class="flex justify-end gap-3">
                        <a href="<%= request.getContextPath() %>/library" 
                           class="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 transition duration-150">
                            Cancel
                        </a>
                        <button type="submit" 
                                class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 transition duration-150">
                            Save Song
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
