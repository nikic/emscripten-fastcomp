; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -fast-isel -mtriple=i386-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=ALL --check-prefix=X32
; RUN: llc < %s -fast-isel -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=ALL --check-prefix=X64

; NOTE: This should use IR equivalent to what is generated by clang/test/CodeGen/sse41-builtins.c

define <2 x i64> @test_mm_blend_epi16(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_blend_epi16:
; X32:       # %bb.0:
; X32-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1],xmm0[2],xmm1[3],xmm0[4],xmm1[5],xmm0[6,7]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_blend_epi16:
; X64:       # %bb.0:
; X64-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1],xmm0[2],xmm1[3],xmm0[4],xmm1[5],xmm0[6,7]
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %arg1 = bitcast <2 x i64> %a1 to <8 x i16>
  %shuf = shufflevector <8 x i16> %arg0, <8 x i16> %arg1, <8 x i32> <i32 0, i32 9, i32 2, i32 11, i32 4, i32 13, i32 6, i32 7>
  %res = bitcast <8 x i16> %shuf to <2 x i64>
  ret <2 x i64> %res
}

define <2 x double> @test_mm_blend_pd(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: test_mm_blend_pd:
; X32:       # %bb.0:
; X32-NEXT:    blendpd {{.*#+}} xmm0 = xmm0[0],xmm1[1]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_blend_pd:
; X64:       # %bb.0:
; X64-NEXT:    blendpd {{.*#+}} xmm0 = xmm0[0],xmm1[1]
; X64-NEXT:    retq
  %res = shufflevector <2 x double> %a0, <2 x double> %a1, <2 x i32> <i32 0, i32 3>
  ret <2 x double> %res
}

define <4 x float> @test_mm_blend_ps(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: test_mm_blend_ps:
; X32:       # %bb.0:
; X32-NEXT:    blendps {{.*#+}} xmm0 = xmm0[0],xmm1[1,2],xmm0[3]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_blend_ps:
; X64:       # %bb.0:
; X64-NEXT:    blendps {{.*#+}} xmm0 = xmm0[0],xmm1[1,2],xmm0[3]
; X64-NEXT:    retq
  %res = shufflevector <4 x float> %a0, <4 x float> %a1, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
  ret <4 x float> %res
}

define <2 x i64> @test_mm_blendv_epi8(<2 x i64> %a0, <2 x i64> %a1, <2 x i64> %a2) {
; X32-LABEL: test_mm_blendv_epi8:
; X32:       # %bb.0:
; X32-NEXT:    movdqa %xmm0, %xmm3
; X32-NEXT:    movaps %xmm2, %xmm0
; X32-NEXT:    pblendvb %xmm0, %xmm1, %xmm3
; X32-NEXT:    movdqa %xmm3, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_blendv_epi8:
; X64:       # %bb.0:
; X64-NEXT:    movdqa %xmm0, %xmm3
; X64-NEXT:    movaps %xmm2, %xmm0
; X64-NEXT:    pblendvb %xmm0, %xmm1, %xmm3
; X64-NEXT:    movdqa %xmm3, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %arg1 = bitcast <2 x i64> %a1 to <16 x i8>
  %arg2 = bitcast <2 x i64> %a2 to <16 x i8>
  %call = call <16 x i8> @llvm.x86.sse41.pblendvb(<16 x i8> %arg0, <16 x i8> %arg1, <16 x i8> %arg2)
  %res = bitcast <16 x i8> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <16 x i8> @llvm.x86.sse41.pblendvb(<16 x i8>, <16 x i8>, <16 x i8>) nounwind readnone

define <2 x double> @test_mm_blendv_pd(<2 x double> %a0, <2 x double> %a1, <2 x double> %a2) {
; X32-LABEL: test_mm_blendv_pd:
; X32:       # %bb.0:
; X32-NEXT:    movapd %xmm0, %xmm3
; X32-NEXT:    movaps %xmm2, %xmm0
; X32-NEXT:    blendvpd %xmm0, %xmm1, %xmm3
; X32-NEXT:    movapd %xmm3, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_blendv_pd:
; X64:       # %bb.0:
; X64-NEXT:    movapd %xmm0, %xmm3
; X64-NEXT:    movaps %xmm2, %xmm0
; X64-NEXT:    blendvpd %xmm0, %xmm1, %xmm3
; X64-NEXT:    movapd %xmm3, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse41.blendvpd(<2 x double> %a0, <2 x double> %a1, <2 x double> %a2)
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.blendvpd(<2 x double>, <2 x double>, <2 x double>) nounwind readnone

define <4 x float> @test_mm_blendv_ps(<4 x float> %a0, <4 x float> %a1, <4 x float> %a2) {
; X32-LABEL: test_mm_blendv_ps:
; X32:       # %bb.0:
; X32-NEXT:    movaps %xmm0, %xmm3
; X32-NEXT:    movaps %xmm2, %xmm0
; X32-NEXT:    blendvps %xmm0, %xmm1, %xmm3
; X32-NEXT:    movaps %xmm3, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_blendv_ps:
; X64:       # %bb.0:
; X64-NEXT:    movaps %xmm0, %xmm3
; X64-NEXT:    movaps %xmm2, %xmm0
; X64-NEXT:    blendvps %xmm0, %xmm1, %xmm3
; X64-NEXT:    movaps %xmm3, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse41.blendvps(<4 x float> %a0, <4 x float> %a1, <4 x float> %a2)
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.blendvps(<4 x float>, <4 x float>, <4 x float>) nounwind readnone

define <2 x double> @test_mm_ceil_pd(<2 x double> %a0) {
; X32-LABEL: test_mm_ceil_pd:
; X32:       # %bb.0:
; X32-NEXT:    roundpd $2, %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_ceil_pd:
; X64:       # %bb.0:
; X64-NEXT:    roundpd $2, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse41.round.pd(<2 x double> %a0, i32 2)
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.round.pd(<2 x double>, i32) nounwind readnone

define <4 x float> @test_mm_ceil_ps(<4 x float> %a0) {
; X32-LABEL: test_mm_ceil_ps:
; X32:       # %bb.0:
; X32-NEXT:    roundps $2, %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_ceil_ps:
; X64:       # %bb.0:
; X64-NEXT:    roundps $2, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse41.round.ps(<4 x float> %a0, i32 2)
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.round.ps(<4 x float>, i32) nounwind readnone

define <2 x double> @test_mm_ceil_sd(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: test_mm_ceil_sd:
; X32:       # %bb.0:
; X32-NEXT:    roundsd $2, %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_ceil_sd:
; X64:       # %bb.0:
; X64-NEXT:    roundsd $2, %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> %a0, <2 x double> %a1, i32 2)
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.round.sd(<2 x double>, <2 x double>, i32) nounwind readnone

define <4 x float> @test_mm_ceil_ss(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: test_mm_ceil_ss:
; X32:       # %bb.0:
; X32-NEXT:    roundss $2, %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_ceil_ss:
; X64:       # %bb.0:
; X64-NEXT:    roundss $2, %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> %a0, <4 x float> %a1, i32 2)
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.round.ss(<4 x float>, <4 x float>, i32) nounwind readnone

define <2 x i64> @test_mm_cmpeq_epi64(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_cmpeq_epi64:
; X32:       # %bb.0:
; X32-NEXT:    pcmpeqq %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cmpeq_epi64:
; X64:       # %bb.0:
; X64-NEXT:    pcmpeqq %xmm1, %xmm0
; X64-NEXT:    retq
  %cmp = icmp eq <2 x i64> %a0, %a1
  %res = sext <2 x i1> %cmp to <2 x i64>
  ret <2 x i64> %res
}

define <2 x i64> @test_mm_cvtepi8_epi16(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepi8_epi16:
; X32:       # %bb.0:
; X32-NEXT:    pmovsxbw %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepi8_epi16:
; X64:       # %bb.0:
; X64-NEXT:    pmovsxbw %xmm0, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %ext0 = shufflevector <16 x i8> %arg0, <16 x i8> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %sext = sext <8 x i8> %ext0 to <8 x i16>
  %res = bitcast <8 x i16> %sext to <2 x i64>
  ret <2 x i64> %res
}

define <2 x i64> @test_mm_cvtepi8_epi32(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepi8_epi32:
; X32:       # %bb.0:
; X32-NEXT:    pmovsxbd %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepi8_epi32:
; X64:       # %bb.0:
; X64-NEXT:    pmovsxbd %xmm0, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %ext0 = shufflevector <16 x i8> %arg0, <16 x i8> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %sext = sext <4 x i8> %ext0 to <4 x i32>
  %res = bitcast <4 x i32> %sext to <2 x i64>
  ret <2 x i64> %res
}

define <2 x i64> @test_mm_cvtepi8_epi64(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepi8_epi64:
; X32:       # %bb.0:
; X32-NEXT:    pmovsxbq %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepi8_epi64:
; X64:       # %bb.0:
; X64-NEXT:    pmovsxbq %xmm0, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %ext0 = shufflevector <16 x i8> %arg0, <16 x i8> undef, <2 x i32> <i32 0, i32 1>
  %sext = sext <2 x i8> %ext0 to <2 x i64>
  ret <2 x i64> %sext
}

define <2 x i64> @test_mm_cvtepi16_epi32(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepi16_epi32:
; X32:       # %bb.0:
; X32-NEXT:    pmovsxwd %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepi16_epi32:
; X64:       # %bb.0:
; X64-NEXT:    pmovsxwd %xmm0, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %ext0 = shufflevector <8 x i16> %arg0, <8 x i16> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %sext = sext <4 x i16> %ext0 to <4 x i32>
  %res = bitcast <4 x i32> %sext to <2 x i64>
  ret <2 x i64> %res
}

define <2 x i64> @test_mm_cvtepi16_epi64(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepi16_epi64:
; X32:       # %bb.0:
; X32-NEXT:    pmovsxwq %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepi16_epi64:
; X64:       # %bb.0:
; X64-NEXT:    pmovsxwq %xmm0, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %ext0 = shufflevector <8 x i16> %arg0, <8 x i16> undef, <2 x i32> <i32 0, i32 1>
  %sext = sext <2 x i16> %ext0 to <2 x i64>
  ret <2 x i64> %sext
}

define <2 x i64> @test_mm_cvtepi32_epi64(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepi32_epi64:
; X32:       # %bb.0:
; X32-NEXT:    pmovsxdq %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepi32_epi64:
; X64:       # %bb.0:
; X64-NEXT:    pmovsxdq %xmm0, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %ext0 = shufflevector <4 x i32> %arg0, <4 x i32> undef, <2 x i32> <i32 0, i32 1>
  %sext = sext <2 x i32> %ext0 to <2 x i64>
  ret <2 x i64> %sext
}

define <2 x i64> @test_mm_cvtepu8_epi16(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepu8_epi16:
; X32:       # %bb.0:
; X32-NEXT:    pmovzxbw {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepu8_epi16:
; X64:       # %bb.0:
; X64-NEXT:    pmovzxbw {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %ext0 = shufflevector <16 x i8> %arg0, <16 x i8> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %sext = zext <8 x i8> %ext0 to <8 x i16>
  %res = bitcast <8 x i16> %sext to <2 x i64>
  ret <2 x i64> %res
}

define <2 x i64> @test_mm_cvtepu8_epi32(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepu8_epi32:
; X32:       # %bb.0:
; X32-NEXT:    pmovzxbd {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepu8_epi32:
; X64:       # %bb.0:
; X64-NEXT:    pmovzxbd {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %ext0 = shufflevector <16 x i8> %arg0, <16 x i8> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %sext = zext <4 x i8> %ext0 to <4 x i32>
  %res = bitcast <4 x i32> %sext to <2 x i64>
  ret <2 x i64> %res
}

define <2 x i64> @test_mm_cvtepu8_epi64(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepu8_epi64:
; X32:       # %bb.0:
; X32-NEXT:    pmovzxbq {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepu8_epi64:
; X64:       # %bb.0:
; X64-NEXT:    pmovzxbq {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %ext0 = shufflevector <16 x i8> %arg0, <16 x i8> undef, <2 x i32> <i32 0, i32 1>
  %sext = zext <2 x i8> %ext0 to <2 x i64>
  ret <2 x i64> %sext
}

define <2 x i64> @test_mm_cvtepu16_epi32(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepu16_epi32:
; X32:       # %bb.0:
; X32-NEXT:    pmovzxwd {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepu16_epi32:
; X64:       # %bb.0:
; X64-NEXT:    pmovzxwd {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %ext0 = shufflevector <8 x i16> %arg0, <8 x i16> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %sext = zext <4 x i16> %ext0 to <4 x i32>
  %res = bitcast <4 x i32> %sext to <2 x i64>
  ret <2 x i64> %res
}

define <2 x i64> @test_mm_cvtepu16_epi64(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepu16_epi64:
; X32:       # %bb.0:
; X32-NEXT:    pmovzxwq {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepu16_epi64:
; X64:       # %bb.0:
; X64-NEXT:    pmovzxwq {{.*#+}} xmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %ext0 = shufflevector <8 x i16> %arg0, <8 x i16> undef, <2 x i32> <i32 0, i32 1>
  %sext = zext <2 x i16> %ext0 to <2 x i64>
  ret <2 x i64> %sext
}

define <2 x i64> @test_mm_cvtepu32_epi64(<2 x i64> %a0) {
; X32-LABEL: test_mm_cvtepu32_epi64:
; X32:       # %bb.0:
; X32-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_cvtepu32_epi64:
; X64:       # %bb.0:
; X64-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %ext0 = shufflevector <4 x i32> %arg0, <4 x i32> undef, <2 x i32> <i32 0, i32 1>
  %sext = zext <2 x i32> %ext0 to <2 x i64>
  ret <2 x i64> %sext
}

define <2 x double> @test_mm_dp_pd(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: test_mm_dp_pd:
; X32:       # %bb.0:
; X32-NEXT:    dppd $7, %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_dp_pd:
; X64:       # %bb.0:
; X64-NEXT:    dppd $7, %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse41.dppd(<2 x double> %a0, <2 x double> %a1, i8 7)
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse41.dppd(<2 x double>, <2 x double>, i8) nounwind readnone

define <4 x float> @test_mm_dp_ps(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: test_mm_dp_ps:
; X32:       # %bb.0:
; X32-NEXT:    dpps $7, %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_dp_ps:
; X64:       # %bb.0:
; X64-NEXT:    dpps $7, %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse41.dpps(<4 x float> %a0, <4 x float> %a1, i8 7)
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.dpps(<4 x float>, <4 x float>, i8) nounwind readnone

define i32 @test_mm_extract_epi8(<2 x i64> %a0) {
; X32-LABEL: test_mm_extract_epi8:
; X32:       # %bb.0:
; X32-NEXT:    pextrb $1, %xmm0, %eax
; X32-NEXT:    movzbl %al, %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_extract_epi8:
; X64:       # %bb.0:
; X64-NEXT:    pextrb $1, %xmm0, %eax
; X64-NEXT:    movzbl %al, %eax
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %ext = extractelement <16 x i8> %arg0, i32 1
  %res = zext i8 %ext to i32
  ret i32 %res
}

define i32 @test_mm_extract_epi32(<2 x i64> %a0) {
; X32-LABEL: test_mm_extract_epi32:
; X32:       # %bb.0:
; X32-NEXT:    extractps $1, %xmm0, %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_extract_epi32:
; X64:       # %bb.0:
; X64-NEXT:    extractps $1, %xmm0, %eax
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %ext = extractelement <4 x i32> %arg0, i32 1
  ret i32 %ext
}

define i64 @test_mm_extract_epi64(<2 x i64> %a0) {
; X32-LABEL: test_mm_extract_epi64:
; X32:       # %bb.0:
; X32-NEXT:    extractps $2, %xmm0, %eax
; X32-NEXT:    extractps $3, %xmm0, %edx
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_extract_epi64:
; X64:       # %bb.0:
; X64-NEXT:    pextrq $1, %xmm0, %rax
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %ext = extractelement <2 x i64> %a0, i32 1
  ret i64 %ext
}

define i32 @test_mm_extract_ps(<4 x float> %a0) {
; X32-LABEL: test_mm_extract_ps:
; X32:       # %bb.0:
; X32-NEXT:    movshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; X32-NEXT:    movd %xmm0, %eax
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_extract_ps:
; X64:       # %bb.0:
; X64-NEXT:    movshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; X64-NEXT:    movd %xmm0, %eax
; X64-NEXT:    retq
  %ext = extractelement <4 x float> %a0, i32 1
  %bc = bitcast float %ext to i32
  ret i32 %bc
}

define <2 x double> @test_mm_floor_pd(<2 x double> %a0) {
; X32-LABEL: test_mm_floor_pd:
; X32:       # %bb.0:
; X32-NEXT:    roundpd $1, %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_floor_pd:
; X64:       # %bb.0:
; X64-NEXT:    roundpd $1, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse41.round.pd(<2 x double> %a0, i32 1)
  ret <2 x double> %res
}

define <4 x float> @test_mm_floor_ps(<4 x float> %a0) {
; X32-LABEL: test_mm_floor_ps:
; X32:       # %bb.0:
; X32-NEXT:    roundps $1, %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_floor_ps:
; X64:       # %bb.0:
; X64-NEXT:    roundps $1, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse41.round.ps(<4 x float> %a0, i32 1)
  ret <4 x float> %res
}

define <2 x double> @test_mm_floor_sd(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: test_mm_floor_sd:
; X32:       # %bb.0:
; X32-NEXT:    roundsd $1, %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_floor_sd:
; X64:       # %bb.0:
; X64-NEXT:    roundsd $1, %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> %a0, <2 x double> %a1, i32 1)
  ret <2 x double> %res
}

define <4 x float> @test_mm_floor_ss(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: test_mm_floor_ss:
; X32:       # %bb.0:
; X32-NEXT:    roundss $1, %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_floor_ss:
; X64:       # %bb.0:
; X64-NEXT:    roundss $1, %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> %a0, <4 x float> %a1, i32 1)
  ret <4 x float> %res
}

define <2 x i64> @test_mm_insert_epi8(<2 x i64> %a0, i8 %a1) {
; X32-LABEL: test_mm_insert_epi8:
; X32:       # %bb.0:
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    pinsrb $1, %eax, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_insert_epi8:
; X64:       # %bb.0:
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    pinsrb $1, %eax, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %res = insertelement <16 x i8> %arg0, i8 %a1,i32 1
  %bc = bitcast <16 x i8> %res to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_insert_epi32(<2 x i64> %a0, i32 %a1) {
; X32-LABEL: test_mm_insert_epi32:
; X32:       # %bb.0:
; X32-NEXT:    pinsrd $1, {{[0-9]+}}(%esp), %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_insert_epi32:
; X64:       # %bb.0:
; X64-NEXT:    pinsrd $1, %edi, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %res = insertelement <4 x i32> %arg0, i32 %a1,i32 1
  %bc = bitcast <4 x i32> %res to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_insert_epi64(<2 x i64> %a0, i64 %a1) {
; X32-LABEL: test_mm_insert_epi64:
; X32:       # %bb.0:
; X32-NEXT:    pinsrd $2, {{[0-9]+}}(%esp), %xmm0
; X32-NEXT:    pinsrd $3, {{[0-9]+}}(%esp), %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_insert_epi64:
; X64:       # %bb.0:
; X64-NEXT:    pinsrq $1, %rdi, %xmm0
; X64-NEXT:    retq
  %res = insertelement <2 x i64> %a0, i64 %a1,i32 1
  ret <2 x i64> %res
}

define <4 x float> @test_mm_insert_ps(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: test_mm_insert_ps:
; X32:       # %bb.0:
; X32-NEXT:    insertps {{.*#+}} xmm0 = xmm1[0],xmm0[1],zero,xmm0[3]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_insert_ps:
; X64:       # %bb.0:
; X64-NEXT:    insertps {{.*#+}} xmm0 = xmm1[0],xmm0[1],zero,xmm0[3]
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse41.insertps(<4 x float> %a0, <4 x float> %a1, i8 4)
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse41.insertps(<4 x float>, <4 x float>, i8) nounwind readnone

define <2 x i64> @test_mm_max_epi8(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_max_epi8:
; X32:       # %bb.0:
; X32-NEXT:    pmaxsb %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_max_epi8:
; X64:       # %bb.0:
; X64-NEXT:    pmaxsb %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %arg1 = bitcast <2 x i64> %a1 to <16 x i8>
  %cmp = icmp sgt <16 x i8> %arg0, %arg1
  %sel = select <16 x i1> %cmp, <16 x i8> %arg0, <16 x i8> %arg1
  %bc = bitcast <16 x i8> %sel to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_max_epi32(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_max_epi32:
; X32:       # %bb.0:
; X32-NEXT:    pmaxsd %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_max_epi32:
; X64:       # %bb.0:
; X64-NEXT:    pmaxsd %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %cmp = icmp sgt <4 x i32> %arg0, %arg1
  %sel = select <4 x i1> %cmp, <4 x i32> %arg0, <4 x i32> %arg1
  %bc = bitcast <4 x i32> %sel to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_max_epu16(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_max_epu16:
; X32:       # %bb.0:
; X32-NEXT:    pmaxuw %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_max_epu16:
; X64:       # %bb.0:
; X64-NEXT:    pmaxuw %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %arg1 = bitcast <2 x i64> %a1 to <8 x i16>
  %cmp = icmp ugt <8 x i16> %arg0, %arg1
  %sel = select <8 x i1> %cmp, <8 x i16> %arg0, <8 x i16> %arg1
  %bc = bitcast <8 x i16> %sel to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_max_epu32(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_max_epu32:
; X32:       # %bb.0:
; X32-NEXT:    pmaxud %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_max_epu32:
; X64:       # %bb.0:
; X64-NEXT:    pmaxud %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %cmp = icmp ugt <4 x i32> %arg0, %arg1
  %sel = select <4 x i1> %cmp, <4 x i32> %arg0, <4 x i32> %arg1
  %bc = bitcast <4 x i32> %sel to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_min_epi8(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_min_epi8:
; X32:       # %bb.0:
; X32-NEXT:    pminsb %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_min_epi8:
; X64:       # %bb.0:
; X64-NEXT:    pminsb %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %arg1 = bitcast <2 x i64> %a1 to <16 x i8>
  %cmp = icmp slt <16 x i8> %arg0, %arg1
  %sel = select <16 x i1> %cmp, <16 x i8> %arg0, <16 x i8> %arg1
  %bc = bitcast <16 x i8> %sel to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_min_epi32(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_min_epi32:
; X32:       # %bb.0:
; X32-NEXT:    pminsd %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_min_epi32:
; X64:       # %bb.0:
; X64-NEXT:    pminsd %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %cmp = icmp slt <4 x i32> %arg0, %arg1
  %sel = select <4 x i1> %cmp, <4 x i32> %arg0, <4 x i32> %arg1
  %bc = bitcast <4 x i32> %sel to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_min_epu16(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_min_epu16:
; X32:       # %bb.0:
; X32-NEXT:    pminuw %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_min_epu16:
; X64:       # %bb.0:
; X64-NEXT:    pminuw %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %arg1 = bitcast <2 x i64> %a1 to <8 x i16>
  %cmp = icmp ult <8 x i16> %arg0, %arg1
  %sel = select <8 x i1> %cmp, <8 x i16> %arg0, <8 x i16> %arg1
  %bc = bitcast <8 x i16> %sel to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_min_epu32(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_min_epu32:
; X32:       # %bb.0:
; X32-NEXT:    pminud %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_min_epu32:
; X64:       # %bb.0:
; X64-NEXT:    pminud %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %cmp = icmp ult <4 x i32> %arg0, %arg1
  %sel = select <4 x i1> %cmp, <4 x i32> %arg0, <4 x i32> %arg1
  %bc = bitcast <4 x i32> %sel to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_minpos_epu16(<2 x i64> %a0) {
; X32-LABEL: test_mm_minpos_epu16:
; X32:       # %bb.0:
; X32-NEXT:    phminposuw %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_minpos_epu16:
; X64:       # %bb.0:
; X64-NEXT:    phminposuw %xmm0, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <8 x i16>
  %res = call <8 x i16> @llvm.x86.sse41.phminposuw(<8 x i16> %arg0)
  %bc = bitcast <8 x i16> %res to <2 x i64>
  ret <2 x i64> %bc
}
declare <8 x i16> @llvm.x86.sse41.phminposuw(<8 x i16>) nounwind readnone

define <2 x i64> @test_mm_mpsadbw_epu8(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_mpsadbw_epu8:
; X32:       # %bb.0:
; X32-NEXT:    mpsadbw $1, %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_mpsadbw_epu8:
; X64:       # %bb.0:
; X64-NEXT:    mpsadbw $1, %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <16 x i8>
  %arg1 = bitcast <2 x i64> %a1 to <16 x i8>
  %res = call <8 x i16> @llvm.x86.sse41.mpsadbw(<16 x i8> %arg0, <16 x i8> %arg1, i8 1)
  %bc = bitcast <8 x i16> %res to <2 x i64>
  ret <2 x i64> %bc
}
declare <8 x i16> @llvm.x86.sse41.mpsadbw(<16 x i8>, <16 x i8>, i8) nounwind readnone

define <2 x i64> @test_mm_mul_epi32(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_mul_epi32:
; X32:       # %bb.0:
; X32-NEXT:    pmuldq %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_mul_epi32:
; X64:       # %bb.0:
; X64-NEXT:    pmuldq %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %res = call <2 x i64> @llvm.x86.sse41.pmuldq(<4 x i32> %arg0, <4 x i32> %arg1)
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.pmuldq(<4 x i32>, <4 x i32>) nounwind readnone

define <2 x i64> @test_mm_mullo_epi32(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_mullo_epi32:
; X32:       # %bb.0:
; X32-NEXT:    pmulld %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_mullo_epi32:
; X64:       # %bb.0:
; X64-NEXT:    pmulld %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %res = mul <4 x i32> %arg0, %arg1
  %bc = bitcast <4 x i32> %res to <2 x i64>
  ret <2 x i64> %bc
}

define <2 x i64> @test_mm_packus_epi32(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_packus_epi32:
; X32:       # %bb.0:
; X32-NEXT:    packusdw %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_packus_epi32:
; X64:       # %bb.0:
; X64-NEXT:    packusdw %xmm1, %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64> %a0 to <4 x i32>
  %arg1 = bitcast <2 x i64> %a1 to <4 x i32>
  %res = call <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32> %arg0, <4 x i32> %arg1)
  %bc = bitcast <8 x i16> %res to <2 x i64>
  ret <2 x i64> %bc
}
declare <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32>, <4 x i32>) nounwind readnone

define <2 x double> @test_mm_round_pd(<2 x double> %a0) {
; X32-LABEL: test_mm_round_pd:
; X32:       # %bb.0:
; X32-NEXT:    roundpd $4, %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_round_pd:
; X64:       # %bb.0:
; X64-NEXT:    roundpd $4, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse41.round.pd(<2 x double> %a0, i32 4)
  ret <2 x double> %res
}

define <4 x float> @test_mm_round_ps(<4 x float> %a0) {
; X32-LABEL: test_mm_round_ps:
; X32:       # %bb.0:
; X32-NEXT:    roundps $4, %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_round_ps:
; X64:       # %bb.0:
; X64-NEXT:    roundps $4, %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse41.round.ps(<4 x float> %a0, i32 4)
  ret <4 x float> %res
}

define <2 x double> @test_mm_round_sd(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: test_mm_round_sd:
; X32:       # %bb.0:
; X32-NEXT:    roundsd $4, %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_round_sd:
; X64:       # %bb.0:
; X64-NEXT:    roundsd $4, %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse41.round.sd(<2 x double> %a0, <2 x double> %a1, i32 4)
  ret <2 x double> %res
}

define <4 x float> @test_mm_round_ss(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: test_mm_round_ss:
; X32:       # %bb.0:
; X32-NEXT:    roundss $4, %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_round_ss:
; X64:       # %bb.0:
; X64-NEXT:    roundss $4, %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse41.round.ss(<4 x float> %a0, <4 x float> %a1, i32 4)
  ret <4 x float> %res
}

define <2 x i64> @test_mm_stream_load_si128(<2 x i64>* %a0) {
; X32-LABEL: test_mm_stream_load_si128:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movntdqa (%eax), %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_stream_load_si128:
; X64:       # %bb.0:
; X64-NEXT:    movntdqa (%rdi), %xmm0
; X64-NEXT:    retq
  %arg0 = bitcast <2 x i64>* %a0 to i8*
  %res = call <2 x i64> @llvm.x86.sse41.movntdqa(i8* %arg0)
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.sse41.movntdqa(i8*) nounwind readnone

define i32 @test_mm_test_all_ones(<2 x i64> %a0) {
; X32-LABEL: test_mm_test_all_ones:
; X32:       # %bb.0:
; X32-NEXT:    pcmpeqd %xmm1, %xmm1
; X32-NEXT:    xorl %eax, %eax
; X32-NEXT:    ptest %xmm1, %xmm0
; X32-NEXT:    setb %al
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_test_all_ones:
; X64:       # %bb.0:
; X64-NEXT:    pcmpeqd %xmm1, %xmm1
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    ptest %xmm1, %xmm0
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %res = call i32 @llvm.x86.sse41.ptestc(<2 x i64> %a0, <2 x i64> <i64 -1, i64 -1>)
  ret i32 %res
}
declare i32 @llvm.x86.sse41.ptestc(<2 x i64>, <2 x i64>) nounwind readnone

define i32 @test_mm_test_all_zeros(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_test_all_zeros:
; X32:       # %bb.0:
; X32-NEXT:    xorl %eax, %eax
; X32-NEXT:    ptest %xmm1, %xmm0
; X32-NEXT:    sete %al
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_test_all_zeros:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    ptest %xmm1, %xmm0
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %res = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %a0, <2 x i64> %a1)
  ret i32 %res
}
declare i32 @llvm.x86.sse41.ptestz(<2 x i64>, <2 x i64>) nounwind readnone

define i32 @test_mm_test_mix_ones_zeros(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_test_mix_ones_zeros:
; X32:       # %bb.0:
; X32-NEXT:    xorl %eax, %eax
; X32-NEXT:    ptest %xmm1, %xmm0
; X32-NEXT:    seta %al
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_test_mix_ones_zeros:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    ptest %xmm1, %xmm0
; X64-NEXT:    seta %al
; X64-NEXT:    retq
  %res = call i32 @llvm.x86.sse41.ptestnzc(<2 x i64> %a0, <2 x i64> %a1)
  ret i32 %res
}
declare i32 @llvm.x86.sse41.ptestnzc(<2 x i64>, <2 x i64>) nounwind readnone

define i32 @test_mm_testc_si128(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_testc_si128:
; X32:       # %bb.0:
; X32-NEXT:    xorl %eax, %eax
; X32-NEXT:    ptest %xmm1, %xmm0
; X32-NEXT:    setb %al
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_testc_si128:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    ptest %xmm1, %xmm0
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %res = call i32 @llvm.x86.sse41.ptestc(<2 x i64> %a0, <2 x i64> %a1)
  ret i32 %res
}

define i32 @test_mm_testnzc_si128(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_testnzc_si128:
; X32:       # %bb.0:
; X32-NEXT:    xorl %eax, %eax
; X32-NEXT:    ptest %xmm1, %xmm0
; X32-NEXT:    seta %al
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_testnzc_si128:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    ptest %xmm1, %xmm0
; X64-NEXT:    seta %al
; X64-NEXT:    retq
  %res = call i32 @llvm.x86.sse41.ptestnzc(<2 x i64> %a0, <2 x i64> %a1)
  ret i32 %res
}

define i32 @test_mm_testz_si128(<2 x i64> %a0, <2 x i64> %a1) {
; X32-LABEL: test_mm_testz_si128:
; X32:       # %bb.0:
; X32-NEXT:    xorl %eax, %eax
; X32-NEXT:    ptest %xmm1, %xmm0
; X32-NEXT:    sete %al
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_testz_si128:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    ptest %xmm1, %xmm0
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %res = call i32 @llvm.x86.sse41.ptestz(<2 x i64> %a0, <2 x i64> %a1)
  ret i32 %res
}
