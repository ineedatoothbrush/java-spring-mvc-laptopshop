# Bước 1: Chọn base image (Java 17 khớp với pom.xml của bạn)
FROM openjdk:17-slim

# Bước 2: Đặt thư mục làm việc bên trong container
WORKDIR /app

# Bước 3: Sao chép tệp .jar đã được build từ thư mục target
# Lệnh này sẽ tìm tệp (ví dụ: laptopshop-0.0.1-SNAPSHOT.jar) và đổi tên thành app.jar
COPY target/laptopshop-*.jar app.jar

# Bước 4: (Tùy chọn nhưng nên có) Expose cổng mặc định của Spring Boot
EXPOSE 8080

# Bước 5: Lệnh để khởi chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]