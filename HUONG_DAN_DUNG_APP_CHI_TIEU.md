# Hướng Dẫn Chi Tiết: Xây Dựng App Quản Lý Chi Tiêu Cá Nhân

## Tổng Quan
Bạn sẽ xây dựng một **web app quản lý chi tiêu cá nhân** hoàn toàn miễn phí:
- **Frontend**: HTML + JavaScript thuần (1 file)
- **Backend**: Supabase (dữ liệu lưu trên cloud)
- **Hosting**: GitHub Pages (truy cập từ bất kỳ thiết bị nào)
- **Tính năng**: Dashboard, phân loại chi tiêu, nhập nhanh, gợi ý AI, xuất Excel, dark mode, v.v.

---

## PHẦN 1: CHUẨN BỊ (10 phút)

### Bước 1.1: Tạo tài khoản Supabase
1. Vào https://supabase.com/
2. Bấm **"Sign up"** (đăng ký miễn phí)
3. Chọn **"Continue with GitHub"** (hoặc email)
4. Tạo project mới:
   - Tên: `chi-tieu` (hoặc tên khác)
   - Database password: lưu vào chỗ an toàn
   - Region: Chọn gần bạn nhất (VN chọn **Singapore**)
5. Đợi ~2 phút để project tạo xong

### Bước 1.2: Lấy Supabase URL và API Key
Sau khi project tạo xong:
1. Click vào project
2. Vào **Settings** → **API**
3. Tìm mục **"Project URL"** → Copy URL này
4. Tìm mục **"anon public"** → Copy API Key này
5. **Lưu 2 thông tin này vào Notepad** (sẽ dùng sau)

### Bước 1.3: Tạo Tables trong Supabase
1. Vào **SQL Editor** (tab bên trái)
2. Bấm **"New Query"**
3. Copy toàn bộ code dưới đây và paste:

```sql
-- Chi Tiêu Cá Nhân - SQL Setup

CREATE TABLE IF NOT EXISTS transactions (
  id text PRIMARY KEY,
  amount int8 NOT NULL,
  parent_id text,
  child text,
  date date,
  time text,
  note text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS settings (
  key text PRIMARY KEY,
  value jsonb
);

ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow all on transactions" ON transactions FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on settings" ON settings FOR ALL USING (true) WITH CHECK (true);
```

4. Bấm **"Run"** (chạy)
5. Nếu thành công sẽ có thông báo xanh ✓

### Bước 1.4: Tạo tài khoản GitHub (nếu chưa có)
1. Vào https://github.com/
2. Bấm **"Sign up"**
3. Nhập email, password, username
4. Xác minh email

---

## PHẦN 2: TẢI VỀ & SỬA CODE (5 phút)

### Bước 2.1: Tải file HTML
Bạn có 2 cách:

