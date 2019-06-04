From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 04 Jun 2019 12:04:47 +0000
Subject: [PATCH v2] uaccess: add noop untagged_addr definition
Message-Id: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yishai Hadas <yishaih@mellanox.com>, Jens Wiklander <jens.wiklander@linaro.org>, Lee Smith <Lee.Smith@arm.com>, Alexander Deucher <Alexander.Deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>, Christian Koenig <Christian.Koenig@amd.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Architectures that support memory tagging have a need to perform untagging
(stripping the tag) in various parts of the kernel. This patch adds an
untagged_addr() macro, which is defined as noop for architectures that do
not support memory tagging. The oncoming patch series will define it at
least for sparc64 and arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/mm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834ac32b7..dd0b5f4e1e45 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -99,6 +99,17 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
+/*
+ * Architectures that support memory tagging (assigning tags to memory regions,
+ * embedding these tags into addresses that point to these memory regions, and
+ * checking that the memory and the pointer tags match on memory accesses)
+ * redefine this macro to strip tags from pointers.
+ * It's defined as noop for arcitectures that don't support memory tagging.
+ */
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 #ifndef __pa_symbol
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
-- 
2.22.0.rc1.311.g5d7573a151-goog
