from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from authentication.models import Role, UserRole

class Command(BaseCommand):
    help = 'Creates sample users for each role'

    def handle(self, *args, **kwargs):
        # Make sure roles exist first
        roles = {
            'admin': 'Admin User',
            'doctor': 'Doctor User',
            'nurse': 'Nurse User',
            'staff': 'Staff User',
        }
        
        # Create a user for each role
        for role_name, display_name in roles.items():
            username = f"{role_name}"
            email = f"{role_name}@example.com"
            password = f"{role_name}123"
            
            # Create user if not exists
            user, created = User.objects.get_or_create(
                username=username,
                defaults={
                    'email': email,
                    'is_staff': role_name == 'admin',
                    'is_superuser': role_name == 'admin',
                    'first_name': display_name.split()[0],
                    'last_name': display_name.split()[1]
                }
            )
            
            # Set password if user was just created
            if created:
                user.set_password(password)
                user.save()
                self.stdout.write(self.style.SUCCESS(f'Created user: {username}'))
            else:
                self.stdout.write(f'User already exists: {username}')
            
            # Assign role
            role = Role.objects.get(name=role_name)
            user_role, created = UserRole.objects.get_or_create(user=user, role=role)
            
            if created:
                self.stdout.write(self.style.SUCCESS(f'Added {role_name} role to {username}'))
            else:
                self.stdout.write(f'User {username} already has {role_name} role')
            
            self.stdout.write(f'Login credentials - Username: {username}, Password: {password}')