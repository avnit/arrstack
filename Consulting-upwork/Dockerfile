# Use the official Python image as a base image
FROM python:3.8-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file and install the dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the application files
COPY . .

# Expose the port that the Flask application will run on
EXPOSE 5000

# Set the command to run the Flask application
CMD ["python", "app.py"]