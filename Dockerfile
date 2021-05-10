# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.9-buster

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
COPY ./requirements.txt /app/
RUN python -m pip install -r /app/requirements.txt

WORKDIR /app
COPY . /app

# Create the user
# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
ARG USERNAME="py"
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd -m -s /bin/bash --uid $USER_UID -g $USER_GID $USERNAME 
USER $USERNAME

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
# File wsgi.py was not found in subfolder: 'workspace'. Please enter the Python path to wsgi file.
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "{workspace_folder_name}.wsgi"]
#CMD ["tail", "-f /dev/null"]