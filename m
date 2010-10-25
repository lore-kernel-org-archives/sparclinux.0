From: Namhyung Kim <namhyung@gmail.com>
Date: Mon, 25 Oct 2010 16:07:29 +0000
Subject: Re: [PATCH 3/3] sparc32: fix build failure on CONFIG_SPARC_LEON
Message-Id: <1288022849.1689.14.camel@leonhard>
List-Id: <sparclinux.vger.kernel.org>
References: <1288021958-3130-1-git-send-email-namhyung@gmail.com>
	 <1288021958-3130-3-git-send-email-namhyung@gmail.com>
	 <20101025.090043.71110898.davem@davemloft.net>
In-Reply-To: <20101025.090043.71110898.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

2010-10-25 (=EC=9B=94), 09:00 -0700, David Miller:
> From: Namhyung Kim <namhyung@gmail.com>
> Date: Tue, 26 Oct 2010 00:52:38 +0900
>=20
> >   CC      arch/sparc/kernel/irq_32.o
> > arch/sparc/kernel/irq_32.c: In function 'request_fast_irq':
> > arch/sparc/kernel/irq_32.c:370:25: error: conflicting types for 'trapba=
se_cpu1'
>=20
> I doubt SMP LEON chips even exist, so better to just anti-dep
> this in arch/sparc/Kconfig

If I understood correctly, you meant this?


diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 4db8bc0..a6685ba 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -463,7 +463,7 @@ config SERIAL_CONSOLE
=20
 config SPARC_LEON
        bool "Sparc Leon processor family"
-       depends on SPARC32
+       depends on SPARC32 && !SMP
        ---help---
          If you say Y here if you are running on a SPARC-LEON
processor.
          The LEON processor is a synthesizable VHDL model of the


--=20
Regards,
Namhyung Kim


