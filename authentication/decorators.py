from django.http import HttpResponseForbidden
from functools import wraps
from django.contrib.auth.decorators import login_required

def role_required(*roles):
    def decorator(view_func):
        @wraps(view_func)
        @login_required
        def _wrapped_view(request, *args, **kwargs):
            if any(role in request.user_roles for role in roles):
                return view_func(request, *args, **kwargs)
            return HttpResponseForbidden("You don't have permission to access this page.")
        return _wrapped_view
    return decorator