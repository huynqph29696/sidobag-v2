package com.bags.sixdoBag.model.repository;

import com.bags.sixdoBag.model.entitys.ChiTietSanPham;
import com.bags.sixdoBag.model.entitys.SanPham;
import jakarta.transaction.Transactional;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Transactional
@Repository
public interface ChiTietSanPhamRepository extends JpaRepository<ChiTietSanPham, Integer> {

    @Query(value = "select * from chi_tiet_san_pham where trang_thai = 1 ", nativeQuery = true)
    List<ChiTietSanPham> getListCtsp();


    @Query(value = "select * from chi_tiet_san_pham as ctsp where ctsp.trang_thai=1 and ctsp.so_luong>0", nativeQuery = true)
    List<ChiTietSanPham> getListCtspTaiQuay();

    @Query(value = "SELECT ctsp FROM ChiTietSanPham ctsp " +
            "JOIN SanPham sp ON ctsp.sanPham = sp " +
            "JOIN MauSac ms ON ctsp.mauSac = ms " +
            "WHERE ctsp.trangThai = 1 " +
            "AND ctsp.soLuong > 0 " +
            "AND (ctsp.ma LIKE %:tenMa% " +
            "OR sp.tenSanPham LIKE %:tenMa% " +
            "OR ms.tenMauSac LIKE %:tenMa%)")
    List<ChiTietSanPham> listSearch(@Param("tenMa") String tenMa);



    @Query(value = "select ctsp from ChiTietSanPham ctsp where ctsp.trangThai=1 and ctsp.soLuong >0 ")
    List<ChiTietSanPham> listSearchTaiQuay(String tenMa);


    @Query(value = "select ctsp from ChiTietSanPham ctsp join SanPham sp on ctsp.sanPham = sp join MauSac ms on ctsp.mauSac = ms" +
            " where ctsp.ma = :ma")
    Optional<ChiTietSanPham> searchSanPhamByMa(String ma);


    @Query(value = "select ctsp from ChiTietSanPham ctsp join SanPham sp on ctsp.sanPham = sp join MauSac ms on ctsp.mauSac = ms" +
            " join DoiTuongSuDung as dtsd on sp.doiTuongSuDung = dtsd where" +
            " sp.chatLieu like %:chatLieu% and" +
            " dtsd.tenDoiTuongSuDung like %:doiTuongSuDung%  and " +
            "ms.tenMauSac like %:mauSac% and sp.thuongHieu.ten like %:thuongHieu%")
    public List<ChiTietSanPham> filterTaiQuay(String chatLieu, String thuongHieu, String mauSac, String doiTuongSuDung);


    @Query(value = "select ctsp from ChiTietSanPham ctsp where ctsp.sanPham.id=:idSanPham")
    List<ChiTietSanPham> getChiTietSanPhamById(int idSanPham);


    @Query(value = "select ctsp from ChiTietSanPham ctsp where ctsp.sanPham.id=:idSanPham and ( ctsp.trangThai=1 or ctsp.trangThai=2 )")
    List<ChiTietSanPham> getChiTietSanPhamByIdSpOnline(int idSanPham);



    @Query(value = "select ctsp.soLuong from ChiTietSanPham ctsp where ctsp.id=:idCtSanPham")
    int getSoLuongSanPhamById(int idCtSanPham);

    @Modifying
    @Query("update ChiTietSanPham ctsp set ctsp.soLuong = :newSoLuong where ctsp.id = :idCtSanPham")
    void updateSoLuongSanPham(int newSoLuong, int idCtSanPham);

    @Query("select ctsp from ChiTietSanPham ctsp where ctsp.ma =:ma")
    ChiTietSanPham getChiTietSanPhamByMa(String ma);

    @Query("select ctsp from ChiTietSanPham  ctsp where ctsp.mauSac.tenMauSac =:mauSac")
    ChiTietSanPham getChiTietSanPhamByMauSac(String mauSac);

    @Query("select ctsp from ChiTietSanPham  ctsp where ctsp.sanPham.id =:idSp and ctsp.mauSac.tenMauSac =:mauSac")
    List<ChiTietSanPham> getListCTSPByMauSac(Integer idSp, String mauSac);

    @Query("select ctsp from ChiTietSanPham ctsp where ctsp.sanPham.id =:idSp and ctsp.ma like %:name% or ctsp.sanPham.tenSanPham like %:name% ")
    List<ChiTietSanPham> getChiTietSanPhamByTenSpAndMa(Integer idSp, String name);


    @Query(value = "SELECT SUM(cthd.so_luong) " +
            "FROM chi_tiet_hoa_don cthd " +
            "JOIN hoa_don hd ON cthd.id_hoa_don = hd.id " +
            "WHERE hd.trang_thai = 0 " +
            "AND cthd.id_ctsp = :idCtsp", nativeQuery = true)
    Integer soLuongMuaByChiTietSanPham(@Param("idCtsp") int idCtsp);


    @Query(value = "select sum(cthd.so_luong) from hoa_don as hd " +
            "    join chi_tiet_hoa_don as cthd on cthd.id_hoa_don = hd.id " +
            "    join chi_tiet_san_pham as ctsp on ctsp.id = cthd.id_ctsp " +
            "    join san_pham as sp on sp.id = ctsp.id_san_pham " +
            "    where hd.trang_thai = 0 and sp.id = :idSp", nativeQuery = true)
    Integer soLuongMuaBySanPham(@Param("idSp") int idSp);

//    select sp.ten, sum(cthd.so_luong) from hoa_don as hd
//    join chi_tiet_hoa_don as cthd on cthd.id_hoa_don = hd.id
//    join chi_tiet_san_pham as ctsp on ctsp.id = cthd.id_ctsp
//    join san_pham as sp on sp.id = ctsp.id_san_pham
//    where hd.trang_thai = 0 group by sp.ten
//
//    select  sp.ten, cthd.id_ctsp, sum(cthd.so_luong) from hoa_don as hd
//    join chi_tiet_hoa_don as cthd on cthd.id_hoa_don = hd.id
//    join chi_tiet_san_pham as ctsp on ctsp.id = cthd.id_ctsp
//    join san_pham as sp on sp.id = ctsp.id_san_pham
//    where hd.trang_thai = 0
//    group by cthd.id_ctsp, sp.ten


}