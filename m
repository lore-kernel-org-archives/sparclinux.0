From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Sat, 26 Jun 2004 10:11:23 +0000
Subject: DMA_AUTOINIT missing in asm-sparc64/dma.h
Message-Id: <1088244683.12842.45.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-OmnMDntJSgvtgLT0F47X"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-OmnMDntJSgvtgLT0F47X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was going to test out various PCI sound cards I've had lying around
when I noticed that DMA_AUTOINIT isn't defined in asm-sparc64/dma.h like
it is in other archs... most archs defined it as 2 while arm defines it
as 4.


  CC [M]  sound/oss/dmabuf.o
sound/oss/dmabuf.c: In function `sound_start_dma':
sound/oss/dmabuf.c:155: warning: implicit declaration of function
`disable_dma'
sound/oss/dmabuf.c:156: warning: implicit declaration of function
`clear_dma_ff'
sound/oss/dmabuf.c:157: warning: implicit declaration of function
`set_dma_mode'
sound/oss/dmabuf.c:158: warning: implicit declaration of function
`set_dma_addr'
sound/oss/dmabuf.c:159: warning: implicit declaration of function
`set_dma_count'
sound/oss/dmabuf.c:160: warning: implicit declaration of function
`enable_dma'
sound/oss/dmabuf.c: In function `DMAbuf_get_buffer_pointer':
sound/oss/dmabuf.c:653: warning: implicit declaration of function
`get_dma_residue'
sound/oss/dmabuf.c: In function `local_start_dma':
sound/oss/dmabuf.c:943: error: `DMA_AUTOINIT' undeclared (first use in
this function)
sound/oss/dmabuf.c:943: error: (Each undeclared identifier is reported
only once
sound/oss/dmabuf.c:943: error: for each function it appears in.)
make[2]: *** [sound/oss/dmabuf.o] Error 1
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2

/usr/src/linux $ grep -nR DMA_AUTOINIT .
./arch/arm/kernel/dma-isa.c:31:#define ISA_DMA_AUTOINIT 0x10
./arch/arm/kernel/dma-isa.c:121:                if (dma->dma_mode &
DMA_AUTOINIT)
./arch/arm/kernel/dma-isa.c:122:                        mode |=3D
ISA_DMA_AUTOINIT;
./include/asm-ppc64/dma.h:150:#define DMA_AUTOINIT       0x10
./include/asm-m68k/apollodma.h:120:#define DMA_AUTOINIT 0x10
./include/asm-parisc/dma.h:43:#define DMA_AUTOINIT     0x10
./include/asm-mips/dma.h:151:#define DMA_AUTOINIT       0x10
./include/asm-ppc/dma.h:176:#define DMA_AUTOINIT                0x10
./include/asm-x86_64/dma.h:135:#define DMA_AUTOINIT     0x10
./include/asm-arm/dma.h:23:#define DMA_AUTOINIT  4
./include/asm-alpha/dma.h:197:#define DMA_AUTOINIT      0x10
./include/asm-i386/dma.h:135:#define DMA_AUTOINIT       0x10
./include/asm-arm26/dma.h:77:#define DMA_AUTOINIT        4
./include/asm-sh/mpc1211/dma.h:135:#define DMA_AUTOINIT 0x10
./include/asm/dma.h:135:#define DMA_AUTOINIT    0x10
./sound/oss/dmabuf.c:943:       sound_start_dma(dmap,
dmap->raw_buf_phys, dmap->bytes_in_use, dma_mode | DMA_AUTOINIT);
./sound/oss/os.h:48:#undef PSEUDO_DMA_AUTOINIT
./sound/pci/ice1712/ice1712.h:210:#define ICE1712_DMA_AUTOINIT        =20
0x10
./sound/pci/ice1712/ice1712.c:595:      outb(ICE1712_DMA_MODE_WRITE |
ICE1712_DMA_AUTOINIT, ice->ddma_port + 0x0b);
<./sound/isa snipped>

--=-OmnMDntJSgvtgLT0F47X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3UvLgKpk8srJOlIRAkgFAKCgg5vZrhnTjBnSAUWiyupzaFXuGQCfSWa2
a7rmJP5AuY7fd6T2KGhzINk=
=Xdpc
-----END PGP SIGNATURE-----

--=-OmnMDntJSgvtgLT0F47X--

