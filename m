From: Bill Wendling <morbo@google.com>
Date: Tue, 22 Sep 2020 23:21:40 +0000
Subject: [PATCH] kbuild: explicitly specify the build id style
Message-Id: <20200922232140.1994390-1-morbo@google.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Andy Lutomirski <luto@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Catalin Marinas <catalin.marinas@arm.com>, "David S . Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <natechancellor@gmail.com>, Bill Wendling <morbo@google.com>

ld's --build-id defaults to "sha1" style, while lld defaults to "fast".
The build IDs are very different between the two, which may confuse
programs that reference them.

Signed-off-by: Bill Wendling <morbo@google.com>
---
 Makefile                             | 4 ++--
 arch/arm/vdso/Makefile               | 2 +-
 arch/arm64/kernel/vdso/Makefile      | 2 +-
 arch/arm64/kernel/vdso32/Makefile    | 2 +-
 arch/mips/vdso/Makefile              | 2 +-
 arch/riscv/kernel/vdso/Makefile      | 2 +-
 arch/s390/kernel/vdso64/Makefile     | 2 +-
 arch/sparc/vdso/Makefile             | 2 +-
 arch/x86/entry/vdso/Makefile         | 2 +-
 tools/testing/selftests/bpf/Makefile | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 2b66d3398878..7e6f41c9803a 100644
--- a/Makefile
+++ b/Makefile
@@ -973,8 +973,8 @@ KBUILD_CPPFLAGS +=3D $(KCPPFLAGS)
 KBUILD_AFLAGS   +=3D $(KAFLAGS)
 KBUILD_CFLAGS   +=3D $(KCFLAGS)
=20
-KBUILD_LDFLAGS_MODULE +=3D --build-id
-LDFLAGS_vmlinux +=3D --build-id
+KBUILD_LDFLAGS_MODULE +=3D --build-id=3Dsha1
+LDFLAGS_vmlinux +=3D --build-id=3Dsha1
=20
 ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
 LDFLAGS_vmlinux	+=3D $(call ld-option, -X,)
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index a54f70731d9f..150ce6e6a5d3 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -19,7 +19,7 @@ ccflags-y +=3D -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO32
 ldflags-$(CONFIG_CPU_ENDIAN_BE8) :=3D --be8
 ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1 \
 	    -z max-page-size@96 -nostdlib -shared $(ldflags-y) \
-	    --hash-style=3Dsysv --build-id \
+	    --hash-style=3Dsysv --build-id=3Dsha1 \
 	    -T
=20
 obj-$(CONFIG_VDSO) +=3D vdso.o
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makef=
ile
index 45d5cfe46429..871915097f9d 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -24,7 +24,7 @@ btildflags-$(CONFIG_ARM64_BTI_KERNEL) +=3D -z force-bti
 # routines, as x86 does (see 6f121e548f83 ("x86, vdso: Reimplement vdso.so
 # preparation in build-time C")).
 ldflags-y :=3D -shared -nostdlib -soname=3Dlinux-vdso.so.1 --hash-style=3D=
sysv	\
-	     -Bsymbolic $(call ld-option, --no-eh-frame-hdr) --build-id -n	\
+	     -Bsymbolic $(call ld-option, --no-eh-frame-hdr) --build-id=3Dsha1 -n=
	\
 	     $(btildflags-y) -T
=20
 ccflags-y :=3D -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/M=
akefile
index d6adb4677c25..4fa4b3fe8efb 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -128,7 +128,7 @@ VDSO_LDFLAGS +=3D -Wl,-Bsymbolic -Wl,--no-undefined -Wl=
,-soname=3Dlinux-vdso.so.1
 VDSO_LDFLAGS +=3D -Wl,-z,max-page-size@96 -Wl,-z,common-page-size@96
 VDSO_LDFLAGS +=3D -nostdlib -shared -mfloat-abi=3Dsoft
 VDSO_LDFLAGS +=3D -Wl,--hash-style=3Dsysv
-VDSO_LDFLAGS +=3D -Wl,--build-id
+VDSO_LDFLAGS +=3D -Wl,--build-id=3Dsha1
 VDSO_LDFLAGS +=3D $(call cc32-ldoption,-fuse-ld=BFd)
=20
=20
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 57fe83235281..5810cc12bc1d 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -61,7 +61,7 @@ endif
 # VDSO linker flags.
 ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1 \
 	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
-	-G 0 --eh-frame-hdr --hash-style=3Dsysv --build-id -T
+	-G 0 --eh-frame-hdr --hash-style=3Dsysv --build-id=3Dsha1 -T
=20
 CFLAGS_REMOVE_vdso.o =3D -pg
=20
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makef=
ile
index 478e7338ddc1..7d6a94d45ec9 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -49,7 +49,7 @@ $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
 # refer to these symbols in the kernel code rather than hand-coded address=
es.
=20
 SYSCFLAGS_vdso.so.dbg =3D -shared -s -Wl,-soname=3Dlinux-vdso.so.1 \
-	-Wl,--build-id -Wl,--hash-style=3Dboth
+	-Wl,--build-id=3Dsha1 -Wl,--hash-style=3Dboth
 $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
 	$(call if_changed,vdsold)
=20
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Mak=
efile
index 4a66a1cb919b..edc473b32e42 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -19,7 +19,7 @@ KBUILD_AFLAGS_64 +=3D -m64 -s
 KBUILD_CFLAGS_64 :=3D $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 +=3D -m64 -fPIC -shared -fno-common -fno-builtin
 ldflags-y :=3D -fPIC -shared -nostdlib -soname=3Dlinux-vdso64.so.1 \
-	     --hash-style=3Dboth --build-id -T
+	     --hash-style=3Dboth --build-id=3Dsha1 -T
=20
 $(targets:%=3D$(obj)/%.dbg): KBUILD_CFLAGS =3D $(KBUILD_CFLAGS_64)
 $(targets:%=3D$(obj)/%.dbg): KBUILD_AFLAGS =3D $(KBUILD_AFLAGS_64)
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index f44355e46f31..469dd23887ab 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -115,7 +115,7 @@ quiet_cmd_vdso =3D VDSO    $@
 		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		sh $(srctree)/$(src)/checkundef.sh '$(OBJDUMP)' '$@'
=20
-VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id -Bsymbolic
+VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 -Bsymbolic
 GCOV_PROFILE :=3D n
=20
 #
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 215376d975a2..ebba25ed9a38 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -176,7 +176,7 @@ quiet_cmd_vdso =3D VDSO    $@
 		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
=20
-VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id \
+VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 \
 	$(call ld-option, --eh-frame-hdr) -Bsymbolic
 GCOV_PROFILE :=3D n
=20
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index fc946b7ac288..daf186f88a63 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -133,7 +133,7 @@ $(OUTPUT)/%:%.c
=20
 $(OUTPUT)/urandom_read: urandom_read.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(LDFLAGS) -o $@ $< $(LDLIBS) -Wl,--build-id
+	$(Q)$(CC) $(LDFLAGS) -o $@ $< $(LDLIBS) -Wl,--build-id=3Dsha1
=20
 $(OUTPUT)/test_stub.o: test_stub.c $(BPFOBJ)
 	$(call msg,CC,,$@)
--=20
2.28.0.681.g6f77f65b4e-goog
