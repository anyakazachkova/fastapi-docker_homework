FROM ubuntu

RUN apt-get update

RUN apt-get install -y git python3 python3-pip

COPY main.py /main.py

RUN echo "#!/bin/bash" > /bin/print_hello
RUN echo "echo 'Hello world'" >> /bin/print_hello

RUN chmod a+rwx /bin/print_hello

RUN /bin/print_hello

COPY README.md /README.md

COPY requirements.txt /requirements.txt

RUN pip install -r requirements.txt

RUN useradd -ms /bin/bash deploy2022user

USER deploy2022user

CMD ["uvicorn", "--host", "0.0.0.0", "--port", "8898", "main:app"]
