From: Raymond Burns <rayburns@comcast.net>
Date: Mon, 31 Jul 2006 04:33:28 +0000
Subject: sparc32: git sun4d fs cache page and dma
Message-Id: <Pine.LNX.4.10.10607301951200.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi

was Re: sparc32: git SCSI and fs

I did my homework, you were correct.

EXT2-fs error (device sdc3): ext2_check_page: bad entry in directory
#2: unaligned directory entry - offset=3D0, inode =83918864,
rec_lenB42, name_len=3D0


On Fri, 21 Jul 2006, David Miller wrote:

> More likely DMA is being corrupted or similar, and this
> means you should fiddle around in the sun4d IOMMU support
> code for SBUS and make sure nothing fishy is going on there.
>=20

sun4d is using the io-unit.c code for dma setup and teardown, that
code is not yet updated to use sg->page as targets for dma transfers
and returning the same for file system use.

Barring other suggestions I'll debug my way to a patch using the
routines in iommu.c as models.

or are the needs of sun4m and sun4d enough alike at this point to
merge more of the common code ?=20

Thanx
  Ray



