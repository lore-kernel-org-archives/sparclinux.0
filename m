From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 17 Nov 2018 18:57:15 +0000
Subject: [PATCH 4/4] arm64/bpf: don't allocate BPF JIT programs in module memory
Message-Id: <20181117185715.25198-5-ard.biesheuvel@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The arm64 module region is a 128 MB region that is kept close to
the core kernel, in order to ensure that relative branches are
always in range. So using the same region for programs that do
not have this restriction is wasteful, and preferably avoided.

Now that the core BPF JIT code permits the alloc/free routines to
be overridden, implement them by simple vmalloc_exec()/vfree()
calls, which can be served from anywere. This also solves an
issue under KASAN, where shadow memory is needlessly allocated for
all BPF programs (which don't require KASAN shadow pages since
they are not KASAN instrumented)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/net/bpf_jit_comp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..e0c702c2f682 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -940,3 +940,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return vmalloc_exec(size);
+}
+
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
+{
+	bpf_jit_binary_unlock_ro(hdr);
+	vfree(hdr);
+}
-- 
2.17.1
