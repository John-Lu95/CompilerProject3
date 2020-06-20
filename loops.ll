; ModuleID = 'loops.bc'
source_filename = "loops.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@y = common dso_local local_unnamed_addr global [512 x i32] zeroinitializer, align 16
@x = common dso_local local_unnamed_addr global [512 x i32] zeroinitializer, align 16
@z = common dso_local local_unnamed_addr global [512 x i32] zeroinitializer, align 16
@b = common dso_local local_unnamed_addr global [512 x [512 x i32]] zeroinitializer, align 16
@a = common dso_local local_unnamed_addr global [512 x [512 x i32]] zeroinitializer, align 16
@c = common dso_local local_unnamed_addr global [512 x [512 x i32]] zeroinitializer, align 16
@B = common dso_local local_unnamed_addr global [512 x [512 x [512 x double]]] zeroinitializer, align 16
@C = common dso_local local_unnamed_addr global [512 x [512 x [512 x double]]] zeroinitializer, align 16
@A = common dso_local local_unnamed_addr global [512 x [512 x [512 x double]]] zeroinitializer, align 16

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test1() local_unnamed_addr #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [512 x i32], [512 x i32]* @y, i64 0, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !2
  %mul = shl nsw i32 %0, 1
  %arrayidx2 = getelementptr inbounds [512 x i32], [512 x i32]* @x, i64 0, i64 %indvars.iv
  store i32 %mul, i32* %arrayidx2, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 512
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test2() local_unnamed_addr #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = shl nuw i64 %indvars.iv, 1
  %arrayidx = getelementptr inbounds [512 x i32], [512 x i32]* @y, i64 0, i64 %0
  %1 = load i32, i32* %arrayidx, align 8, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %arrayidx2 = getelementptr inbounds [512 x i32], [512 x i32]* @x, i64 0, i64 %indvars.iv.next
  store i32 %1, i32* %arrayidx2, align 4, !tbaa !2
  %exitcond = icmp eq i64 %indvars.iv.next, 256
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test3() local_unnamed_addr #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ 1, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = shl nuw i64 %indvars.iv, 1
  %arrayidx = getelementptr inbounds [512 x i32], [512 x i32]* @y, i64 0, i64 %0
  %1 = load i32, i32* %arrayidx, align 8, !tbaa !2
  %2 = add nsw i64 %indvars.iv, -1
  %arrayidx2 = getelementptr inbounds [512 x i32], [512 x i32]* @x, i64 0, i64 %2
  store i32 %1, i32* %arrayidx2, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 2
  %cmp = icmp ult i64 %indvars.iv.next, 256
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test4() local_unnamed_addr #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = shl nuw i64 %indvars.iv, 1
  %1 = or i64 %0, 5
  %arrayidx = getelementptr inbounds [512 x i32], [512 x i32]* @y, i64 0, i64 %1
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !2
  %3 = mul nuw nsw i64 %indvars.iv, 3
  %arrayidx3 = getelementptr inbounds [512 x i32], [512 x i32]* @z, i64 0, i64 %3
  %4 = load i32, i32* %arrayidx3, align 16, !tbaa !2
  %add4 = add nsw i32 %4, %2
  %5 = shl i64 %indvars.iv, 2
  %arrayidx7 = getelementptr inbounds [512 x i32], [512 x i32]* @x, i64 0, i64 %5
  store i32 %add4, i32* %arrayidx7, align 16, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 4
  %cmp = icmp ult i64 %indvars.iv.next, 128
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test5() local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.inc10, %entry
  %indvars.iv22 = phi i64 [ 0, %entry ], [ %indvars.iv.next23, %for.inc10 ]
  br label %for.body3

for.body3:                                        ; preds = %for.body3, %for.cond1.preheader
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next, %for.body3 ]
  %arrayidx5 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @b, i64 0, i64 %indvars.iv22, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx5, align 4, !tbaa !2
  %mul = mul nsw i32 %0, 3
  %arrayidx9 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @a, i64 0, i64 %indvars.iv22, i64 %indvars.iv
  store i32 %mul, i32* %arrayidx9, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 512
  br i1 %exitcond, label %for.inc10, label %for.body3

for.inc10:                                        ; preds = %for.body3
  %indvars.iv.next23 = add nuw nsw i64 %indvars.iv22, 1
  %exitcond24 = icmp eq i64 %indvars.iv.next23, 512
  br i1 %exitcond24, label %for.end12, label %for.cond1.preheader

