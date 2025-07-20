FROM python:3.9
WORKDIR /app
COPY . .
RUN pip install requirements.txt
CMD [ "python","app.py" ]