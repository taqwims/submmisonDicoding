FROM node:18.17.1
WORKDIR /app
ENV PORT = 9000
ENV MODEL_URL ='https://storage.googleapis.com/peyimpanan321/model/model.json'
ENV GOOGLE_PROJECT_ID = 'submission-444018'
COPY . .
RUN npm install
EXPOSE 90
CMD [ "npm", "run", "start"]
