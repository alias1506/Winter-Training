<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - My Music Stash</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap');
        body { font-family: 'Roboto', sans-serif; }
    </style>
</head>
<body class="bg-gray-100 h-screen flex items-center justify-center bg-gradient-to-br from-indigo-500 to-purple-600">
    <div class="bg-white p-8 rounded-xl shadow-2xl w-full max-w-md">
        <div class="text-center mb-8">
            <h1 class="text-3xl font-bold text-gray-800">My Music Stash</h1>
            <p class="text-gray-500 mt-2">Create a new account</p>
        </div>
        

        <form action="<%= request.getContextPath() %>/register" method="post" class="space-y-6">
            <div>
                <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                <input type="text" id="username" name="username" required 
                       class="mt-1 block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition duration-150">
            </div>
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <div class="relative mt-1">
                    <input type="password" id="password" name="password" required 
                           class="block w-full px-4 py-2 bg-gray-50 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition duration-150 pr-10">
                    <button type="button" onclick="togglePasswordVisibility('password', 'eye-icon')" class="absolute inset-y-0 right-0 pr-3 flex items-center text-sm leading-5 text-gray-500 hover:text-gray-700 focus:outline-none">
                        <svg id="eye-icon" class="h-5 w-5" fill="none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                        </svg>
                    </button>
                </div>
            </div>
            <button type="submit" 
                    class="w-full flex justify-center py-2.5 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                Register
            </button>
        </form>
        
        <div class="mt-6 text-center text-sm text-gray-600">
            <p>Already Registered? <a href="login.jsp" class="font-medium text-indigo-600 hover:text-indigo-500">Login</a></p>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function togglePasswordVisibility(inputId, iconId) {
            const passwordInput = document.getElementById(inputId);
            const eyeIcon = document.getElementById(iconId);
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />';
            } else {
                passwordInput.type = 'password';
                eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />';
            }
        }

        // SweetAlert2 Triggers
        <% if ("exists".equals(request.getParameter("error"))) { %>
            history.replaceState(null, '', window.location.pathname);
            Swal.fire({
                icon: 'error',
                title: 'Registration Failed',
                text: 'Username already exists. Please choose another.',
                confirmButtonColor: '#4f46e5',
                scrollbarPadding: false,
                heightAuto: false,
                showClass: { popup: '', backdrop: '' },
                hideClass: { popup: '', backdrop: '' },
                customClass: {
                    popup: 'rounded-xl shadow-2xl border border-gray-100',
                    confirmButton: 'px-6 py-2 rounded-md shadow-sm font-medium'
                }
            });
        <% } else if ("empty".equals(request.getParameter("error"))) { %>
            history.replaceState(null, '', window.location.pathname);
            Swal.fire({
                icon: 'warning',
                title: 'Missing Fields',
                text: 'Please provide both username and password.',
                confirmButtonColor: '#4f46e5',
                scrollbarPadding: false,
                heightAuto: false,
                showClass: { popup: '', backdrop: '' },
                hideClass: { popup: '', backdrop: '' },
                customClass: {
                    popup: 'rounded-xl shadow-2xl border border-gray-100',
                    confirmButton: 'px-6 py-2 rounded-md shadow-sm font-medium'
                }
            });
        <% } %>
    </script>
</body>
</html>
