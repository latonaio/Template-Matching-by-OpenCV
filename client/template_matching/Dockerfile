FROM latonaio/l4t:latest

# Definition of a Device & Service
ENV POSITION=Runtime \
    SERVICE=template-matching-by-opencv \
    AION_HOME=/var/lib/aion

# Setup Directoties
RUN mkdir -p ${AION_HOME}/$POSITION/$SERVICE
WORKDIR ${AION_HOME}/$POSITION/$SERVICE/
ADD client/template_matching .

ENV SERVER_HOST template-matching-by-opencv-server-001-srv
ENV SERVER_PORT 50052

CMD ["python3", "-u", "main.py"]