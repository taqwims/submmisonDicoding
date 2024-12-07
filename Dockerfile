FROM node:18.17.1
WORKDIR /app
ENV PORT 8080
ENV MODEL_URL 'https://storage.googleapis.com/model-storage-submission/model-in-prod/model.json'
ENV GOOGLE_PROJECT_ID 'submission-444018'
COPY . .
RUN npm install
EXPOSE 8080
CMD [ "npm", "run", "start"]