for.end12:                                        ; preds = %for.inc10
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test6() local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.inc15, %entry
  %indvars.iv31 = phi i64 [ 0, %entry ], [ %indvars.iv.next32, %for.inc15 ]
  %arrayidx9 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @c, i64 0, i64 %indvars.iv31, i64 %indvars.iv31
  %0 = load i32, i32* %arrayidx9, align 4, !tbaa !2
  %1 = shl nuw i64 %indvars.iv31, 1
  br label %for.body3

for.body3:                                        ; preds = %for.body3, %for.cond1.preheader
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next, %for.body3 ]
  %2 = add nuw nsw i64 %indvars.iv, %indvars.iv31
  %arrayidx5 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @b, i64 0, i64 %indvars.iv31, i64 %2
  %3 = load i32, i32* %arrayidx5, align 4, !tbaa !2
  %add10 = add nsw i32 %0, %3
  %arrayidx14 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @a, i64 0, i64 %1, i64 %indvars.iv
  store i32 %add10, i32* %arrayidx14, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 256
  br i1 %exitcond, label %for.inc15, label %for.body3

for.inc15:                                        ; preds = %for.body3
  %indvars.iv.next32 = add nuw nsw i64 %indvars.iv31, 1
  %exitcond34 = icmp eq i64 %indvars.iv.next32, 256
  br i1 %exitcond34, label %for.end17, label %for.cond1.preheader

for.end17:                                        ; preds = %for.inc15
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test7() local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %entry, %for.inc18
  %indvars.iv36 = phi i64 [ 0, %entry ], [ %indvars.iv.next37, %for.inc18 ]
  %0 = add nuw nsw i64 %indvars.iv36, 10
  %1 = shl nuw i64 %indvars.iv36, 1
  br label %for.body3

for.body3:                                        ; preds = %for.body3, %for.cond1.preheader
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next, %for.body3 ]
  %2 = shl nuw i64 %indvars.iv, 1
  %3 = add nuw nsw i64 %0, %2
  %arrayidx6 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @b, i64 0, i64 %indvars.iv36, i64 %3
  %4 = load i32, i32* %arrayidx6, align 8, !tbaa !2
  %5 = mul nuw nsw i64 %indvars.iv, 3
  %arrayidx11 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @c, i64 0, i64 %indvars.iv36, i64 %5
  %6 = load i32, i32* %arrayidx11, align 4, !tbaa !2
  %add12 = add nsw i32 %6, %4
  %arrayidx17 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @a, i64 0, i64 %1, i64 %indvars.iv
  store i32 %add12, i32* %arrayidx17, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 170
  br i1 %exitcond, label %for.inc18, label %for.body3

for.inc18:                                        ; preds = %for.body3
  %indvars.iv.next37 = add nuw nsw i64 %indvars.iv36, 2
  %cmp = icmp ult i64 %indvars.iv.next37, 256
  br i1 %cmp, label %for.cond1.preheader, label %for.end20

for.end20:                                        ; preds = %for.inc18
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test8() local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %entry, %for.inc15
  %indvars.iv30 = phi i64 [ 0, %entry ], [ %indvars.iv.next31, %for.inc15 ]
  br label %for.body3

for.body3:                                        ; preds = %for.cond1.preheader, %for.body3
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next, %for.body3 ]
  %arrayidx5 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @b, i64 0, i64 %indvars.iv, i64 %indvars.iv30
  %0 = load i32, i32* %arrayidx5, align 8, !tbaa !2
  %arrayidx9 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @c, i64 0, i64 %indvars.iv, i64 %indvars.iv
  %1 = load i32, i32* %arrayidx9, align 4, !tbaa !2
  %add = add nsw i32 %1, %0
  %arrayidx13 = getelementptr inbounds [512 x [512 x i32]], [512 x [512 x i32]]* @a, i64 0, i64 %indvars.iv30, i64 %indvars.iv
  store i32 %add, i32* %arrayidx13, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 3
  %cmp2 = icmp ult i64 %indvars.iv.next, 512
  br i1 %cmp2, label %for.body3, label %for.inc15

for.inc15:                                        ; preds = %for.body3
  %indvars.iv.next31 = add nuw nsw i64 %indvars.iv30, 2
  %cmp = icmp ult i64 %indvars.iv.next31, 512
  br i1 %cmp, label %for.cond1.preheader, label %for.end17

