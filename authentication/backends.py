from django.contrib.auth.backends import ModelBackend
from .models import UserRole

class RoleBasedBackend(ModelBackend):
    def has_perm(self, user_obj, perm, obj=None):
        if not user_obj.is_active:
            return False
            
        # Check if the user has admin role
        if UserRole.objects.filter(user=user_obj, role__name='admin').exists():
            return True
            
        # Custom permission logic based on roles
        if perm.startswith('hospital.view_'):
            # Staff, doctors, and nurses can view most resources
            return UserRole.objects.filter(
                user=user_obj, 
                role__name__in=['doctor', 'nurse', 'staff']
            ).exists()
            
        if perm.startswith('hospital.change_'):
            model = perm.split('_')[1]
            
            # Doctors can modify patient related data
            if model in ['patient', 'medicalhistory', 'surgery']:
                return UserRole.objects.filter(
                    user=user_obj, 
                    role__name='doctor'
                ).exists()
                
        return super().has_perm(user_obj, perm, obj)