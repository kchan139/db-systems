from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.contrib.auth.forms import AuthenticationForm
from .decorators import role_required

# Create your views here.

def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(username=username, password=password)
            if user is not None:
                login(request, user)
                return redirect('dashboard')
            else:
                messages.error(request, "Invalid username or password.")
        else:
            messages.error(request, "Invalid username or password.")
    form = AuthenticationForm()
    return render(request, "authentication/login.html", {"form": form})

def logout_view(request):
    logout(request)
    return redirect('login')

@login_required
def dashboard(request):
    return render(request, 'authentication/dashboard.html')

@login_required
@role_required('admin')
def user_management(request):
    return render(request, 'authentication/user_management.html')