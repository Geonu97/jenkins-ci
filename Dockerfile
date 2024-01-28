# 기본 이미지로부터 시작
FROM httpd:latest

# 작업 디렉토리 설정
WORKDIR /usr/local/apache2/htdocs

# 현재위치의 index.html을 컨테이너의 작업 디렉토리로 복사
COPY index.html .

# 컨테이너가 8000번 포트를 사용하도록 설정
EXPOSE 80

# Apache 웹 서버 시작
CMD ["httpd", "-D", "FOREGROUND"]
