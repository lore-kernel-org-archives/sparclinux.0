From: Milind Arun Choudhary <milindchoudhary@gmail.com>
Date: Thu, 12 Apr 2007 17:26:53 +0000
Subject: [KJ][PATCH]ROUND_UP macro cleanup in arch/sparc,sparc64
Message-Id: <20070412171452.GA8884@arun.site>
List-Id: <sparclinux.vger.kernel.org>
References: <20070405134422.GA9510@arun.site>
In-Reply-To: <20070405134422.GA9510@arun.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@lists.osdl.org, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net, wli@holomorphy.com

ROUND_UP macro cleanup, use ALIGN

Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>
---
 sparc/kernel/sys_sunos.c     |    5 ++---
 sparc64/kernel/sys_sunos32.c |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/sys_sunos.c b/arch/sparc/kernel/sys_sunos.c
index da6606f..23f4efe 100644
--- a/arch/sparc/kernel/sys_sunos.c
+++ b/arch/sparc/kernel/sys_sunos.c
@@ -322,7 +322,6 @@ struct sunos_dirent_callback {
 };
 
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
-#define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
 
 static int sunos_filldir(void * __buf, const char * name, int namlen,
 			 loff_t offset, u64 ino, unsigned int d_type)
@@ -330,7 +329,7 @@ static int sunos_filldir(void * __buf, const char * name, int namlen,
 	struct sunos_dirent __user *dirent;
 	struct sunos_dirent_callback * buf = __buf;
 	unsigned long d_ino;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	int reclen = ALIGN(NAME_OFFSET(dirent) + namlen + 1, sizeof(long));
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
@@ -415,7 +414,7 @@ static int sunos_filldirentry(void * __buf, const char * name, int namlen,
 	struct sunos_direntry __user *dirent;
 	struct sunos_direntry_callback *buf = __buf;
 	unsigned long d_ino;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	int reclen = ALIGN(NAME_OFFSET(dirent) + namlen + 1, sizeof(long));
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
diff --git a/arch/sparc64/kernel/sys_sunos32.c b/arch/sparc64/kernel/sys_sunos32.c
index 4cff95b..937f19b 100644
--- a/arch/sparc64/kernel/sys_sunos32.c
+++ b/arch/sparc64/kernel/sys_sunos32.c
@@ -273,14 +273,13 @@ struct sunos_dirent_callback {
 };
 
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
-#define ROUND_UP(x) (((x)+sizeof(s32)-1) & ~(sizeof(s32)-1))
 
 static int sunos_filldir(void * __buf, const char * name, int namlen,
 			 loff_t offset, ino_t ino, unsigned int d_type)
 {
 	struct sunos_dirent __user *dirent;
 	struct sunos_dirent_callback * buf = (struct sunos_dirent_callback *) __buf;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	int reclen = ALIGN(NAME_OFFSET(dirent) + namlen + 1, sizeof(s32));
 	u32 d_ino;
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
@@ -367,7 +366,7 @@ static int sunos_filldirentry(void * __buf, const char * name, int namlen,
 	struct sunos_direntry __user *dirent;
 	struct sunos_direntry_callback * buf  		(struct sunos_direntry_callback *) __buf;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	int reclen = ALIGN(NAME_OFFSET(dirent) + namlen + 1, sizeof(s32));
 	u32 d_ino;
 
 	buf->error = -EINVAL;	/* only used if we fail.. */

-- 
Milind Arun Choudhary
