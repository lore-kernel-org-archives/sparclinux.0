From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jul 2006 20:42:05 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <20060719.134205.74563314.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Wed, 19 Jul 2006 13:47:09 -0700 (PDT)

> Request for IRQ45 (ESP SCSI) SA_STATIC_ALLOC failed using kmalloc
>=20
> appears benign, guess I'm sensative to the word failed.

This needs investigation.

> VFS: Mounted root (ext2 filesystem) readonly.
>=20
> is fine but=20
>=20
> EXT2-fs error (device sdc3): ext2_check_page: bad entry in directory
> #2: unaligned directory entry - offset=3D0, inode =83918864,
> rec_lenB42, name_len=3D0
>=20
> the file system itself should be fine, 2.4.32 is running on it
> currently

Looks like there is something wrong with ESP on your sun4d,
that error should never occur on a good filesystem.
I doubt anything is wrong with EXT2.
