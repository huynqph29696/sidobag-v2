package com.bags.sixdoBag.service.impl;

import com.bags.sixdoBag.model.dto.request.NhanVienRequest;
import com.bags.sixdoBag.model.entitys.DiaChiKhachHang;
import com.bags.sixdoBag.model.entitys.KhachHang;
import com.bags.sixdoBag.model.entitys.NhanVien;
import com.bags.sixdoBag.model.entitys.TaiKhoan;
import com.bags.sixdoBag.model.repository.NhanVienRepository;
import com.bags.sixdoBag.service.ChucVuService;
import com.bags.sixdoBag.service.NhanVienService;
import com.bags.sixdoBag.service.TaiKhoanService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class NhanVienServiceImpl implements NhanVienService {

    private final NhanVienRepository nhanVienRepository;

//    private final TaiKhoanService taiKhoanService;

    private final ChucVuService chucVuService;

    @Override
    public NhanVien getNhanVien(Integer idNhanVien) {
        NhanVien nhanVien = nhanVienRepository.findById(idNhanVien)
                .orElseThrow(() -> new IllegalArgumentException("Id Nhân viên không tồn tại!"));
        return nhanVien;
    }

    @Override
    public List<NhanVien> getNhanViens() {
        List<NhanVien> nhanViens = nhanVienRepository.findNhanVienByAll();
        return nhanViens;
    }

    @Override
    public NhanVien addNhanVien(NhanVien nhanVien) {
        NhanVien nv = new NhanVien();
        nv.setMaNhanVien(nhanVien.getMaNhanVien());
        nv.setHoTen(nhanVien.getHoTen());
        nv.setNgaySinh(nhanVien.getNgaySinh());
        nv.setSdt(nhanVien.getSdt());
        nv.setEmail(nhanVien.getEmail());
        nv.setMatKhau(nhanVien.getMatKhau());
        nv.setQueQuan(nhanVien.getQueQuan());
        nv.setCccd(nhanVien.getCccd());
        nv.setThoiGianVao(nhanVien.getThoiGianVao());
        nv.setGioiTinh(nhanVien.getGioiTinh());
        nv.setTrangThai(1);

        Integer idChucVu = nhanVien.getChucVu().getId();
        if (idChucVu == null) {
            nv.setChucVu(null);
        } else {
            nv.setChucVu(chucVuService.getChucVu(idChucVu));
        }

        TaiKhoan taiKhoan = new TaiKhoan();
        taiKhoan.setTenDangNhap(nhanVien.getEmail());
        taiKhoan.setMatKhau(nhanVien.getMatKhau());
        taiKhoan.setQuyen(0);
        nv.setTaiKhoan(taiKhoan);
        return nhanVienRepository.save(nv);
    }

    @Override
    public NhanVien editNhanVien(Integer idNhanVien, NhanVien nhanVien) {
        NhanVien nv = getNhanVien(idNhanVien);
        nv.setHoTen(nhanVien.getHoTen());
        nv.setNgaySinh(nhanVien.getNgaySinh());
        nv.setSdt(nhanVien.getSdt());
        nv.setMatKhau(nhanVien.getMatKhau());
        nv.setQueQuan(nhanVien.getQueQuan());
        nv.setCccd(nhanVien.getCccd());
        nv.setThoiGianVao(nhanVien.getThoiGianVao());
        nv.setThoiGianRa(nhanVien.getThoiGianRa());
        nv.setGioiTinh(nhanVien.getGioiTinh());
        nhanVien.setTrangThai(nhanVien.getTrangThai());
        Integer idChucVu = nhanVien.getChucVu().getId();
        if (Objects.isNull(idChucVu)) {
            nv.setChucVu(null);
        } else {
            nv.setChucVu(chucVuService.getChucVu(idChucVu));
        }
        if(nv.getTaiKhoan() == null){
            TaiKhoan taiKhoan1 = new TaiKhoan();
            taiKhoan1.setTenDangNhap(nv.getEmail());
            taiKhoan1.setMatKhau(nv.getMatKhau());
            nv.setTaiKhoan(taiKhoan1);
        }else {
            nv.getTaiKhoan().setTenDangNhap(nv.getEmail());
            nv.getTaiKhoan().setMatKhau(nv.getMatKhau());
        }

//        TaiKhoan taiKhoan = nv.getTaiKhoan();
//        taiKhoan.setMatKhau(nhanVien.getMatKhau());
//        nv.setTaiKhoan(taiKhoan);
        return nhanVienRepository.save(nv);
    }

    @Override
    public NhanVien deleteNhanVien(Integer idNhanVien) {
        NhanVien nhanVien = getNhanVien(idNhanVien);
        nhanVien.setTrangThai(0);
        nhanVienRepository.save(nhanVien);
        return nhanVien;
    }

    @Override
    public NhanVien loginNhanVien(String email, String matKhau) {
        return nhanVienRepository.findByTenEndMatKhau(email,matKhau);
    }

    @Override
    public NhanVien getidNhanVien(Integer idNhanVien) {
        NhanVien nhanVien= nhanVienRepository.findById(idNhanVien).orElse(null);
        return nhanVien;
    }

    /////////////////////////////////////////////////
    @Override
    public Page<NhanVien> searchNhanVienTenOrMa(String tenMa, Pageable pageable) {
        return nhanVienRepository.searchNhanVienTenOrMa(tenMa, pageable);
    }
    @Override
    public Page<NhanVien> searchcbb(Integer name, Pageable pageable) {
        return nhanVienRepository.searchCbb(name,pageable);
    }
    @Override
    public Page<NhanVien> searchcbb1(String name, Pageable pageable) {
        return nhanVienRepository.searchCbb1(name,pageable);
    }

    @Override
    public Page<NhanVien> searchDCKHByChucVuId(Long khachHangId, Pageable pageable) {
        return nhanVienRepository.findByChucVuId(khachHangId, pageable);
    }

    @Override
    public NhanVien getNhanVienByEmail(String email) {
        return nhanVienRepository.getNhanVienByEmail(email);
    }

    @Override
    public NhanVien getNhanVienBySDT(String sdt) {
        return nhanVienRepository.getNhanVienBySDT(sdt);
    }

    @Override
    public NhanVien getNhanVienByCCCD(String cccd) {
        return nhanVienRepository.getNhanVienByCCCD(cccd);
    }


}
