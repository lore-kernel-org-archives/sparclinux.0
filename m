From: Boaz Harrosh <bharrosh@panasas.com>
Date: Tue, 24 Nov 2009 18:03:12 +0000
Subject: [PATCH 4/5] lockd: Remove unused nfsd headers #includes
Message-Id: <4B0C1FE0.8040105@panasas.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4B0C1EB7.50508@panasas.com>
In-Reply-To: <4B0C1EB7.50508@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J. Bruce Fields" <bfields@citi.umich.edu>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-parisc <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-s


In what history where these ever needed? Well not
any more.

Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>
---
 fs/lockd/svc4proc.c |    4 ----
 fs/lockd/svcproc.c  |    4 ----
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index bd173a6..a7966ee 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -11,10 +11,6 @@
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
-#include <linux/in.h>
-#include <linux/sunrpc/svc.h>
-#include <linux/sunrpc/clnt.h>
-#include <linux/nfsd/nfsd.h>
 #include <linux/lockd/lockd.h>
 #include <linux/lockd/share.h>
 
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index e1d28dd..56c9519 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -11,10 +11,6 @@
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
-#include <linux/in.h>
-#include <linux/sunrpc/svc.h>
-#include <linux/sunrpc/clnt.h>
-#include <linux/nfsd/nfsd.h>
 #include <linux/lockd/lockd.h>
 #include <linux/lockd/share.h>
 
-- 
1.6.5.2