for.end17:                                        ; preds = %for.inc15
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test9() local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.inc29, %entry
  %indvars.iv55 = phi i64 [ 0, %entry ], [ %indvars.iv.next56, %for.inc29 ]
  %indvars.iv.next56 = add nuw nsw i64 %indvars.iv55, 1
  br label %for.cond4.preheader

for.cond4.preheader:                              ; preds = %for.inc26, %for.cond1.preheader
  %indvars.iv52 = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next53, %for.inc26 ]
  br label %for.body6

for.body6:                                        ; preds = %for.body6, %for.cond4.preheader
  %indvars.iv = phi i64 [ 0, %for.cond4.preheader ], [ %indvars.iv.next, %for.body6 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %arrayidx10 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @B, i64 0, i64 %indvars.iv55, i64 %indvars.iv52, i64 %indvars.iv.next
  %0 = load double, double* %arrayidx10, align 8, !tbaa !6
  %1 = shl nuw i64 %indvars.iv, 1
  %2 = or i64 %1, 1
  %arrayidx17 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @C, i64 0, i64 %indvars.iv55, i64 %indvars.iv52, i64 %2
  %3 = load double, double* %arrayidx17, align 8, !tbaa !6
  %add18 = fadd double %0, %3
  %arrayidx25 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @A, i64 0, i64 %indvars.iv.next56, i64 %indvars.iv52, i64 %indvars.iv
  store double %add18, double* %arrayidx25, align 8, !tbaa !6
  %exitcond = icmp eq i64 %indvars.iv.next, 255
  br i1 %exitcond, label %for.inc26, label %for.body6

for.inc26:                                        ; preds = %for.body6
  %indvars.iv.next53 = add nuw nsw i64 %indvars.iv52, 1
  %exitcond54 = icmp eq i64 %indvars.iv.next53, 512
  br i1 %exitcond54, label %for.inc29, label %for.cond4.preheader

for.inc29:                                        ; preds = %for.inc26
  %exitcond57 = icmp eq i64 %indvars.iv.next56, 511
  br i1 %exitcond57, label %for.end31, label %for.cond1.preheader

for.end31:                                        ; preds = %for.inc29
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test10() local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.inc28, %entry
  %indvars.iv54 = phi i64 [ 0, %entry ], [ %indvars.iv.next55, %for.inc28 ]
  br label %for.cond4.preheader

for.cond4.preheader:                              ; preds = %for.inc26, %for.cond1.preheader
  %indvars.iv52 = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next53, %for.inc26 ]
  br label %for.body6

for.body6:                                        ; preds = %for.cond4.preheader, %for.body6
  %indvars.iv = phi i64 [ 0, %for.cond4.preheader ], [ %indvars.iv.next, %for.body6 ]
  %0 = or i64 %indvars.iv, 1
  %arrayidx10 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @B, i64 0, i64 %indvars.iv, i64 %indvars.iv52, i64 %0
  %1 = load double, double* %arrayidx10, align 8, !tbaa !6
  %2 = shl nuw i64 %indvars.iv, 1
  %3 = or i64 %2, 1
  %arrayidx17 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @C, i64 0, i64 %indvars.iv54, i64 %indvars.iv52, i64 %3
  %4 = load double, double* %arrayidx17, align 8, !tbaa !6
  %add18 = fadd double %1, %4
  %arrayidx24 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @A, i64 0, i64 %indvars.iv54, i64 %indvars.iv52, i64 %indvars.iv
  store double %add18, double* %arrayidx24, align 16, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 2
  %cmp5 = icmp ult i64 %indvars.iv.next, 255
  br i1 %cmp5, label %for.body6, label %for.inc26

for.inc26:                                        ; preds = %for.body6
  %indvars.iv.next53 = add nuw nsw i64 %indvars.iv52, 1
  %exitcond = icmp eq i64 %indvars.iv.next53, 512
  br i1 %exitcond, label %for.inc28, label %for.cond4.preheader

for.inc28:                                        ; preds = %for.inc26
  %indvars.iv.next55 = add nuw nsw i64 %indvars.iv54, 1
  %exitcond56 = icmp eq i64 %indvars.iv.next55, 512
  br i1 %exitcond56, label %for.end30, label %for.cond1.preheader

