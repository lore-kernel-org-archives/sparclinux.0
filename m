From: Raymond Burns <rayburns@comcast.net>
Date: Thu, 20 Jul 2006 02:50:18 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <Pine.LNX.4.10.10607191940550.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, 19 Jul 2006, David Miller wrote:

> > Request for IRQ45 (ESP SCSI) SA_STATIC_ALLOC failed using kmalloc
>=20
> This needs investigation.

This is the fifth call to request_irq() so I guess it is correct
(esp2-5 get kmalloc())

there is one improper call to request_irq() in sunzilog_init() where
it looks for zilog_irq !=3D -1, it should be equal -1 to request

>=20
> > VFS: Mounted root (ext2 filesystem) readonly.
> >=20
> > is fine but=20
> >=20
> > EXT2-fs error (device sdc3): ext2_check_page: bad entry in directory
> > #2: unaligned directory entry - offset=3D0, inode =83918864,
> > rec_lenB42, name_len=3D0
> >=20
> Looks like there is something wrong with ESP on your sun4d,
> that error should never occur on a good filesystem.
> I doubt anything is wrong with EXT2.

I concur.
=20
I'm digging.

Thanx
  Ray


