From: "David S. Miller" <davem@redhat.com>
Date: Wed, 11 Feb 2004 05:59:00 +0000
Subject: Fix for exception length errors in sparc64 copy_*_user()
Message-Id: <20040210215900.5078d229.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


OK, the patch below should fix the problem and thus the AIO
testsuite failures on sparc64.

Thanks for the report David.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/10 21:38:40-08:00 davem@nuts.davemloft.net 
#   [SPARC64]: Fix exception remaining length calcs in VIS copy routines.
# 
# arch/sparc64/lib/VIScopy.S
#   2004/02/10 21:34:37-08:00 davem@nuts.davemloft.net +11 -14
#   [SPARC64]: Fix exception remaining length calcs in VIS copy routines.
# 
diff -Nru a/arch/sparc64/lib/VIScopy.S b/arch/sparc64/lib/VIScopy.S
--- a/arch/sparc64/lib/VIScopy.S	Tue Feb 10 21:52:55 2004
+++ b/arch/sparc64/lib/VIScopy.S	Tue Feb 10 21:52:55 2004
@@ -120,7 +120,6 @@
 #define EXVIS2(x,y) EXVISN(x,y,2)
 #define EXVIS3(x,y) EXVISN(x,y,3)
 #define EXVIS4(x,y) EXVISN(x,y,4)
-#define EXVIS5(x,y) EXVISN(x,y,5)
 
 #define FREG_FROB(f1, f2, f3, f4, f5, f6, f7, f8, f9)		\
 	faligndata		%f1, %f2, %f48;			\
@@ -135,7 +134,7 @@
 #define MAIN_LOOP_CHUNK(src, dest, fdest, fsrc, len, jmptgt)	\
 	EXVIS(LDBLK		[%src] ASIBLK, %fdest);		\
 	ASI_SETDST_BLK						\
-	EXVIS2(STBLK		%fsrc, [%dest] ASIBLK);		\
+	EXVIS(STBLK		%fsrc, [%dest] ASIBLK);		\
 	add			%src, 0x40, %src;		\
 	subcc			%len, 0x40, %len;		\
 	be,pn			%xcc, jmptgt;			\
@@ -156,14 +155,14 @@
 #ifdef __KERNEL__
 #define STORE_JUMP(dest, fsrc, target)				\
 	srl			asi_dest, 3, %g5;		\
-	EXVIS3(STBLK		%fsrc, [%dest] ASIBLK);		\
+	EXVIS2(STBLK		%fsrc, [%dest] ASIBLK);		\
 	xor		       asi_dest, ASI_BLK_XOR1, asi_dest;\
 	add			%dest, 0x40, %dest;		\
 	xor			asi_dest, %g5, asi_dest;	\
 	ba,pt			%xcc, target;
 #else
 #define STORE_JUMP(dest, fsrc, target)				\
-	EXVIS3(STBLK		%fsrc, [%dest] ASIBLK);		\
+	EXVIS2(STBLK		%fsrc, [%dest] ASIBLK);		\
 	add			%dest, 0x40, %dest;		\
 	ba,pt			%xcc, target;
 #endif
@@ -182,7 +181,7 @@
 	subcc			%left, 8, %left;		\
 	bl,pn			%xcc, vis_out;			\
 	 faligndata		%f0, %f1, %f48;			\
-	EXVIS4(STDF		%f48, [%dest] ASINORMAL);	\
+	EXVIS3(STDF		%f48, [%dest] ASINORMAL);	\
 	add			%dest, 8, %dest;
 
 #define UNEVEN_VISCHUNK_LAST(dest, f0, f1, left)		\
@@ -675,21 +674,21 @@
 	xor		asi_src, %g5, asi_src			! IEU0	Group
 #endif
 vis_slk:ASI_SETSRC_NOBLK					! LSU	Group
-	EXVIS4(LDDF	[%o1] ASINORMAL, %f2)			! Load	Group
+	EXVIS3(LDDF	[%o1] ASINORMAL, %f2)			! Load	Group
 	add		%o1, 8, %o1				! IEU0
 	subcc		%g3, 8, %g3				! IEU1
 	ASI_SETDST_NOBLK					! LSU	Group
 	faligndata	%f0, %f2, %f8				! GRU	Group
-	EXVIS5(STDF	%f8, [%o0] ASINORMAL)			! Store
+	EXVIS4(STDF	%f8, [%o0] ASINORMAL)			! Store
 	bl,pn		%xcc, vis_out_slp			! CTI
 	 add		%o0, 8, %o0				! IEU0	Group
 	ASI_SETSRC_NOBLK					! LSU	Group
-	EXVIS4(LDDF	[%o1] ASINORMAL, %f0)			! Load	Group
+	EXVIS3(LDDF	[%o1] ASINORMAL, %f0)			! Load	Group
 	add		%o1, 8, %o1				! IEU0
 	subcc		%g3, 8, %g3				! IEU1
 	ASI_SETDST_NOBLK					! LSU	Group
 	faligndata	%f2, %f0, %f8				! GRU	Group
-	EXVIS5(STDF	%f8, [%o0] ASINORMAL)			! Store
+	EXVIS4(STDF	%f8, [%o0] ASINORMAL)			! Store
 	bge,pt		%xcc, vis_slk				! CTI
 	 add		%o0, 8, %o0				! IEU0	Group
 vis_out_slp:
@@ -1138,19 +1137,17 @@
 		sub		%g7, %g2, %g7
 		ba,pt		%xcc, VIScopyfixup_ret
 		 add		%g7, %o2, %o1
-VIScopyfixup_vis3:
-		sub		%o2, 0x80, %o2
 VIScopyfixup_vis2:
-		add		%o2, 0x40, %o2
+		sub		%o2, 0x40, %o2
 VIScopyfixup_vis0:
 		add		%o2, 0x80, %o2
 VIScopyfixup_vis1:
 		add		%g7, %g3, %g7
 		ba,pt		%xcc, VIScopyfixup_ret
 		 add		%o2, %g7, %o1
-VIScopyfixup_vis5:
-		add		%g3, 8, %g3
 VIScopyfixup_vis4:
+		add		%g3, 8, %g3
+VIScopyfixup_vis3:
 		add		%g3, 8, %g3
 		ba,pt		%xcc, VIScopyfixup_ret
 		 add		%o2, %g3, %o1
