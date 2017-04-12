; RUN: opt -S -instcombine %s -o - | FileCheck %s

%Complex = type { double, double }

; Check that instcombine preserves TBAA when narrowing loads
define double @test(%Complex *%val) {
; CHECK: load double, {{.*}}, !tbaa
; CHECK-NOT: load %Complex
    %loaded = load %Complex, %Complex *%val, !tbaa !1
    %real = extractvalue %Complex %loaded, 0
    ret double %real
}

!0 = !{!"tbaa_root"}
!1 = !{!2, !2, i64 0}
!2 = !{!"Complex", !0, i64 0}
