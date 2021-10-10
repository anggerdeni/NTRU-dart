FROM dart:2.13.1
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get
ENTRYPOINT ["tail", "-f", "/dev/null"]