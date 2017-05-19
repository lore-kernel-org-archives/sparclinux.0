From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 19 May 2017 00:36:09 +0000
Subject: [PATCH 5/6] arch/sparc: Introduce xchg16 for SPARC
Message-Id: <1495154170-854693-6-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

SPARC supports 32 bit and 64 bit xchg right now. Add the support
for 16 bit (2 byte) xchg. This is required to support queued spinlock
feature which uses 2 byte xchg. This is achieved using 4 byte cas
instructions with byte manipulations.

Also re-arranged the code to call __cmpxchg_u32 inside xchg16.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/include/asm/cmpxchg_64.h |   49 +++++++++++++++++++++++++++----=
---
 1 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/c=
mpxchg_64.h
index 65bfae0..a6c9fe3 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -6,6 +6,17 @@
 #ifndef __ARCH_SPARC64_CMPXCHG__
 #define __ARCH_SPARC64_CMPXCHG__
=20
+static inline unsigned long
+__cmpxchg_u32(volatile int *m, int old, int new)
+{
+	__asm__ __volatile__("cas [%2], %3, %0"
+			     : "=3D&r" (new)
+			     : "0" (new), "r" (m), "r" (old)
+			     : "memory");
+
+	return new;
+}
+
 static inline unsigned long xchg32(__volatile__ unsigned int *m, unsigned =
int val)
 {
 	unsigned long tmp1, tmp2;
@@ -44,10 +55,38 @@ static inline unsigned long xchg64(__volatile__ unsigne=
d long *m, unsigned long=20
=20
 void __xchg_called_with_bad_pointer(void);
=20
+/*
+ * Use 4 byte cas instruction to achieve 2 byte xchg. Main logic
+ * here is to get the bit shift of the byte we are interested in.
+ * The XOR is handy for reversing the bits for big-endian byte order.
+ */
+static inline unsigned long
+xchg16(__volatile__ unsigned short *m, unsigned int val)
+{
+	unsigned long maddr =3D (unsigned long)m;
+	int bit_shift =3D (((unsigned long)m & 2) ^ 2) << 3;
+	unsigned int mask =3D 0xffff << bit_shift;
+	unsigned int *ptr =3D (unsigned int  *) (maddr & ~2);
+	unsigned int old32, new32, load32;
+
+	/* Read the old value */
+	load32 =3D *ptr;
+
+	do {
+		old32 =3D load32;
+		new32 =3D (load32 & (~mask)) | val << bit_shift;
+		load32 =3D __cmpxchg_u32(ptr, old32, new32);
+	} while (load32 !=3D old32);
+
+	return (load32 & mask) >> bit_shift;
+}
+
 static inline unsigned long __xchg(unsigned long x, __volatile__ void * pt=
r,
 				       int size)
 {
 	switch (size) {
+	case 2:
+		return xchg16(ptr, x);
 	case 4:
 		return xchg32(ptr, x);
 	case 8:
@@ -65,16 +104,6 @@ static inline unsigned long __xchg(unsigned long x, __v=
olatile__ void * ptr,
=20
 #include <asm-generic/cmpxchg-local.h>
=20
-static inline unsigned long
-__cmpxchg_u32(volatile int *m, int old, int new)
-{
-	__asm__ __volatile__("cas [%2], %3, %0"
-			     : "=3D&r" (new)
-			     : "0" (new), "r" (m), "r" (old)
-			     : "memory");
-
-	return new;
-}
=20
 static inline unsigned long
 __cmpxchg_u64(volatile long *m, unsigned long old, unsigned long new)
--=20
1.7.1

