From: Jason Wever <weeve@gentoo.org>
Date: Tue, 06 Apr 2004 01:46:13 +0000
Subject: Re: [PATCH] Add SND_PCM dep to SND_BIT32_EMUL for 2.6
Message-Id: <20040405194613.26e2f1cd@excelsior.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__5_Apr_2004_19_46_13_-0600_s6iD64QyYIuriLOb"
List-Id: <sparclinux.vger.kernel.org>
References: <20040405185332.58a4b3b0@excelsior.weeve.org>
In-Reply-To: <20040405185332.58a4b3b0@excelsior.weeve.org>
To: sparclinux@vger.kernel.org

--Signature=_Mon__5_Apr_2004_19_46_13_-0600_s6iD64QyYIuriLOb
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__5_Apr_2004_19_46_13_-0600_2i_BYd.agNKYixgH"


--Multipart=_Mon__5_Apr_2004_19_46_13_-0600_2i_BYd.agNKYixgH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 5 Apr 2004 18:53:32 -0600
Jason Wever <weeve@gentoo.org> wrote:

> Small 2.6 Kconfig patch for SND_BIT32_EMUL since it depends on symbols
> provided by SND_PCM.  Good way to generate this error is to build
> SND_BIT32_EMUL into the kernel but have SND_PCM as a module.

Same patch, but with proper spacing this time.

-- 
Jason Wever
Gentoo/Sparc Team Co-Lead

--Multipart=_Mon__5_Apr_2004_19_46_13_-0600_2i_BYd.agNKYixgH
Content-Type: text/x-patch;
 name="ioctl32-kconfig.patch"
Content-Disposition: attachment;
 filename="ioctl32-kconfig.patch"
Content-Transfer-Encoding: 7bit

--- sound/core/Kconfig.orig	2004-04-05 18:05:53.058572000 -0600
+++ sound/core/Kconfig	2004-04-05 19:32:41.828572000 -0600
@@ -1,7 +1,7 @@
 # ALSA soundcard-configuration
 config SND_BIT32_EMUL
 	tristate "Emulation for 32-bit applications"
-	depends on SND && (SPARC64 || PPC64 || X86_64 && IA32_EMULATION)
+	depends on SND && SND_PCM && (SPARC64 || PPC64 || X86_64 && IA32_EMULATION)
 
 config SND_TIMER
 	tristate

--Multipart=_Mon__5_Apr_2004_19_46_13_-0600_2i_BYd.agNKYixgH--

--Signature=_Mon__5_Apr_2004_19_46_13_-0600_s6iD64QyYIuriLOb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcgvldKvgdVioq28RAhrYAJ9AcApKWeGyymCFAxnu00thqZbLhwCeNlvQ
LENDhu4LpZJPIVh7HjEVTC4=
=2i8d
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Apr_2004_19_46_13_-0600_s6iD64QyYIuriLOb--
