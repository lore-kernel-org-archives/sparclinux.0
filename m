From: Raymond Burns <rayburns@comcast.net>
Date: Wed, 19 Jul 2006 20:47:09 +0000
Subject: sparc32: git SCSI and fs
Message-Id: <Pine.LNX.4.10.10607191248020.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi

during scsi initialization the message=20

Request for IRQ45 (ESP SCSI) SA_STATIC_ALLOC failed using kmalloc

appears benign, guess I'm sensative to the word failed.


VFS: Mounted root (ext2 filesystem) readonly.

is fine but=20

EXT2-fs error (device sdc3): ext2_check_page: bad entry in directory
#2: unaligned directory entry - offset=3D0, inode =83918864,
rec_lenB42, name_len=3D0

the file system itself should be fine, 2.4.32 is running on it
currently

this is non-SMP and my erroneous slab path reversed.

access to the disks fail so user land is unreachable


I have the feeling ext2 is not a good choice for sparc, are there
suggestions.

the ext2 will probably still need to work, I'm digging.


Thanx
  Ray



