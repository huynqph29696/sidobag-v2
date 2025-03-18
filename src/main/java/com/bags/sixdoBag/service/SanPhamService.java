package com.bags.sixdoBag.service;

import com.bags.sixdoBag.model.dto.request.ProductHomeRequest;
import com.bags.sixdoBag.model.dto.request.SanPhamRequest;
import com.bags.sixdoBag.model.entitys.SanPham;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface SanPhamService {

    public SanPham getSanPham(Integer idSanPham);

    public List<SanPham> getSanPhams();

    public SanPham addSanPham(SanPhamRequest sanPham);

    public SanPham editSanPham(Integer idSanPham, SanPhamRequest sanPham);
    public List<SanPham> getSoLuongThongKe();
    public SanPham deleteSanPham(Integer idSanPham);

    public List<SanPham> searchSanPhamTenOrMa(String tenMa);

    public List<SanPham> pageSanPham(int limit, int size);

    public List<SanPham> searchKhoiLuong(int min, int max);

    public List<SanPham> searchChatLieu(String chatLieu);

    public List<SanPham> searchKichThuoc(int min, int max);

    List<SanPham> filterSanPhamChatLieuOrThuongHieu(String tenChatLieu, String tenThuongHieu, boolean trangThai);

    List<ProductHomeRequest> listHienThiSanPham();

    List<ProductHomeRequest> listHienThiSanPhamLimit(int limit);

    List<ProductHomeRequest> displayedByBrand(int idSp, int idThuongHieu);

    List<ProductHomeRequest> sanPhamCoGiaTienTuongTu(int idSp, int min, int max);

    List<ProductHomeRequest> sanPhamCoDanhMucTuongTu(int idSp, int idDanhMuc);

    List<ProductHomeRequest> searchSanPhamOnlines(String name);

    public boolean findByNameSanPham(String name);

    public boolean findByNameSanPhamSua(String name, int idSp);

    List<ProductHomeRequest> filterMaMauSacOrThuongHieuOnlineProductHome(String maMau, String tenThuongHieu);
}
