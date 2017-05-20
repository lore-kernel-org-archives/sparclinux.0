From: Babu Moger <babu.moger@oracle.com>
Date: Sat, 20 May 2017 00:16:58 +0000
Subject: [PATCH v2 4/7] arch/sparc: Introduce cmpxchg_u8 SPARC
Message-Id: <1495239421-441642-5-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

SPARC supports 32 bit and 64 bit cmpxchg right now. Add support
for 8 bit (1 byte) cmpxchg. This is required to support queued
rwlocks feature  which uses 1 byte cmpxchg.

The function __cmpxchg_u8 here uses the 4 byte cas instruction with a
byte manipulation to achieve 1 byte cmpxchg.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/include/asm/cmpxchg_64.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/c=
mpxchg_64.h
index faa2f61..000f7d7 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -87,6 +87,33 @@ static inline unsigned long __xchg(unsigned long x, __vo=
latile__ void * ptr,
 	return new;
 }
=20
+/*
+ * Use 4 byte cas instruction to achieve 1 byte cmpxchg. Main logic
+ * here is to get the bit shift of the byte we are interested in.
+ * The XOR is handy for reversing the bits for big-endian byte order
+ */
+static inline unsigned long
+__cmpxchg_u8(volatile unsigned char *m, unsigned char old, unsigned char n=
ew)
+{
+	unsigned long maddr =3D (unsigned long)m;
+	int bit_shift =3D (((unsigned long)m & 3) ^ 3) << 3;
+	unsigned int mask =3D 0xff << bit_shift;
+	unsigned int *ptr =3D (unsigned int *) (maddr & ~3);
+	unsigned int old32, new32, load;
+	unsigned int load32 =3D *ptr;
+
+	do {
+		new32 =3D (load32 & ~mask) | (new << bit_shift);
+		old32 =3D (load32 & ~mask) | (old << bit_shift);
+		load32 =3D __cmpxchg_u32(ptr, old32, new32);
+		if (load32 =3D old32)
+			return old;
+		load =3D (load32 & mask) >> bit_shift;
+	} while (load =3D old);
+
+	return load;
+}
+
 /* This function doesn't exist, so you'll get a linker error
    if something tries to do an invalid cmpxchg().  */
 void __cmpxchg_called_with_bad_pointer(void);
@@ -95,6 +122,8 @@ static inline unsigned long __xchg(unsigned long x, __vo=
latile__ void * ptr,
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int si=
ze)
 {
 	switch (size) {
+		case 1:
+			return __cmpxchg_u8(ptr, old, new);
 		case 4:
 			return __cmpxchg_u32(ptr, old, new);
 		case 8:
--=20
1.7.1

