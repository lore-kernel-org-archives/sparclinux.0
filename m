From: Jason Wever <weeve@gentoo.org>
Date: Tue, 06 Apr 2004 00:53:32 +0000
Subject: [PATCH] Add SND_PCM dep to SND_BIT32_EMUL for 2.6
Message-Id: <20040405185332.58a4b3b0@excelsior.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__5_Apr_2004_18_53_32_-0600_DQSiAzjMnl/0UWxv"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature=_Mon__5_Apr_2004_18_53_32_-0600_DQSiAzjMnl/0UWxv
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__5_Apr_2004_18_53_32_-0600_2zIADGifs/KfsFNo"


--Multipart=_Mon__5_Apr_2004_18_53_32_-0600_2zIADGifs/KfsFNo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Small 2.6 Kconfig patch for SND_BIT32_EMUL since it depends on symbols
provided by SND_PCM.  Good way to generate this error is to build
SND_BIT32_EMUL into the kernel but have SND_PCM as a module.

-- 
Jason Wever
Gentoo/Sparc Team Co-Lead


--Multipart=_Mon__5_Apr_2004_18_53_32_-0600_2zIADGifs/KfsFNo
Content-Type: text/x-patch;
 name="ioctl32-kconfig.patch"
Content-Disposition: attachment;
 filename="ioctl32-kconfig.patch"
Content-Transfer-Encoding: 7bit

--- sound/core/Kconfig.orig	2004-04-05 18:05:53.058572000 -0600
+++ sound/core/Kconfig	2004-04-05 18:06:10.538572000 -0600
@@ -1,7 +1,7 @@
 # ALSA soundcard-configuration
 config SND_BIT32_EMUL
 	tristate "Emulation for 32-bit applications"
-	depends on SND && (SPARC64 || PPC64 || X86_64 && IA32_EMULATION)
+	depends on SND && SND_PCM &&(SPARC64 || PPC64 || X86_64 && IA32_EMULATION)
 
 config SND_TIMER
 	tristate


--Multipart=_Mon__5_Apr_2004_18_53_32_-0600_2zIADGifs/KfsFNo--

--Signature=_Mon__5_Apr_2004_18_53_32_-0600_DQSiAzjMnl/0UWxv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcf+MdKvgdVioq28RAuQlAKCGezb0IkRiqfupqfa0MNYzNd4RsQCfW07M
lvpQJeS1CM6GhLyaQvE61Ng=
=HSyr
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Apr_2004_18_53_32_-0600_DQSiAzjMnl/0UWxv--
