FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -qy python-fontforge git
COPY LigaHack-Regular.ttf /
RUN git clone https://github.com/gabrielelana/awesome-terminal-fonts.git -b patching-strategy
COPY patch /awesome-terminal-fonts/patch

WORKDIR /awesome-terminal-fonts
RUN chmod +x patch
RUN cp /LigaHack-Regular.ttf ./S0.ttf
RUN ./patch S0.ttf --symbols=./fonts/fontawesome-webfont.ttf --to-namespace=AWESOME --rename-as=S1 --starting-at='0xe100' --ratio=0.9 --shift-x=200 --shift-y=-300
RUN ./patch S1.ttf --symbols=./fonts/octicons-regular.ttf --to-namespace=OCTICONS --rename-as=S2 --starting-at='0xe800' --ratio=0.85 --shift-x=-100 --shift-y=-100
RUN ./patch S2.ttf --symbols=./fonts/pomicons-regular.ttf --to-namespace=POMICONS --rename-as=S3 --starting-at='0xf000' --ratio=0.85 --shift-y=-400 --shift-x=-600
RUN cat S1.sh S2.sh >> AwesomeLigaHack-Regular.sh
RUN rm -rf S?.*
