From: Joshua Kwan <joshk@triplehelix.org>
Date: Sat, 14 Aug 2004 06:58:12 +0000
Subject: parport_pc also broken in 2.4.27
Message-Id: <20040814065812.GA29762@darjeeling.triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ISTR this was also broken before, so no big news.

sparc-linux-gcc -D__KERNEL__ -I/home/joshk/devel/kernel/kernel-2.4/sparc/ke=
rnel-image-sparc-2.4/kernel-source-2.4.27/include -Wall -Wstrict-prototypes=
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -=
m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -DMODULE -DMODVERSIONS -in=
clude /home/joshk/devel/kernel/kernel-2.4/sparc/kernel-image-sparc-2.4/kern=
el-source-2.4.27/include/linux/modversions.h  -nostdinc -iwithprefix includ=
e -DKBUILD_BASENAME=3Dparport_pc  -DEXPORT_SYMTAB -c parport_pc.c
parport_pc.c:63:25: asm/parport.h: No such file or directory
parport_pc.c: In function `parport_pc_epp_read_data':
parport_pc.c:417: warning: use of cast expressions as lvalues is deprecated
parport_pc.c:444: warning: use of cast expressions as lvalues is deprecated
parport_pc.c: In function `parport_pc_epp_write_data':
parport_pc.c:473: warning: use of cast expressions as lvalues is deprecated
parport_pc.c: In function `parport_pc_epp_read_addr':
parport_pc.c:497: warning: use of cast expressions as lvalues is deprecated
parport_pc.c: In function `parport_pc_epp_write_addr':
parport_pc.c:522: warning: use of cast expressions as lvalues is deprecated
parport_pc.c: In function `parport_pc_fifo_write_block_dma':
parport_pc.c:737: warning: implicit declaration of function `disable_dma'
parport_pc.c:738: warning: implicit declaration of function `clear_dma_ff'
parport_pc.c:739: warning: implicit declaration of function `set_dma_mode'
parport_pc.c:740: warning: implicit declaration of function `set_dma_addr'
parport_pc.c:741: warning: implicit declaration of function `set_dma_count'
parport_pc.c:749: warning: implicit declaration of function `enable_dma'
parport_pc.c:778: warning: implicit declaration of function `get_dma_residu=
e'
parport_pc.c: In function `parport_pc_find_ports':
parport_pc.c:2975: warning: implicit declaration of function `parport_pc_fi=
nd_nonpci_ports'
make[4]: *** [parport_pc.o] Error 1
make[4]: Leaving directory `/home/joshk/devel/kernel/kernel-2.4/sparc/kerne=
l-image-sparc-2.4/kernel-source-2.4.27/drivers/parport'
make[3]: *** [_modsubdir_parport] Error 2
make[3]: Leaving directory `/home/joshk/devel/kernel/kernel-2.4/sparc/kerne=
l-image-sparc-2.4/kernel-source-2.4.27/drivers'
make[2]: *** [_mod_drivers] Error 2
make[2]: Leaving directory `/home/joshk/devel/kernel/kernel-2.4/sparc/kerne=
l-image-sparc-2.4/kernel-source-2.4.27'
make[1]: *** [stamp-build] Error 2
make[1]: Leaving directory `/home/joshk/devel/kernel/kernel-2.4/sparc/kerne=
l-image-sparc-2.4/kernel-source-2.4.27'
make: *** [stamps/build-sparc32-stamp] Error 2

--=20
Joshua Kwan

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQR24BKOILr94RG8mAQKpAxAAufTPufMrYHmH++q+BcCS+wdg47jGqejP
aCtdzkm1VdLCMM9iVIUe0aQemYYjbxHYX/auzoV+oTAPajV9QEHdiDzmN3uRu1gE
6jXMlrf5Dv7X6eEC9mE7sH6viuHcVB/pjhINLRTf+BavWQVC0bCT0xCTQ54t/vVH
smRUBv20MH2uLEv+ETF5ep59OeRpkAryeE9eQ2Pw/0vltAXJrBABPfKJmqEnjcGy
/E8xcxbzEYlQdJiQCQyenVgud4YJkwDiOPSZg8hdisE+5TYhbNICObDJPDFUJi79
kTlOT1KToqd87arjiVvaXHXug9qZPbpH38nC8TWOJr4JzXmLu8DW7iYf0RDbMbnz
Llq7/7o+T6vxjZEgac4eEySdmZtfrg+bzutFxHxvK9a+wILzOa8TlYzG6fv04d4S
K94E4Q+CcLdd1ZsCGa4NxPMkVhYawPIPgMSHrvnIqLGg/4TgoBSmUNQT6xSXCfTv
LQxfE8iD77Spj6J68iEAdYXSqJM+ue1NE8iJ1r6WBJAJ8bpKj6u/i1DE9nbpTp5U
KIbqfecatjtF5LqLMcz/IRtQMPvyVtOJd5bf1w1JrCb8sJWCNXn28PstBWy3pPza
WFHtPmlpr0EtP5OMhkaIsap/rffG6eWAifTf3+V4Pyf3dj8f+wxjbkpQX4l3pxTL
p9B3BNExmVs=
=0ljx
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
