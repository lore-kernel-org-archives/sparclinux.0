From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 13 Jul 2019 04:01:10 +0000
Subject: [PATCH] kbuild: add --hash-style= and --build-id unconditionally
Message-Id: <20190713040110.18210-1-yamada.masahiro@socionext.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

As commit 1e0221374e30 ("mips: vdso: drop unnecessary cc-ldoption")
explained, these flags are supported by the minimal required version
of binutils.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                          | 6 ++----
 arch/arm/vdso/Makefile            | 3 +--
 arch/arm64/kernel/vdso32/Makefile | 4 ++--
 arch/sparc/vdso/Makefile          | 3 +--
 arch/x86/entry/vdso/Makefile      | 5 ++---
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 2c5d00ba537e..969182105dbd 100644
--- a/Makefile
+++ b/Makefile
@@ -900,10 +900,8 @@ KBUILD_CPPFLAGS +=3D $(ARCH_CPPFLAGS) $(KCPPFLAGS)
 KBUILD_AFLAGS   +=3D $(ARCH_AFLAGS)   $(KAFLAGS)
 KBUILD_CFLAGS   +=3D $(ARCH_CFLAGS)   $(KCFLAGS)
=20
-# Use --build-id when available.
-LDFLAGS_BUILD_ID :=3D $(call ld-option, --build-id)
-KBUILD_LDFLAGS_MODULE +=3D $(LDFLAGS_BUILD_ID)
-LDFLAGS_vmlinux +=3D $(LDFLAGS_BUILD_ID)
+KBUILD_LDFLAGS_MODULE +=3D --build-id
+LDFLAGS_vmlinux +=3D --build-id
=20
 ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
 LDFLAGS_vmlinux	+=3D $(call ld-option, -X,)
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index ca85df247775..87b7769214e0 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -13,8 +13,7 @@ ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
 ldflags-$(CONFIG_CPU_ENDIAN_BE8) :=3D --be8
 ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1 \
 	    -z max-page-size@96 -nostdlib -shared $(ldflags-y) \
-	    $(call ld-option, --hash-style=3Dsysv) \
-	    $(call ld-option, --build-id) \
+	    --hash-style=3Dsysv --build-id \
 	    -T
=20
 obj-$(CONFIG_VDSO) +=3D vdso.o
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/M=
akefile
index 288c14d30b45..60a4c6239712 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -96,8 +96,8 @@ VDSO_LDFLAGS :=3D $(VDSO_CPPFLAGS)
 VDSO_LDFLAGS +=3D -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=3Dlinux-vd=
so.so.1
 VDSO_LDFLAGS +=3D -Wl,-z,max-page-size@96 -Wl,-z,common-page-size@96
 VDSO_LDFLAGS +=3D -nostdlib -shared -mfloat-abi=3Dsoft
-VDSO_LDFLAGS +=3D $(call cc32-ldoption,-Wl$(comma)--hash-style=3Dsysv)
-VDSO_LDFLAGS +=3D $(call cc32-ldoption,-Wl$(comma)--build-id)
+VDSO_LDFLAGS +=3D -Wl,--hash-style=3Dsysv
+VDSO_LDFLAGS +=3D -Wl,--build-id
 VDSO_LDFLAGS +=3D $(call cc32-ldoption,-fuse-ld=BFd)
=20
=20
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 5a9e4e1f9f81..324a23947585 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -115,8 +115,7 @@ quiet_cmd_vdso =3D VDSO    $@
 		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		sh $(srctree)/$(src)/checkundef.sh '$(OBJDUMP)' '$@'
=20
-VDSO_LDFLAGS =3D -shared $(call ld-option, --hash-style=3Dboth) \
-	$(call ld-option, --build-id) -Bsymbolic
+VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id -Bsymbolic
 GCOV_PROFILE :=3D n
=20
 #
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 39106111be86..4c234a18638a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -179,9 +179,8 @@ quiet_cmd_vdso =3D VDSO    $@
 		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
=20
-VDSO_LDFLAGS =3D -shared $(call ld-option, --hash-style=3Dboth) \
-	$(call ld-option, --build-id) $(call ld-option, --eh-frame-hdr) \
-	-Bsymbolic
+VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id \
+	$(call ld-option, --eh-frame-hdr) -Bsymbolic
 GCOV_PROFILE :=3D n
=20
 #
--=20
2.17.1
