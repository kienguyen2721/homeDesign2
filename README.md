
# MVC Sample

Kiến trúc folder MVC, dễ dàng sử dụng và maintain, cleancode


## Hướng dẫn về  Domain - RealmPlatform

```javascript
/*
  Dành cho việc lưu trữ trong realm
  Bước 1: Vào Domain/Entries -> Tạo 1 Entry. Ví dụ: Rock
  Bước 2: Vào Domain/UseCases -> Tạo 1 UseCase tương ứng. Ví dụ RocksUseCase.
  - Hint: Đặt câu hỏi user có thể làm gì với Model Rock này? Thông thường là CRUD
  Bước 2.1: Vào Domain/UseCase/UseCaseProvider -> Viết 1 function để tạo ra UseCase tương ứng
  Bước 2: Vào RealmPlatform/Entities -> Tạo 1 Entity: Ví dụ RMRock
  Bước 3 Vào RealmPlatform/UseCases -> Tạo useCase tương ứng.
  - Hint: Xem ví dụ với TodosUseCase
  Bước 4: Vào RealmPlatform/RMUseCaseProvider -> viết hàm CỤ THỂ HOÁ việc tạo ra useCase
 **/

```


## Acknowledgements

 - Hiểu biết cơ bản về hướng đối tượng
 - Hiểu biết về Swift
 - Hiểu biết về network, realm
