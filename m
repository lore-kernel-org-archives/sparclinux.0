From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 03 Sep 2016 16:33:42 +0000
Subject: [PATCH 0/4] sparc: bpf_jit: Fine-tuning for bpf_jit_compile()
Message-Id: <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Sep 2016 18:28:02 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Use kmalloc_array()
  Move four assignments
  Avoid assignment for the variable "flen" if BPF JIT is disabled.
  Rename jump labels

 arch/sparc/net/bpf_jit_comp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.9.3

