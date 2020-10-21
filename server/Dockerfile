FROM l4t-ds-opencv-7.2:latest

ENV POSITION=Runtime \
    SERVICE=template-matching-by-opencv-server \
    AION_HOME="/var/lib/aion"

# Setup Directoties
RUN mkdir -p ${AION_HOME}/$POSITION/$SERVICE
WORKDIR ${AION_HOME}/$POSITION/$SERVICE/

ADD server .

RUN python3 setup.py install
CMD ["python3", "main.py"]
