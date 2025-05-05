from django.core.management.base import BaseCommand
from authentication.models import Role
from django.contrib.auth.models import User
from authentication.models import UserRole

class Command(BaseCommand):
    help = 'Creates default roles and adds a superuser to admin role'

    def handle(self, *args, **kwargs):
        # Create all roles
        roles = [
            Role.ADMIN,
            Role.DOCTOR, 
            Role.NURSE,
            Role.STAFF
        ]
        
        for role_name in roles:
            role, created = Role.objects.get_or_create(name=role_name)
            if created:
                self.stdout.write(self.style.SUCCESS(f'Created role: {role}'))
            else:
                self.stdout.write(f'Role already exists: {role}')
                
        # Assign admin role to any superusers
        superusers = User.objects.filter(is_superuser=True)
        admin_role = Role.objects.get(name=Role.ADMIN)
        
        for admin in superusers:
            user_role, created = UserRole.objects.get_or_create(user=admin, role=admin_role)
            if created:
                self.stdout.write(self.style.SUCCESS(f'Added admin role to {admin.username}'))
            else:
                self.stdout.write(f'User {admin.username} already has admin role')