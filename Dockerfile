FROM node:18.17.1

# Set working directory
WORKDIR /app

# Set environment variables
ENV PORT 8080
ENV MODEL_URL 'https://storage.googleapis.com/peyimpanan321/model/model.json'
ENV GOOGLE_PROJECT_ID 'submission-444018'

# Copy application code
COPY . .

# Install dependencies
RUN npm install

# Expose the application port
EXPOSE 8080

# Start the application
CMD [ "npm", "run", "start" ]

# Define a health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=120s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1
