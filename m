From: Joerg Platte <lists@naasa.net>
Date: Sun, 11 Apr 2004 15:36:06 +0000
Subject: srmmu: out of nocache
Message-Id: <200404111736.06841.lists@naasa.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200403282153.19509.lists@naasa.net>
In-Reply-To: <200403282153.19509.lists@naasa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi!

This happens with a 2.6.5er kernel with the following patch applied:

=3D=3D=3D arch/sparc/lib/bitext.c 1.1 vs edited =3D=3D--- 1.1/arch/sparc/li=
b/bitext.c Wed Apr 30 01:05:41 2003
+++ edited/arch/sparc/lib/bitext.c      Thu Apr  1 01:57:22 2004
@@ -60,8 +60,8 @@
                }

                if (offset + len > t->size) {
-                       offset =3D 0;
                        count +=3D t->size - offset;
+                       offset =3D 0;
                        continue;
                }


Apr 11 15:05:10 ferdi kernel: bitmap out: size 8800 used 6268 off 8016 len =
16=20
align 16 count 8816
Apr 11 15:05:10 ferdi kernel: srmmu: out of nocache 4096: 2252800/1604608
Apr 11 15:05:14 ferdi kernel: bitmap out: size 8800 used 6305 off 7456 len =
16=20
align 16 count 8816
Apr 11 15:05:14 ferdi postfix/master[424]: warning: master_spawn: fork: Can=
not=20
allocate memory -- throttling
Apr 11 15:05:14 ferdi kernel: srmmu: out of nocache 4096: 2252800/1614080
Apr 11 15:05:15 ferdi kernel: bitmap out: size 8800 used 6310 off 2400 len =
16=20
align 16 count 8816
Apr 11 15:05:15 ferdi kernel: srmmu: out of nocache 4096: 2252800/1615360
Apr 11 15:05:15 ferdi kernel: bitmap out: size 8800 used 6315 off 2432 len =
16=20
align 16 count 8816
Apr 11 15:05:15 ferdi kernel: srmmu: out of nocache 4096: 2252800/1616640
Apr 11 15:05:15 ferdi spamd[279]: cannot fork: Cannot allocate memory=20
Apr 11 15:05:29 ferdi kernel: bitmap out: size 8800 used 6285 off 7632 len =
16=20
align 16 count 8816

ferdi has 128MB memory...=20

regards,
J=F6rg
