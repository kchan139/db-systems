# Hospital Management System

This project uses Docker and Docker Compose to manage its service.

### Installation

1. Clone the repository
```bash
git clone <repository_url>
cd <project_directory>
```

2. Create a `.env` file in the root directory of the project and add your Django `SECRET_KEY`:
```bash
SECRET_KEY='your_django_secret_key_here'
```

3. Build and run the Docker container:
```bash
docker-compose up --build
```

#### Usage

Once the container is running, access the application in your web browser at:
http://localhost:8000

#### Stopping the Containers

To stop the running Docker containers, open your terminal in the project's root directory and run:
```bash
docker-compose down
```