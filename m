From: Jan Engelhardt <jengelh@inai.de>
Date: Sat, 16 Dec 2017 01:01:17 +0000
Subject: [PATCH] crypto: n2 - cure use after free
Message-Id: <20171216010117.13275-1-jengelh@inai.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

queue_cache_init is called for every crypto processor found.

When first invoked, queue_cache[0] is NULL and queue_cache_init will
allocate a kmem_cache. If queue_cache_init returns a failure code, the
caller, grab_global_resources, will call queue_cache_destroy to release said
kmem_cache, but it does this without setting queue_cache_init[0] to NULL.

So when the second processor gets probed, queue_cache_init will leave
queue_cache[0] at its bogus value, causing a BUG() to trigger when
queue_cache[0] is eventually passed to kmem_cache_zalloc:

	n2_crypto: Found N2CP at /virtual-devices@100/n2cp@7
	n2_crypto: Registered NCS HVAPI version 2.0
	called queue_cache_init
	n2_crypto: md5 alg registration failed
	n2cp f028687c: /virtual-devices@100/n2cp@7: Unable to register algorithms.
	called queue_cache_destroy
	n2cp: probe of f028687c failed with error -22
	n2_crypto: Found NCP at /virtual-devices@100/ncp@6
	n2_crypto: Registered NCS HVAPI version 2.0
	called queue_cache_init
	kernel BUG at mm/slab.c:2993!
	Call Trace:
	 [0000000000604488] kmem_cache_alloc+0x1a8/0x1e0
                  (inlined) kmem_cache_zalloc
                  (inlined) new_queue
                  (inlined) spu_queue_setup
                  (inlined) handle_exec_unit
	 [0000000010c61eb4] spu_mdesc_scan+0x1f4/0x460 [n2_crypto]
	 [0000000010c62b80] n2_mau_probe+0x100/0x220 [n2_crypto]
	 [000000000084b174] platform_drv_probe+0x34/0xc0

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 drivers/crypto/n2_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 48de52cf2ecc..662e709812cc 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1625,6 +1625,7 @@ static int queue_cache_init(void)
 					  CWQ_ENTRY_SIZE, 0, NULL);
 	if (!queue_cache[HV_NCS_QTYPE_CWQ - 1]) {
 		kmem_cache_destroy(queue_cache[HV_NCS_QTYPE_MAU - 1]);
+		queue_cache[HV_NCS_QTYPE_MAU - 1] = NULL;
 		return -ENOMEM;
 	}
 	return 0;
@@ -1634,6 +1635,8 @@ static void queue_cache_destroy(void)
 {
 	kmem_cache_destroy(queue_cache[HV_NCS_QTYPE_MAU - 1]);
 	kmem_cache_destroy(queue_cache[HV_NCS_QTYPE_CWQ - 1]);
+	queue_cache[HV_NCS_QTYPE_MAU - 1] = NULL;
+	queue_cache[HV_NCS_QTYPE_CWQ - 1] = NULL;
 }
 
 static long spu_queue_register_workfn(void *arg)
-- 
2.12.3

