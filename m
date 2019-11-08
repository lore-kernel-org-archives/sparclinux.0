From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 08 Nov 2019 21:07:29 +0000
Subject: [PATCH 09/23] y2038: stat: avoid 'time_t' in 'struct stat'
Message-Id: <20191108210824.1534248-9-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20191108210236.1296047-1-arnd@arndb.de>
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org

The time_t definition may differ between user space and kernel space,
so replace time_t with an unambiguous 'long' for the mips and sparc.

The same structures also contain 'off_t', which has the same problem,
so replace that as well on those two architectures and powerpc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/uapi/asm/stat.h    | 16 ++++++++--------
 arch/powerpc/include/uapi/asm/stat.h |  2 +-
 arch/sparc/include/uapi/asm/stat.h   | 24 ++++++++++++------------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/mips/include/uapi/asm/stat.h b/arch/mips/include/uapi/asm/stat.h
index 95416f366d7f..3d2a3b71845c 100644
--- a/arch/mips/include/uapi/asm/stat.h
+++ b/arch/mips/include/uapi/asm/stat.h
@@ -26,17 +26,17 @@ struct stat {
 	gid_t		st_gid;
 	unsigned	st_rdev;
 	long		st_pad2[2];
-	off_t		st_size;
+	long		st_size;
 	long		st_pad3;
 	/*
 	 * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
 	 * but we don't have it under Linux.
 	 */
-	time_t		st_atime;
+	long		st_atime;
 	long		st_atime_nsec;
-	time_t		st_mtime;
+	long		st_mtime;
 	long		st_mtime_nsec;
-	time_t		st_ctime;
+	long		st_ctime;
 	long		st_ctime_nsec;
 	long		st_blksize;
 	long		st_blocks;
@@ -70,13 +70,13 @@ struct stat64 {
 	 * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
 	 * but we don't have it under Linux.
 	 */
-	time_t		st_atime;
+	long		st_atime;
 	unsigned long	st_atime_nsec;	/* Reserved for st_atime expansion  */
 
-	time_t		st_mtime;
+	long		st_mtime;
 	unsigned long	st_mtime_nsec;	/* Reserved for st_mtime expansion  */
 
-	time_t		st_ctime;
+	long		st_ctime;
 	unsigned long	st_ctime_nsec;	/* Reserved for st_ctime expansion  */
 
 	unsigned long	st_blksize;
@@ -105,7 +105,7 @@ struct stat {
 	unsigned int		st_rdev;
 	unsigned int		st_pad1[3]; /* Reserved for st_rdev expansion */
 
-	off_t			st_size;
+	long			st_size;
 
 	/*
 	 * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
diff --git a/arch/powerpc/include/uapi/asm/stat.h b/arch/powerpc/include/uapi/asm/stat.h
index afd25f2ff4e8..7871055e5e32 100644
--- a/arch/powerpc/include/uapi/asm/stat.h
+++ b/arch/powerpc/include/uapi/asm/stat.h
@@ -40,7 +40,7 @@ struct stat {
 	uid_t		st_uid;
 	gid_t		st_gid;
 	unsigned long	st_rdev;
-	off_t		st_size;
+	long		st_size;
 	unsigned long	st_blksize;
 	unsigned long	st_blocks;
 	unsigned long	st_atime;
diff --git a/arch/sparc/include/uapi/asm/stat.h b/arch/sparc/include/uapi/asm/stat.h
index b6ec4eb217f7..732c41720e24 100644
--- a/arch/sparc/include/uapi/asm/stat.h
+++ b/arch/sparc/include/uapi/asm/stat.h
@@ -14,12 +14,12 @@ struct stat {
 	uid_t   st_uid;
 	gid_t   st_gid;
 	unsigned int st_rdev;
-	off_t   st_size;
-	time_t  st_atime;
-	time_t  st_mtime;
-	time_t  st_ctime;
-	off_t   st_blksize;
-	off_t   st_blocks;
+	long    st_size;
+	long    st_atime;
+	long    st_mtime;
+	long    st_ctime;
+	long    st_blksize;
+	long    st_blocks;
 	unsigned long  __unused4[2];
 };
 
@@ -57,15 +57,15 @@ struct stat {
 	unsigned short	st_uid;
 	unsigned short	st_gid;
 	unsigned short	st_rdev;
-	off_t		st_size;
-	time_t		st_atime;
+	long		st_size;
+	long		st_atime;
 	unsigned long	st_atime_nsec;
-	time_t		st_mtime;
+	long		st_mtime;
 	unsigned long	st_mtime_nsec;
-	time_t		st_ctime;
+	long		st_ctime;
 	unsigned long	st_ctime_nsec;
-	off_t		st_blksize;
-	off_t		st_blocks;
+	long		st_blksize;
+	long		st_blocks;
 	unsigned long	__unused4[2];
 };
 
-- 
2.20.0
