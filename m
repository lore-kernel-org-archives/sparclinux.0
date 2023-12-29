Received: from mailrelay5-1.pub.mailoutpod3-cph3.one.com (mailrelay5-1.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DD13FE1
	for <sparclinux@vger.kernel.org>; Fri, 29 Dec 2023 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="T1OqExGz";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="mvLTOYQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=OBDlXXL+0E05xTGTlvy9f5xPcZvRbYslKFVDrl+AoDQ=;
	b=T1OqExGz0ugg6D0vr98I9QtANQPbXRysa5viVl7iF0Uvba1laSWzzQeauVbSbqxsIN8YScdslUMLJ
	 Vyb4N4/OfQK7YwhaACrAe/sNzQHj/EVcJLt/DP/jbZDrAz9SI1bMXn5+YG6rTfptvWs3HSbO/qWTV1
	 mHlFkJcpbB30Ux/3ZKaCIPYd4WPk2okCpbPAlLmSC5dKUtiq7MhStDKxVYOox85+v6aWJAY1xoWvhB
	 vU3YW5oHh3+KZlHaB/jvGQ+sATUX9Rcayv0/GyaALdc+Mgq0FkuLGPnnM4qfl8FPKh4Exdt0E+p9HW
	 V8kmXMaddGy74TMlrZ9S15HVkcN/vSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=OBDlXXL+0E05xTGTlvy9f5xPcZvRbYslKFVDrl+AoDQ=;
	b=mvLTOYQ4eUlX+x8cuBxi5ma1IjN6rWoOlD5p0fiZXNoOsLkjILagbglHXEfpxz+f1nZQ5R6gxDgC2
	 d7fxT6ZDw==
X-HalOne-ID: e2416407-a685-11ee-b51c-2b77c2ae2e64
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5 (Halon) with ESMTPSA
	id e2416407-a685-11ee-b51c-2b77c2ae2e64;
	Fri, 29 Dec 2023 20:07:27 +0000 (UTC)
Date: Fri, 29 Dec 2023 21:07:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: [PATCH 1/4] sparc32: Add support for specifying -mcpu
Message-ID: <20231229200726.GA4034411@ravnborg.org>
References: <20231229200604.GA4033529@ravnborg.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229200604.GA4033529@ravnborg.org>

Add support for selecting the CPU architecture.
The default is leon3 - which is the minimum required as the kernel uses
CAS instructions.

Inspired by (from gaisler-buildroot-2023.02-1.0):
    0001-sparc32-leon-Build-with-mcpu-leon3-for-SPARC_LEON.patch
    0028-sparc32-leon-Make-what-mcpu-to-be-used-configurable-.patch

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/Kconfig  | 24 ++++++++++++++++++++++++
 arch/sparc/Makefile | 13 +++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 1b9cf7f3c500..e94783ceb409 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -161,6 +161,30 @@ config ARCH_SUPPORTS_UPROBES
 
 menu "Processor type and features"
 
+choice
+	prompt "LEON architecture"
+	default SPARC_CPU_LEON3
+	help
+	  Select the architecture the kernel shall be built for
+
+config SPARC_CPU_LEON3
+	prompt "LEON 3"
+	help
+	  Build the kernel for the LEON 3 architecture
+
+config SPARC_CPU_LEON5
+	prompt "LEON 5"
+	help
+	  Build the kernel for the LEON 5 architecture
+
+config SPARC_CPU_DEFAULT
+	bool "Toolchain default"
+	help
+	  Build the kernel with no -mcpu option, getting the default
+	  for the toolchain that is being used.
+
+endchoice
+
 config SMP
 	bool "Symmetric multi-processing support"
 	help
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 5f6035936131..3c3a1fd8c873 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -25,14 +25,11 @@ KBUILD_LDFLAGS := -m elf32_sparc
 export BITS    := 32
 UTS_MACHINE    := sparc
 
-# We are adding -Wa,-Av8 to KBUILD_CFLAGS to deal with a specs bug in some
-# versions of gcc.  Some gcc versions won't pass -Av8 to binutils when you
-# give -mcpu=v8.  This silently worked with older bintutils versions but
-# does not any more.
-KBUILD_CFLAGS  += -m32 -mcpu=v8 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
-KBUILD_CFLAGS  += -Wa,-Av8
-
-KBUILD_AFLAGS  += -m32 -Wa,-Av8
+cpuflags-$(CONFIG_SPARC_CPU_LEON3)	:= -mcpu=leon3
+cpuflags-$(CONFIG_SPARC_CPU_LEON5)	:= -mcpu=leon5
+
+KBUILD_CFLAGS  += -m32 $(cpuflags-y) -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+KBUILD_AFLAGS  += -m32 $(cpuflags-y)
 
 else
 #####
-- 
2.34.1

