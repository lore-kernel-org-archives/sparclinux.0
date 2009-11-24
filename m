From: Boaz Harrosh <bharrosh@panasas.com>
Date: Tue, 24 Nov 2009 17:59:54 +0000
Subject: [PATCH 1/5] parsic: remove unused nfsd #includes
Message-Id: <4B0C1F1A.8070605@panasas.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4B0C1EB7.50508@panasas.com>
In-Reply-To: <4B0C1EB7.50508@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J. Bruce Fields" <bfields@citi.umich.edu>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-parisc <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-s


Some unused includes removed.

This patch is in an effort to cleanup nfsd headers and move
private definitions to source directory.

Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>
---
 arch/parisc/kernel/sys_parisc32.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/kernel/sys_parisc32.c b/arch/parisc/kernel/sys_parisc32.c
index 561388b..4a8ca63 100644
--- a/arch/parisc/kernel/sys_parisc32.c
+++ b/arch/parisc/kernel/sys_parisc32.c
@@ -26,13 +26,7 @@
 #include <linux/shm.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
-#include <linux/nfs_fs.h>
 #include <linux/ncp_fs.h>
-#include <linux/sunrpc/svc.h>
-#include <linux/nfsd/nfsd.h>
-#include <linux/nfsd/cache.h>
-#include <linux/nfsd/xdr.h>
-#include <linux/nfsd/syscall.h>
 #include <linux/poll.h>
 #include <linux/personality.h>
 #include <linux/stat.h>
-- 
1.6.5.2


