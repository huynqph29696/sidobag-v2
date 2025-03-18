<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Title</title>
</head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
<style>
    .out-of-stock {
        color: red;
        font-size: 16px;
    }
    .stocking{
        color: black;
    }

    .img__wrapper{

        position:relative;
        overflow:hidden;
    }

    .sold_out {
        top: 2em;
        left: -4em;
        color: #fff;
        display: block;
        position:absolute;
        text-align: center;
        text-decoration: none;
        letter-spacing: .06em;
        background-color: #A00;
        padding: 0.5em 5em 0.4em 5em;
        text-shadow: 0 0 0.75em #444;
        box-shadow: 0 0 0.5em rgba(0,0,0,0.5);
        font: bold 26px/1.2em Arial, Sans-Serif;
        -webkit-text-shadow: 0 0 0.75em #444;
        -webkit-box-shadow: 0 0 0.5em rgba(0,0,0,0.5);
        -webkit-transform: rotate(-45deg) scale(0.75,1);
        z-index:10;
    }
    .sold_out:before {
        content: '';
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        position: absolute;
        margin: -0.3em -5em;
        transform: scale(0.7);
        -webkit-transform: scale(0.7);
        border: 2px rgba(255,255,255,0.7) dashed;
    }
</style>
<body>

<section class="sec-product-detail bg0 p-t-65 p-b-60">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-lg-7 p-b-30">
                <div class="p-l-25 p-r-30 p-lr-0-lg">
                    <div class="wrap-slick3 flex-sb flex-w">
                        <div class="wrap-slick3-dots"></div>
                        <div class="wrap-slick3-arrows flex-sb-m flex-w"></div>

                        <div class="slick3 gallery-lb">
                            <c:forEach var="o" items="${product}" varStatus="loop">
                                <div class="item-slick3" data-thumb="${pageContext.request.contextPath}/${o.hinhAnh}">
                                    <div class="wrap-pic-w pos-relative img__wrapper">
                                        <p class="${o.soLuong < 1 ? 'sold_out' : ''}" > ${o.soLuong < 1 ? 'HẾT HÀNG' : ''}</p>
                                        <img id="product-image" style="height: 500px"
                                             onclick="('${pageContext.request.contextPath}/${o.hinhAnh}')"
                                             class="hset "
                                             src="${pageContext.request.contextPath}/${o.hinhAnh}">
                                        <a class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04"
                                           href="${pageContext.request.contextPath}/${o.hinhAnh}">
                                            <i class="fa fa-expand"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </div>
                </div>
            </div>


            <div class="col-md-6 col-lg-5 p-b-30">


                <div class="p-r-50 p-t-5 p-lr-0-lg">
                    <h4 class="mtext-105 cl2 js-name-detail p-b-14">
                        ${product[0].sanPham.tenSanPham}
                    </h4>

                    <p class="mtext-106 cl2" id="product-price">
                        <fmt:formatNumber pattern="#,###" var="tongTam" value="${product[0].giaBan}"></fmt:formatNumber>
                        ${tongTam} đồng</p>

                    <!-- Thêm thông tin về thương hiệu -->
                    <p class="stext-102 cl3">
                        Thương hiệu: <strong> ${product[0].sanPham.thuongHieu.ten}</strong>
                    </p>

                    <!-- Thêm thông tin về kích thước -->
                    <p class="stext-102 cl3">
                        Kích thước: <strong> ${product[0].sanPham.kichThuoc} cm</strong>
                    </p>

                    <!-- Thêm thông tin về số lượng bán -->
                    <p class="stext-102 cl3 p-tb-1">
                        Đã bán <strong id="so-luong-ban-ra"></strong>
                    </p>

                    <p class="stext-102 cl3 ">
                        Kho: <strong id="so-luong-kho-detail">
                        ${product[0].soLuong < 1 ? 'Hết hàng' : product[0].soLuong}
                    </strong>
                    </p>

                    <!--  -->
                    <div class="p-t-33">


                        <div class="flex-w flex-r-m p-b-10">
                            <div class="size-203 flex-c-m respon6">
                                Màu sắc
                            </div>

                            <div class="size-204 respon6-next">
                                <div class="rs1-select2 bor8 bg0">
                                    <select class="js-select2" id="select-id-color" name="time"
                                            onchange="updatePrice(this)">
                                        <c:forEach var="o" items="${product}" varStatus="loop">
                                            <option data-product-id="${o.id}"
                                                    value="${o.id}">${o.mauSac.tenMauSac}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="dropDownSelect2"></div>
                                </div>
                            </div>
                        </div>

                        <div class="flex-w flex-r-m p-b-10">
                            <div class="size-204 flex-w flex-m respon6-next">
                                <div class="wrap-num-product flex-w m-r-20 m-tb-10">
                                    <div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m quantity-add-product-down">
                                        <i class="fs-16 zmdi zmdi-minus"></i>
                                    </div>

                                    <input id="quantity-product-add-to-cart"
                                           class="mtext-104 cl3 txt-center num-product" type="number" name="num-product"
                                           value="1" oninput="checkValue(this)">

                                    <div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m quantity-add-product-up">
                                        <i class="fs-16 zmdi zmdi-plus"></i>
                                    </div>
                                </div>

                                <button class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04 js-addcart-detail-customer">
                                    Thêm vào giỏ hàng
                                </button>
                            </div>
                        </div>
                    </div>

                    <!--  -->
                    <div class="flex-w flex-m p-l-100 p-t-40 respon7">
                        <div class="flex-m bor9 p-r-10 m-r-11">
                            <a class="btn-addwish-b2 dis-block pos-relative js-addwish-b2 js-addedwish-b2"
                               data-product-id="${product[0].sanPham.id}" data-wishlist="false">
                                <i class="bi bi-heart"></i>
                                <i class="bi bi-heart-fill"></i>
                            </a>
                        </div>

                        <span class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 m-r-8 tooltip100"
                              data-tooltip="Facebook">
                            <i class="fa fa-facebook"></i>
                        </span>

                        <span class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 m-r-8 tooltip100"
                              data-tooltip="Twitter">
                            <i class="fa fa-twitter"></i>
                        </span>

                        <span class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 m-r-8 tooltip100"
                              data-tooltip="Google Plus">
                            <i class="fa fa-google-plus"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="bor10 m-t-50 p-t-43 p-b-40">
            <!-- Tab01 -->
            <div class="tab01">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item p-b-10">
                        <a class="nav-link active inf-title" style="font-size: 26px" data-toggle="tab"
                           href="#information" role="tab">Mô Tả</a>
                    </li>

                    <%--                    <li class="nav-item p-b-10">--%>
                    <%--                        <a class="nav-link inf-title" style="font-size: 19px" data-toggle="tab" href="#information"--%>
                    <%--                           role="tab">Thông tin bổ sung</a>--%>
                    <%--                    </li>--%>


                </ul>

                <!-- Tab panes -->
                <div class="tab-content p-t-43">
                    <!-- - -->
                    <div class="tab-pane fade show active" id="information" role="tabpanel">
                        <div class="row">
                            <div class="col-sm-10 col-md-8 col-lg-6 m-lr-auto">
                                <ul class="p-lr-28 p-lr-15-sm">
                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Mã Sản Phẩm :
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                            ${product[0].sanPham.maSanPham}
                                        </span>
                                    </li>
                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Khối Lượng :
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                            <fmt:formatNumber pattern="#,###" var="khoiLuongdt"
                                                              value="${product[0].sanPham.khoiLuong}"></fmt:formatNumber>
                                            ${khoiLuongdt} gram
                                        </span>
                                    </li>

                                    <li class="flex-w flex-t p-b-7 ">
											<span class="stext-102 cl3 size-205 inf">
												Kích Thước :
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                            ${product[0].sanPham.kichThuoc} cm
                                        </span>
                                    </li>

                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Chất Liệu :
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                            ${product[0].sanPham.chatLieu}
                                        </span>
                                    </li>

                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Màu Sắc :
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                             <c:forEach var="o" items="${product}" varStatus="loop">
                                                 ${o.mauSac.tenMauSac},
                                             </c:forEach>
											</span>
                                    </li>

                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Xuất Xứ :
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                            ${product[0].sanPham.xuatXu}
                                        </span>
                                    </li>
                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Thương Hiệu:
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                            ${product[0].sanPham.thuongHieu.ten}
                                        </span>
                                    </li>
                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Danh Mục:
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                            ${product[0].sanPham.danhMuc.tenDanhMuc}
                                        </span>
                                    </li>
                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Đối tượng sử dụng:
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                            ${product[0].sanPham.doiTuongSuDung.tenDoiTuongSuDung}
                                        </span>
                                    </li>
                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Bảo Hành :
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                            ${product[0].sanPham.thoiGianBaoHanh.thoiGian} tháng
                                        </span>
                                    </li>
                                    <li class="flex-w flex-t p-b-7">
											<span class="stext-102 cl3 size-205 inf">
												Mô tả sản phẩm :
											</span>

                                        <span class="stext-102 cl6 size-206 inf">
                                       <strong>${product[0].sanPham.moTa}</strong>
                                    </span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- - -->
                    <div class="tab-pane fade" id="reviews" role="tabpanel">
                        <div class="row">
                            <div class="col-sm-10 col-md-8 col-lg-6 m-lr-auto">
                                <div class="p-b-30 m-lr-15-sm">
                                    <!-- Review -->
                                    <div class="flex-w flex-t p-b-68">
                                        <div class="wrap-pic-s size-109 bor0 of-hidden m-r-18 m-t-6">
                                            <img src="images/avatar-01.jpg" alt="AVATAR">
                                        </div>

                                        <div class="size-207">
                                            <div class="flex-w flex-sb-m p-b-17">
													<span class="mtext-107 cl2 p-r-20">
														Ariana Grande
													</span>

                                                <span class="fs-18 cl11">
														<i class="zmdi zmdi-star"></i>
														<i class="zmdi zmdi-star"></i>
														<i class="zmdi zmdi-star"></i>
														<i class="zmdi zmdi-star"></i>
														<i class="zmdi zmdi-star-half"></i>
													</span>
                                            </div>

                                            <p class="stext-102 cl6">
                                                Quod autem in homine praestantissimum atque optimum est, id deseruit.
                                                Apud ceteros autem philosophos
                                            </p>
                                        </div>
                                    </div>

                                    <!-- Add review -->
                                    <form class="w-full">
                                        <h5 class="mtext-108 cl2 p-b-7">
                                            Add a review
                                        </h5>

                                        <p class="stext-102 cl6">
                                            Your email address will not be published. Required fields are marked *
                                        </p>

                                        <div class="flex-w flex-m p-t-50 p-b-23">
												<span class="stext-102 cl3 m-r-16">
													Your Rating
												</span>

                                            <span class="wrap-rating fs-18 cl11 pointer">
													<i class="item-rating pointer zmdi zmdi-star-outline"></i>
													<i class="item-rating pointer zmdi zmdi-star-outline"></i>
													<i class="item-rating pointer zmdi zmdi-star-outline"></i>
													<i class="item-rating pointer zmdi zmdi-star-outline"></i>
													<i class="item-rating pointer zmdi zmdi-star-outline"></i>
													<input class="dis-none" type="number" name="rating">
												</span>
                                        </div>

                                        <div class="row p-b-25">
                                            <div class="col-12 p-b-5">
                                                <label class="stext-102 cl3" for="review">Your review</label>
                                                <textarea class="size-110 bor8 stext-102 cl2 p-lr-20 p-tb-10"
                                                          id="review" name="review"></textarea>
                                            </div>

                                            <div class="col-sm-6 p-b-5">
                                                <label class="stext-102 cl3" for="name">Name</label>
                                                <input class="size-111 bor8 stext-102 cl2 p-lr-20" id="name" type="text"
                                                       name="name">
                                            </div>

                                            <div class="col-sm-6 p-b-5">
                                                <label class="stext-102 cl3" for="email">Email</label>
                                                <input class="size-111 bor8 stext-102 cl2 p-lr-20" id="email"
                                                       type="text" name="email">
                                            </div>
                                        </div>

                                        <button class="flex-c-m stext-101 cl0 size-112 bg7 bor11 hov-btn3 p-lr-15 trans-04 m-b-10">
                                            Submit
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--    <div class="bg6 flex-c-m flex-w size-302 m-t-73 p-tb-15">--%>
    <%--        <span class="stext-107 cl6 p-lr-25">--%>
    <%--				Thể loại:  ${product[0].sanPham.danhMuc.tenDanhMuc}--%>
    <%--			</span>--%>
    <%--    </div>--%>
