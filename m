From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 17 Apr 2007 14:59:58 +0000
Subject: [patch] sparc32 makefile
Message-Id: <4624E0EE.3010003@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

	Hello,

	Trivial patch to reduce size of sparc32 kernel.

Signed-off-by: Jo=EBl Bertrand <jkb@systella.fr>

--- a/arch/sparc/boot/Makefile  2007-03-16 01:20:01.000000000 +0100
+++ b/arch/sparc/boot/Makefile  2007-04-17 16:48:55.000000000 +0200
@@ -49,6 +49,7 @@
  # these files being recompiled for each build.
  $(obj)/image: $(obj)/btfix.o FORCE
         $(call if_changed_rule,image)
+       strip -R .indent -R .comment -R .note $(obj)/image -o=20
vmlinux.stripped

  $(obj)/tftpboot.img: $(obj)/piggyback $(obj)/System.map $(obj)/image FORCE
         $(call if_changed,elftoaout)
