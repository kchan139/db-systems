from django.urls import reverse
from django.http import HttpResponseForbidden
from django.shortcuts import redirect
from .models import UserRole

class RoleMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Process the request before the view
        # Check if user is available (AuthenticationMiddleware has run)
        if hasattr(request, 'user') and request.user.is_authenticated:
            request.user_roles = [ur.role.name for ur in UserRole.objects.filter(user=request.user)]
        else:
            request.user_roles = []
            
        response = self.get_response(request)
        return response