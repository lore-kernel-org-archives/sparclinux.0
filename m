From: Sven Blumenstein <bazik@gentoo.org>
Date: Tue, 16 Mar 2004 23:38:45 +0000
Subject: [PATCH] permedia2 fb driver in 2.6.4 & 2.6.5-rc1
Message-Id: <40579005.5030909@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigC5767FB82D2CD1AD7127E2A5"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5767FB82D2CD1AD7127E2A5
Content-Type: multipart/mixed;
 boundary="------------080108020709010608060005"

This is a multi-part message in MIME format.
--------------080108020709010608060005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Permedia 2 framebuffer driver fails to compile (on sparc64):

   CC      drivers/video/pm2fb.o
   drivers/video/pm2fb.c: In function `set_aperture':
   drivers/video/pm2fb.c:444: error: structure has no member named `depth'
   make[2]: *** [drivers/video/pm2fb.o] Error 1
   make[1]: *** [drivers/video] Error 2
   make: *** [drivers] Error 2


Bloated patch to fix it attached ;)

-- 
    .".
    /V\   Sven "bazik" Blumenstein
   // \\   Gentoo Linux SPARC Developer
  /(   )\   http://www.gentoo.org
   ^'~'^


--------------080108020709010608060005
Content-Type: text/plain;
 name="pm2fb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm2fb.patch"

--- drivers/video/pm2fb.c.org   2004-03-17 01:28:15.000000000 +0100
+++ drivers/video/pm2fb.c       2004-03-17 01:29:10.000000000 +0100
@@ -102,6 +102,7 @@
        unsigned char*  v_regs;         /* virtual address of p_regs */
        u32             memclock;       /* memclock */
        u32             video;          /* video flags before blanking */
+       u32             depth;		/* screen depth (8, 16, 24 or 32) */
 };
 
 /*


--------------080108020709010608060005--

--------------enigC5767FB82D2CD1AD7127E2A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAV5ALCpH3ts0rhZURAsanAKCCzxgea4UC5w6JVVHwBMswtPFOAwCbBkTa
G+UelyWQvILs4ahshT++0ew=
=gZyB
-----END PGP SIGNATURE-----

--------------enigC5767FB82D2CD1AD7127E2A5--