**Cách A: Copy code trực tiếp**
1. [Mở link file HTML](https://github.com/your-repo/chi-tieu.html)
2. Bấm **Raw** (góc phải)
3. Ctrl+A chọn tất cả → Ctrl+C copy
4. Mở **Notepad** → Ctrl+V paste
5. Lưu thành file: **chi-tieu.html**

**Cách B: Tải từ GitHub (nếu đã có)**
Xem phần PHẦN 3.

### Bước 2.2: Sửa Supabase URL và Key
1. Mở file **chi-tieu.html** bằng Notepad (hoặc VSCode)
2. Tìm dòng có text:
   ```javascript
   const SB_URL='https://oayupqsngueoqxxpadvk.supabase.co';
   const SB_KEY='eyJhbGci...';
   ```
3. Thay đổi:
   - `SB_URL`: dán URL lưu từ bước 1.2
   - `SB_KEY`: dán API Key lưu từ bước 1.2
4. **Ctrl+S** lưu file

### Bước 2.3: Test file HTML (tùy chọn)
- Double-click file **chi-tieu.html**
- Nếu mở được trình duyệt với nội dung app → OK!
- Nếu lỗi kết nối Supabase → kiểm tra lại URL và Key

---

## PHẦN 3: DEPLOY LÊN GITHUB PAGES (10 phút)

### Bước 3.1: Tạo Repository GitHub
1. Vào https://github.com/new
2. Điền:
   - **Repository name**: `chi-tieu` (hoặc tên khác)
   - **Description**: "Ứng dụng quản lý chi tiêu cá nhân" (tùy chọn)
   - Chọn **Public** (để có thể deploy Pages)
   - Bỏ tick **"Add a README"** (optional)
3. Bấm **"Create repository"**

### Bước 3.2: Upload file HTML
Có 2 cách:

**Cách A: Upload trực tiếp trên GitHub**
1. Vào repository vừa tạo
2. Bấm **"Add file"** → **"Upload files"**
3. Kéo file **chi-tieu.html** vào khung
4. Bấm **"Commit changes"**

**Cách B: Dùng Git (nâng cao)**
```bash
git clone https://github.com/YOUR-USERNAME/chi-tieu.git
cd chi-tieu
cp /path/to/chi-tieu.html .
git add chi-tieu.html
git commit -m "Initial commit"
git push origin main
```

### Bước 3.3: Bật GitHub Pages
1. Vào repository → **Settings**
2. Kéo xuống tìm **"Pages"** (tab bên trái)
3. Chọn **Branch**: `main`
4. Chọn **Folder**: `/ (root)`
5. Bấm **"Save"**
6. Đợi ~1 phút, trang sẽ cho link: `https://YOUR-USERNAME.github.io/chi-tieu/`

### Bước 3.4: Truy cập App
- Link: **https://YOUR-USERNAME.github.io/chi-tieu/**
- Copy link này
- Mở trên **điện thoại, máy tính, hay bất kỳ thiết bị nào** có internet

---

## PHẦN 4: SỬ DỤNG APP (15 phút tìm hiểu)

### 📊 Tab Dashboard
- **3 KPI card**: Tổng chi tiêu, Số giao dịch, Trung bình/GD
- **Biểu đồ phân loại**: Xem chi tiêu theo loại (Ăn uống, Đi lại, v.v.)
- **Biểu đồ xu hướng**: Nhìn thấy chi tiêu 6 tháng gần nhất
- **Nút Tuần/Tháng**: Chuyển giữa xem theo tuần hoặc tháng
- **Nút ‹ ›**: Lùi/tiến để xem dữ liệu cũ

### 💳 Tab Giao Dịch
- **Danh sách chi tiêu**: Nhóm theo tuần, hiển thị giờ phút
- **Bộ lọc**: Lọc theo loại chi tiêu hoặc khoảng thời gian
- **Nút + Tạo giao dịch**: Thêm giao dịch thủ công
- **Xuất Excel**: Tải file .xlsx để dùng trên Excel
- **Sao lưu / Khôi phục**: Backup dữ liệu dạng JSON

### ⚡ Tab Nhập Nhanh
**Nhập chi tiêu mà không cần click nhiều:**
- Gõ: `39k cà phê` → app tự hiểu là Cafe (Ăn uống)
- Nhập nhiều cùng lúc: `39k cà phê; 25k trà sữa; grab 55k`
- **Nhập lại nhanh**: Bấm vào giao dịch hay dùng để thêm lại ngay
- **Giao dịch định kỳ**: Thêm khoản cố định (Internet, Netflix) rồi bấm "Nhập" hàng tháng

### ⚙️ Tab Cài Đặt
**Ngân sách theo danh mục:**
- Ví dụ: Ăn uống = 3.000.000 VND/tháng
- App sẽ hiển thị progress bar để bạn biết còn bao nhiêu

**Giao dịch định kỳ:**
- Thêm Internet FPT 200.000 VND
- Mỗi tháng chỉ cần bấm "Nhập" trong tab Nhập nhanh

**Quản lý danh mục:**
- Thêm loại chi tiêu mới (Sức khoẻ, Y tế, v.v.)
- Sửa/xoá loại chi tiêu con

### 🌙 Nút Sáng/Tối
- Góc trên bên phải: bấm để chuyển Dark Mode
- Preference lưu trong trình duyệt

---

## PHẦN 5: CẤP NHẬT & BẢO TRÌNHTẾ (tuỳ lúc)

### Nếu bạn cập nhật code mới
1. Mở file **chi-tieu.html**
2. Sửa theo cách ở **Bước 2.2**
3. Lưu file
4. **GitHub**: Upload lại file mới (bước 3.2)
5. **Trình duyệt**: Reload lại (Ctrl+Shift+R để xoá cache)

### Sao lưu dữ liệu
**Hàng tháng nên sao lưu:**
1. Mở app
2. Vào **Giao dịch**
3. Bấm **Sao lưu** → tải file JSON
4. Lưu vào **Google Drive / OneDrive** hoặc USB

**Nếu cần khôi phục:**
1. Mở app
2. Vào **Giao dịch**
3. Bấm **Khôi phục** → chọn file JSON cũ
4. Chọn **OK** để ghi đè

---

## PHẦN 6: GIẢI ĐÁP CÂU HỎI THƯỜNG GẶP

### Q: App có hoạt động offline không?
**A:** Có thể dùng offline nhưng **không thể lưu dữ liệu**. Cần internet để đọc/ghi Supabase.

### Q: Dữ liệu có được bảo mật?
**A:** Dữ liệu lưu trên Supabase (cloud), không ai khác có thể truy cập vì sử dụng API Key riêng. Tương tự như Google Drive.

### Q: Có thể chia sẻ dữ liệu với bạn bè?
**A:** Hiện tại app là single-user. Để chia sẻ, mỗi người phải có Supabase key riêng.

### Q: Tôi quên API Key rồi, phải làm sao?
**A:** Vào Supabase → Settings → API → lấy lại (không hết hạn).

### Q: App này có tốn tiền không?
**A:** **Hoàn toàn miễn phí**:
- Supabase free tier: 500MB database, 2 projects
- GitHub Pages: miễn phí vĩnh viễn
- Nếu dùng lâu dài mà dữ liệu > 500MB thì lên plan trả phí (~$10/tháng)

### Q: Làm thế nào để cập nhật app với tính năng mới?
**A:** Tìm file HTML mới hoặc sửa code bằng tay, rồi upload lại lên GitHub (bước 3.2).

---

## PHẦN 7: CHIA SẺ APP VỚI NGƯỜI KHÁC

Nếu bạn muốn chia sẻ link app cho bạn bè:

### Cách 1: Share trực tiếp (nhanh nhất)
- Copy link: `https://YOUR-USERNAME.github.io/chi-tieu/`
- Gửi cho bạn bè
- Bạn bè mở link → sử dụng ngay (không cần cài đặt)

### Cách 2: Tạo hướng dẫn chi tiết
Bạn có thể tạo file `README.md` trong GitHub:
1. Vào repository
2. Bấm **Add file** → **Create new file**
3. Tên file: `README.md`
4. Copy nội dung dưới đây:

```markdown
# Chi Tiêu Cá Nhân

App quản lý chi tiêu miễn phí, chạy trên web.

## Tính năng
- 📊 Dashboard với biểu đồ
- 💳 Quản lý giao dịch
- ⚡ Nhập nhanh (parse tự động)
- 📈 Theo dõi xu hướng 6 tháng
- 🌙 Dark mode
- 📱 Dùng được trên điện thoại

## Cách dùng
1. Mở: https://YOUR-USERNAME.github.io/chi-tieu/
2. Đầu tiên, ứng dụng sẽ hỏi migrate dữ liệu cũ (nếu có)
3. Bắt đầu ghi nhận chi tiêu!

## Sao lưu dữ liệu
- Vào tab **Giao dịch** → bấm **Sao lưu**
- Tải file JSON và lưu vào nơi an toàn

## Hỗ trợ
Nếu có bug hoặc tính năng muốn thêm, tạo issue trong GitHub.
```

5. Bấm **Commit changes**

---

## PHẦN 8: MẹO & THỨ TÍNH NĂNG NÂNG CAO

### Thêm danh mục mới
1. Vào **Cài đặt** → **Quản lý danh mục**
2. Bấm **+ Thêm loại giao dịch**
3. Nhập tên (ví dụ: Sức khoẻ)
4. Chọn emoji (🏥) và màu
5. Bấm **Lưu**

### Nhập nhanh thông minh
App tự nhận diện từ khoá:
- `cà phê`, `cafe` → Cafe (Ăn uống)
- `grab`, `taxi`, `uber` → Grab/Taxi (Đi lại)
- `internet`, `fpt` → Internet (Hóa đơn)
- `phim`, `cgv`, `cinema` → Xem phim (Giải trí)

Tìm thêm từ khoá trong tab **Nhập nhanh** → **Từ khoá nhận diện**

### So sánh kỳ trước
Mỗi KPI card hiển thị mũi tên (↑↓) so với tuần/tháng trước:
- ↑ đỏ = chi nhiều hơn
- ↓ xanh = chi ít hơn

### Export file Excel
- Bấm **Xuất Excel** để tải file `.xlsx`
- Mở bằng Excel, Google Sheets, hoặc LibreOffice
- Chỉnh sửa, pivot table, v.v. tuỳ ý

---

## PHẦN 9: TROUBLESHOOTING

### Lỗi: "Cannot reach Supabase"
**Nguyên nhân**: URL hoặc API Key sai, hoặc không có internet
**Cách sửa**:
1. Kiểm tra kết nối internet
2. Vào Supabase → Settings → API → copy lại đúng URL và Key
3. Sửa lại file HTML (bước 2.2) → upload GitHub lại

### Lỗi: "Dữ liệu không lưu được"
**Nguyên nhân**: Table hoặc RLS policy chưa được tạo đúng
**Cách sửa**:
1. Vào Supabase → SQL Editor
2. Kiểm tra xem tables `transactions` và `settings` có tồn tại không
3. Nếu chưa có, chạy lại SQL code từ bước 1.3

### App quá chậm khi tải
**Nguyên nhân**: Quá nhiều giao dịch (~10.000+), hoặc mạng chậm
**Cách sửa**:
1. Giảm dữ liệu: Xóa giao dịch rất cũ
2. Dùng filter để xem từng tháng thay vì tất cả
3. Đợi 1-2 phút load

### Quên mất dữ liệu, muốn khôi phục
**Cách sửa**:
1. Nếu có file backup JSON → dùng **Khôi phục** (bước 4)
2. Nếu không có → liên hệ Supabase support (không khôi phục được)

---

## PHẦN 10: LỜI KHUYÊN CỦA TÁC GIẢ

1. **Nhập liệu đều đặn**: Hàng ngày hoặc hàng tuần ghi nhận chi tiêu để có dữ liệu chính xác
2. **Sao lưu hàng tháng**: Tải file JSON để tránh mất dữ liệu bất ngờ
3. **Đặt ngân sách hợp lý**: Xem xu hướng 6 tháng rồi đặt mục tiêu
4. **Phân tích chi tiêu**: Xem chart để nhận biết thói quen tiêu tiền
5. **Chia sẻ kinh nghiệm**: Nếu app hữu ích, giới thiệu bạn bè ✨

---

## LIÊN HỆ & HỖ TRỢ

Nếu cần giúp đỡ:
- **Lỗi Supabase**: Vào https://supabase.com/support
- **Lỗi GitHub Pages**: Vào https://github.com/support
- **Cải thiện app**: Có thể tự sửa code hoặc tìm ai đó biết lập trình giúp

---

**Chúc bạn sử dụng app vui vẻ! 🎉**
