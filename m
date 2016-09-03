From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 03 Sep 2016 16:40:07 +0000
Subject: [PATCH 3/4] sparc: bpf_jit: Avoid assignment for "flen" if BPF JIT is disabled
Message-Id: <2bd51cac-bbb7-da76-9648-4ae24ba342b2@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
 <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
In-Reply-To: <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Sep 2016 18:00:03 +0200

Move the assignment for the local variable "flen" a bit at the beginning
so that it will only be performed if BPF JIT is enabled for this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/sparc/net/bpf_jit_comp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/net/bpf_jit_comp.c b/arch/sparc/net/bpf_jit_comp.c
index a927470..a6b6e29 100644
--- a/arch/sparc/net/bpf_jit_comp.c
+++ b/arch/sparc/net/bpf_jit_comp.c
@@ -365,13 +365,14 @@ void bpf_jit_compile(struct bpf_prog *fp)
 	unsigned int cleanup_addr, proglen, oldproglen;
 	u32 temp[8], *prog, *func, seen, pass;
 	const struct sock_filter *filter;
-	int i, flen = fp->len, pc_ret0;
+	int i, flen, pc_ret0;
 	unsigned int *addrs;
 	void *image;
 
 	if (!bpf_jit_enable)
 		return;
 
+	flen = fp->len;
 	addrs = kmalloc_array(flen, sizeof(*addrs), GFP_KERNEL);
 	if (addrs = NULL)
 		return;
-- 
2.9.3