</section>

<script>
    $(document).ready(function () {
        var selectedId = $('#select-id-color').val();

        // Lấy giá trị ID từ thuộc tính data-product-id của option tương ứng
        var selectedOption = $('#select-id-color option[value="' + selectedId + '"]');
        var defaultProductId = selectedOption.attr('data-product-id');

        soLuongMuaDetail(defaultProductId);
    });


    $('.js-addcart-detail-customer').on('click', function () {
        var idKhachHang = document.getElementById("id-khach-hang").value;
        var selectedIdValue = document.getElementById('select-id-color').value;
        var quantityProduct = 0;
        quantityProduct = parseInt(document.getElementById('quantity-product-add-to-cart').value);
        var isValid;

        if (idKhachHang == "") {
            Swal.fire({
                title: "Đăng nhập để thêm sản phẩm vào giỏ hàng",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Đăng nhập",
                cancelButtonText: "Đóng",
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "/sixdo-shop/login-customer";
                }
            });
        }

        if (quantityProduct === 0) {
            Swal.fire(
                'Error',
                'So Luong Phai Lon Hon 0.',
                'error'
            );
            return isValid = false;
        }
        if (quantityProduct < 0) {
            Swal.fire(
                'Eror',
                'So Luong khong duoc am.',
                'error'
            );
            return isValid = false;
        }
        if (isValid != false) {
            $.ajax({
                url: '/sixdo-shop/check-soLuong',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    idKhachHang: idKhachHang,
                    idChiTietSanPham: selectedIdValue,
                    soLuong: quantityProduct
                }),
                success: function (response) {
                    if (response === "ok") {
                        $.ajax({
                            url: '/sixdo-shop/add-to-cart-buyer',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify({
                                idKhachHang: idKhachHang,
                                idChiTietSanPham: selectedIdValue,
                                soLuong: quantityProduct
                            }),
                            success: function (response) {
                                if (response === "ok") {
                                    const count = document.querySelector('.icon-count-cart');
                                    count.setAttribute('data-notify', response);
                                    Swal.fire({
                                        title: 'Đã thêm!',
                                        text: 'Sản phẩm đã được thêm vô giỏ hàng!.',
                                        icon: 'success',
                                        timer: 1200,
                                        showConfirmButton: false
                                    })
                                    capNhapSoLuongSanPhamTrongGioHangHearder();
                                } else if (response === "loiTrangThai") {
                                    Swal.fire(
                                        'Error!',
                                        'San pham khong ton tai.',
                                        'error'
                                    );
                                }
                            },
                            error: function (error) {
                                console.error(error);
                            }
                        });
                    } else {
                        Swal.fire(
                            'Lỗi!',
                            'Số lượng sản phẩm không đủ ',
                            'error'
                        );
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        }


    });

    function soLuongMuaDetail(idCTsp) {
        $.ajax({
            type: 'GET',
            url: '/load-du-lieu/so-luong-mua',
            data: {id: idCTsp},
            success: function (soLuongMua) {
                if (soLuongMua > 0) {
                    document.getElementById('so-luong-ban-ra').innerText = soLuongMua;
                } else {
                    document.getElementById('so-luong-ban-ra').innerText = 0;
                }
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    }
</script>


</body>
</html>