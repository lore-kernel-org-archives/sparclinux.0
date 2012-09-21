From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Fri, 21 Sep 2012 04:57:51 +0000
Subject: [PATCH] sparc: fix the return value of module_alloc()
Message-Id: <CAPgLHd-ND_itgeVLvvqFZEU1peMuCk=dAfFhkH68KFV7biHhzA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, function module_alloc() in other platform never
returns ERR_PTR(), and all of the user only check for NULL, so
we'd better return NULL instead of ERR_PTR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/sparc/kernel/module.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 15e0a16..df7e16c 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -48,9 +48,7 @@ void *module_alloc(unsigned long size)
 		return NULL;
 
 	ret = module_map(size);
-	if (!ret)
-		ret = ERR_PTR(-ENOMEM);
-	else
+	if (ret)
 		memset(ret, 0, size);
 
 	return ret;


