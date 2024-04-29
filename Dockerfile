# Define custom function directory
ARG FUNCTION_DIR="/function"

# Use the official Python image as the base image
FROM python:3.12

# Include global arg in this stage of the build
ARG FUNCTION_DIR

# make a directory for the function
RUN mkdir -p ${FUNCTION_DIR}

# copy the function code to the function directory
COPY app.py requirements.txt ${FUNCTION_DIR}

# Install the function's dependencies
RUN pip install \
    --target ${FUNCTION_DIR} \
        awslambdaric \
        -r ${FUNCTION_DIR}/requirements.txt

# Define new base image, using multi stage build, to reduce image size
FROM python:3.12-slim

ARG FUNCTION_DIR

# Set working directory to function root directory
WORKDIR ${FUNCTION_DIR}

# Copy the function code from the previous stage
COPY --from=0 ${FUNCTION_DIR} ${FUNCTION_DIR}

# Install tesseract-ocr
# I tried to install tess in the first stage but it was rigurous to figure out which files to copy
# over to the second stage. So I decided to install it in the second stage
RUN apt-get update && apt-get install -y tesseract-ocr && ldconfig

# Set runtime interface client as default command for the container runtime
ENTRYPOINT [ "/usr/local/bin/python", "-m", "awslambdaric" ]

# Pass the name of the function handler as an argument to the runtime
CMD ["app.handler"]