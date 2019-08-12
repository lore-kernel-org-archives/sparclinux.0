From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 12 Aug 2019 21:50:42 +0000
Subject: [PATCH 09/16] sparc: prefer __section from compiler_attributes.h
Message-Id: <20190812215052.71840-9-ndesaulniers@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190812215052.71840-1-ndesaulniers@google.com>
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com, miguel.ojeda.sandonis@gmail.com, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sparc/include/asm/cache.h | 2 +-
 arch/sparc/kernel/btext.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cache.h b/arch/sparc/include/asm/cache.h
index dcfd58118c11..9a9effdd01e2 100644
--- a/arch/sparc/include/asm/cache.h
+++ b/arch/sparc/include/asm/cache.h
@@ -21,6 +21,6 @@
 
 #define SMP_CACHE_BYTES (1 << SMP_CACHE_BYTES_SHIFT)
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #endif /* !(_SPARC_CACHE_H) */
diff --git a/arch/sparc/kernel/btext.c b/arch/sparc/kernel/btext.c
index 5869773f3dc4..b2eff8f8f27b 100644
--- a/arch/sparc/kernel/btext.c
+++ b/arch/sparc/kernel/btext.c
@@ -24,7 +24,7 @@ static void draw_byte_32(unsigned char *bits, unsigned int *base, int rb);
 static void draw_byte_16(unsigned char *bits, unsigned int *base, int rb);
 static void draw_byte_8(unsigned char *bits, unsigned int *base, int rb);
 
-#define __force_data __attribute__((__section__(".data")))
+#define __force_data __section(.data)
 
 static int g_loc_X __force_data;
 static int g_loc_Y __force_data;
-- 
2.23.0.rc1.153.gdeed80330f-goog
