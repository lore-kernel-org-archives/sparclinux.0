Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE61B0131;
	Thu, 20 Jun 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899138; cv=none; b=HmmD9Kc/tKREGabTn3pKcUj3j00OVLGGbC3TDMvauajgsp3Vnhgvx/xFU3d7/prKHktcjFDYL9NmTboP9N5XoP59CBTUKGTy4Z1yJnIWSFKGIRJFs9oH97CUJrdt4fprPXa/NOKi3QM2cspO6hiEl5ZntWL/CXv0flKpqqtJ838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899138; c=relaxed/simple;
	bh=sWSXWB4N7t/4NgW/qJPLeZiznzbwX6q7yzTv728kcDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lhevtw0YfgKV4wSQNOsz9m1/3dD8AU012Z4Sg0OmjhwjCM4S9bFVeXFHgNd4BHUehGIoTCUPiN6pkoXkg1fPwRAp8Sk6G7j9snaCdMZT8T89FsV2HjXfcIaj82CFCWSqex/QZVzc0BDJtitXHBEvbjL+sleRyIwhT7+N8y3GLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmYuXbLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmYuXbLu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58EC9C2BD10;
	Thu, 20 Jun 2024 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899138;
	bh=sWSXWB4N7t/4NgW/qJPLeZiznzbwX6q7yzTv728kcDE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=EmYuXbLu1/20fopNdDUbO5tEHmgQybhiDTRdta3hJQSkrQCavjGrPbNxQ9WHsYGoJ
	 U7sjc1mvkM9X7Wq6lSq08RphDY+DbIgjiRISmdnrsAnued5rdyv+/MvMPAJheBgNzO
	 AZVff29KUIBNs/EimnS1hnFe2BVwT+BzCl7VyxtWp0R0QhgLFrPTgvRFeyTJwahya7
	 ThpZnG8/Syed7HP0251DDSADLcjQ1Fg6J4D5iPvLfwsr4yNc/RKHwfFBoCLe9kj4U3
	 s93Xb9MJUYNgOdgEIOGv1HMMlNZ049Z5/NPUVA3vwaqA4gYDngYff6LXZFTJmKERGK
	 a9AfM8cx3x26Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E08C2BA1A;
	Thu, 20 Jun 2024 15:58:58 +0000 (UTC)
From: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>
Date: Thu, 20 Jun 2024 22:56:00 +0700
Subject: [PATCH] sparc/build: Make all compiler flags also clang-compatible
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAA9RdGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMD3eKCxKJk3eS0nMT0Yt1U8zSjlKSkFJMkyxQloJaCotS0zAqwcdG
 xtbUA5qLBpV4AAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 glaubitz@physik.fu-berlin.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Koakuma <koachan@protonmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718899135; l=4329;
 i=koachan@protonmail.com; s=20240620; h=from:subject:message-id;
 bh=TPTX/hXnvGP/7Q/0XONtbbKGd6MWmhWh/U9alDskK+Y=;
 b=lh38GZIlN9C76lksV8Ck1O5eb0K5JSJr87+5/LTH1ly8d2aesSmDXIyPPuZubaHwQx4txD/2i
 V2CnGn0gKQnCyMM56PYtjZ0z2keC5F7xp5LyBJQ5E3rmZffWNPuf8jl
X-Developer-Key: i=koachan@protonmail.com; a=ed25519;
 pk=UA59FS3yiAA1cnAAUZ1rehTmr6skh95PgkNRBLcoKCg=
X-Endpoint-Received: by B4 Relay for koachan@protonmail.com/20240620 with
 auth_id=174
X-Original-From: Koakuma <koachan@protonmail.com>
Reply-To: koachan@protonmail.com

From: Koakuma <koachan@protonmail.com>

Remove flags not supported by clang and make sure that all the flags
used are portable between clang and GCC.

The reasoning for removing the -fcall-used* ones is as follows:

In the (normal) 32-bit ABI, %g5 and %g7 is normally reserved, and in
the 64-bit ABI, %g7 is the reserved one.
Linux turns them into volatile registers by the way of -fcall-used-*,
but on the other hand, omitting the flags shouldn't be harmful;
compilers will now simply refuse to touch them, and any assembly
code that happens to touch them would still work like usual (because
Linux' conventions already treats them as volatile anyway).

Signed-off-by: Koakuma <koachan@protonmail.com>
---
Hello~

This changes the CFLAGS for building the SPARC kernel so that it can be
built with clang, as a follow up from the discussion in this thread:

https://lore.kernel.org/lkml/JAYB7uS-EdLABTR4iWZdtFOVa5MvlKosIrD_cKTzgeozCOGRM7lhxeLigFB1g3exX445I_W5VKB-tAzl2_G1zCVJRQjp67ODfsSqiZWOZ9o=@protonmail.com/T/#u

The changes are removal of various `-fcall-used-*` flags, and changing
`-mv8plus` to `-mcpu=v9`:

- `-fcall-used-*` flags should be safe to remove; the compiler will
  stop using the registers specified as temporaries, but it is a safe
  change wrt. the ABI. Assembly code can still use those registers
  as needed.
  It does bring a theoretical possible slowdown due to the compiler
  having less registers to work with, but in practice - in my case,
  at least - it seems to not make any difference with daily usage.

- More trivial is to change `-mv8plus` -> `-mcpu=v9`.
  This should be safe too since the kernel seems to require a V9
  processor to run anyway, so I'm changing the flag to one that is
  portable between GCC and clang.

Also, as stated in the thread, building with these changes still result
in a working kernel, at least for Sun T5120 and qemu virtual machines.

On the LLVM side, the effort for building Linux/SPARC is tracked here:
https://github.com/llvm/llvm-project/issues/40792
---
 arch/sparc/Makefile      | 4 ++--
 arch/sparc/vdso/Makefile | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 757451c3ea1d..7318a8b452c3 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -29,7 +29,7 @@ UTS_MACHINE    := sparc
 # versions of gcc.  Some gcc versions won't pass -Av8 to binutils when you
 # give -mcpu=v8.  This silently worked with older bintutils versions but
 # does not any more.
-KBUILD_CFLAGS  += -m32 -mcpu=v8 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+KBUILD_CFLAGS  += -m32 -mcpu=v8 -pipe -mno-fpu
 KBUILD_CFLAGS  += -Wa,-Av8
 
 KBUILD_AFLAGS  += -m32 -Wa,-Av8
@@ -45,7 +45,7 @@ export BITS   := 64
 UTS_MACHINE   := sparc64
 
 KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow
-KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare
+KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -Wno-sign-compare
 KBUILD_CFLAGS += -Wa,--undeclared-regs
 KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
 KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 243dbfc4609d..929140facabf 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -46,7 +46,7 @@ CFL := $(PROFILING) -mcmodel=medlow -fPIC -O2 -fasynchronous-unwind-tables -m64
        -fno-omit-frame-pointer -foptimize-sibling-calls \
        -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
-SPARC_REG_CFLAGS = -ffixed-g4 -ffixed-g5 -fcall-used-g5 -fcall-used-g7
+SPARC_REG_CFLAGS = -ffixed-g4 -ffixed-g5
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
@@ -86,7 +86,7 @@ KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
-KBUILD_CFLAGS_32 += -mv8plus
+KBUILD_CFLAGS_32 += -mcpu=v9
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
 $(obj)/vdso32.so.dbg: FORCE \

---
base-commit: 92e5605a199efbaee59fb19e15d6cc2103a04ec2
change-id: 20240620-sparc-cflags-e7f2dbbd4b9d

Best regards,
-- 
Koakuma <koachan@protonmail.com>


