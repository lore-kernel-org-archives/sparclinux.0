From: Jason Wever <weeve@gentoo.org>
Date: Tue, 06 Apr 2004 05:12:29 +0000
Subject: [PATCH] Add amd7930 to include/sound/sndmagic.h
Message-Id: <20040405231229.4ae000fe@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__5_Apr_2004_23_12_29_-0600_P40ND6XeCASoXSDO"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature=_Mon__5_Apr_2004_23_12_29_-0600_P40ND6XeCASoXSDO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

The included patch adds amd7930 to the include/sound/sndmagic.h in 2.6,
allowing the sun-snd-amd7930 driver to build.

According to the ALSA doc about writing drivers, the define in sndmagic.h
doesn't need to be a particular value as long as it is
unique, so that is what I did here.

--- include/sound/sndmagic.h.orig	2004-04-05 22:53:41.000000000 -0600
+++ include/sound/sndmagic.h	2004-04-05 22:53:03.000000000 -0600
@@ -203,6 +203,7 @@
 #define pdacf_t_magic				0xa15a4500
 #define vortex_t_magic				0xa15a4601
 #define atiixp_t_magic				0xa15a4701
+#define amd7930_t_magic				0xa15a4801
 
 #else
 
-- 
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature=_Mon__5_Apr_2004_23_12_29_-0600_P40ND6XeCASoXSDO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcjw9dKvgdVioq28RAqPJAJ9+G5QDu6GA1VuGJJn4aCl14SRtLACghfQj
E1sBxaseJ/7zexWUiMHIax4=
=IGxH
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Apr_2004_23_12_29_-0600_P40ND6XeCASoXSDO--
