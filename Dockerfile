FROM node:18.17.1
WORKDIR /app
ENV PORT = 8080
ENV MODEL_URL ='https://storage.googleapis.com/peyimpanan321/model/model.json'
ENV GOOGLE_PROJECT_ID = 'submission-444018'
COPY . .
RUN npm install
EXPOSE 8080
CMD [ "npm", "run", "start"]
HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 CMD curl -f http://localhost:${PORT}/ || exit 1
EXPOSE 8080