for.end30:                                        ; preds = %for.inc28
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test11() local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.inc28, %entry
  %indvars.iv54 = phi i64 [ 0, %entry ], [ %indvars.iv.next55, %for.inc28 ]
  br label %for.cond4.preheader

for.cond4.preheader:                              ; preds = %for.inc26, %for.cond1.preheader
  %indvars.iv52 = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next53, %for.inc26 ]
  br label %for.body6

for.body6:                                        ; preds = %for.cond4.preheader, %for.body6
  %indvars.iv = phi i64 [ 0, %for.cond4.preheader ], [ %indvars.iv.next, %for.body6 ]
  %0 = or i64 %indvars.iv, 1
  %arrayidx10 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @B, i64 0, i64 %indvars.iv, i64 %indvars.iv52, i64 %0
  %1 = load double, double* %arrayidx10, align 8, !tbaa !6
  %2 = shl nuw i64 %indvars.iv, 1
  %3 = or i64 %2, 1
  %arrayidx17 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @C, i64 0, i64 %indvars.iv54, i64 %indvars.iv52, i64 %3
  %4 = load double, double* %arrayidx17, align 8, !tbaa !6
  %add18 = fadd double %1, %4
  %arrayidx24 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @A, i64 0, i64 %indvars.iv54, i64 %indvars.iv, i64 %indvars.iv52
  store double %add18, double* %arrayidx24, align 8, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 4
  %cmp5 = icmp ult i64 %indvars.iv.next, 256
  br i1 %cmp5, label %for.body6, label %for.inc26

for.inc26:                                        ; preds = %for.body6
  %indvars.iv.next53 = add nuw nsw i64 %indvars.iv52, 1
  %exitcond = icmp eq i64 %indvars.iv.next53, 512
  br i1 %exitcond, label %for.inc28, label %for.cond4.preheader

for.inc28:                                        ; preds = %for.inc26
  %indvars.iv.next55 = add nuw nsw i64 %indvars.iv54, 1
  %exitcond56 = icmp eq i64 %indvars.iv.next55, 512
  br i1 %exitcond56, label %for.end30, label %for.cond1.preheader

for.end30:                                        ; preds = %for.inc28
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define dso_local void @test12() local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.inc28, %entry
  %indvars.iv56 = phi i64 [ 0, %entry ], [ %indvars.iv.next57, %for.inc28 ]
  br label %for.cond4.preheader

for.cond4.preheader:                              ; preds = %for.inc25, %for.cond1.preheader
  %indvars.iv53 = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next54, %for.inc25 ]
  br label %for.body6

for.body6:                                        ; preds = %for.body6, %for.cond4.preheader
  %indvars.iv = phi i64 [ 0, %for.cond4.preheader ], [ %indvars.iv.next, %for.body6 ]
  %0 = mul nuw nsw i64 %indvars.iv, 5
  %arrayidx10 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @B, i64 0, i64 %indvars.iv56, i64 %indvars.iv53, i64 %0
  %1 = load double, double* %arrayidx10, align 8, !tbaa !6
  %2 = shl i64 %indvars.iv, 3
  %arrayidx17 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @C, i64 0, i64 %indvars.iv56, i64 %indvars.iv53, i64 %2
  %3 = load double, double* %arrayidx17, align 16, !tbaa !6
  %add = fadd double %1, %3
  %4 = add nuw nsw i64 %indvars.iv, %indvars.iv53
  %arrayidx24 = getelementptr inbounds [512 x [512 x [512 x double]]], [512 x [512 x [512 x double]]]* @A, i64 0, i64 %indvars.iv56, i64 %4, i64 %indvars.iv
  store double %add, double* %arrayidx24, align 8, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 64
  br i1 %exitcond, label %for.inc25, label %for.body6

for.inc25:                                        ; preds = %for.body6
  %indvars.iv.next54 = add nuw nsw i64 %indvars.iv53, 1
  %exitcond55 = icmp eq i64 %indvars.iv.next54, 256
  br i1 %exitcond55, label %for.inc28, label %for.cond4.preheader

for.inc28:                                        ; preds = %for.inc25
  %indvars.iv.next57 = add nuw nsw i64 %indvars.iv56, 1
  %exitcond58 = icmp eq i64 %indvars.iv.next57, 512
  br i1 %exitcond58, label %for.end30, label %for.cond1.preheader

for.end30:                                        ; preds = %for.inc28
  ret void
}

attributes #0 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1 (tags/RELEASE_801/final)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"double", !4, i64 0}
