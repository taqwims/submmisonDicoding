FROM node:18.17.1
WORKDIR /app
ENV PORT 8080
ENV MODEL_URL 'https://storage.googleapis.com/model-storage-submission/model-in-prod/model.json'
ENV GOOGLE_PROJECT_ID 'submissionmlgc-ahsan'
COPY . .
RUN npm install
EXPOSE 3000
CMD [ "npm", "run", "start"]
