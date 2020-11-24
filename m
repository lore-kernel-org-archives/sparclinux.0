From: Dmitry Safonov <dima@arista.com>
Date: Tue, 24 Nov 2020 00:29:23 +0000
Subject: [PATCH v2 10/19] sparc/vdso: Remove vdso pointer from mm->context
Message-Id: <20201124002932.1220517-11-dima@arista.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201124002932.1220517-1-dima@arista.com>
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Dmitry Safonov <dima@arista.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, x86@kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Not used any more.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sparc/include/asm/mmu_64.h | 1 -
 arch/sparc/vdso/vma.c           | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
index 7e2704c770e9..8e7892890d14 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -111,7 +111,6 @@ typedef struct {
 	unsigned long		thp_pte_count;
 	struct tsb_config	tsb_block[MM_NUM_TSBS];
 	struct hv_tsb_descr	tsb_descr[MM_NUM_TSBS];
-	void			*vdso;
 	bool			adi;
 	tag_storage_desc_t	*tag_store;
 	spinlock_t		tag_lock;
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index bf9195fe9bcc..255e052223ca 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -389,7 +389,6 @@ static int map_vdso(const struct vdso_image *image,
 	}
 
 	text_start = addr - image->sym_vvar_start;
-	current->mm->context.vdso = (void __user *)text_start;
 
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
@@ -418,9 +417,7 @@ static int map_vdso(const struct vdso_image *image,
 	}
 
 up_fail:
-	if (ret)
-		current->mm->context.vdso = NULL;
-	else
+	if (!ret)
 		*sysinfo_ehdr = text_start;
 
 	mmap_write_unlock(mm);
-- 
2.29.2
