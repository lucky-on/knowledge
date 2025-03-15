FROM python:3.9

RUN useradd --create-home --shell /bin/bash data_scientist

COPY libs_to_install.txt ./

RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r libs_to_install.txt

USER data_scientist

RUN mkdir -p /home/data_scientist/k_max_filter_app

WORKDIR /home/data_scientist/k_max_filter_app

COPY . /home/data_scientist/k_max_filter_app/

CMD ["bash"]

ENTRYPOINT ["python", "k_max_filter.py"]
