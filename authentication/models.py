from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Role(models.Model):
    ADMIN = 'admin'
    DOCTOR = 'doctor'
    NURSE = 'nurse'
    STAFF = 'staff'

    ROLE_CHOICE = [
        (ADMIN, 'Administrator'),
        (DOCTOR, 'Doctor'),
        (NURSE, 'Nurse'),
        (STAFF, 'Staff'),
    ]

    name = models.CharField(max_length=50, choices=ROLE_CHOICE, unique=True)

    def __str__(self):
        return self.get_name_display()
    

class UserRole(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='user_roles')
    role = models.ForeignKey(Role, on_delete=models.CASCADE)
    
    class Meta:
        unique_together = ('user', 'role')
    
    def __str__(self):
        return f"{self.user.username} - {self.role}"