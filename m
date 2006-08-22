From: Raymond Burns <rayburns@comcast.net>
Date: Tue, 22 Aug 2006 03:36:05 +0000
Subject: Re: sparc32: git sun4d fs cache page and dma
Message-Id: <Pine.LNX.4.10.10608211822510.13896-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607301951200.10727-100000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607301951200.10727-100000@coalcreekmill.cm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi

(the topic reminder)
EXT2-fs error (device sdc3): ext2_check_page: bad entry in directory
#2: unaligned directory entry - offset=3D0, inode=83918864,
rec_lenB42, name_len=3D0

It appears this occurs when iounit_get_area() is fed a vaddr of 0.

vaddr in this case is from a page_address() of a page freshly
aloquated by __alloc_pages() . kmap later sets an address of FC801000
to the page which is where the error data comes from.

My guess is that something in free_initmem() is trashing the page
cache supply or something isn't getting (re)initialized correctly.

All other pages returned by __alloc_pages() have addresses. all page
pointers are in the range f089edc0-f089d1a0 this is the first page
aloquated from another area at f0c7cac0.


A gentle shove in a direction to look would be nice about right here.


I did dig through the radix_tree stuff, the inodes are getting
initialized.

The non ext2 code is working prior to free_initmem(), the error is
occurring after (at least):
9 hits to the scsi drives
80 hits to iounit_get_area()
178 hits to esp_get_dmabufs()
etc.

The ext2 superblock operations and mounting the file system read only
work fine. There are a lot things using the esp and io-unit.c, code
that are working correctly.

I caused 2.4.32 to print it's values at the same point, a sanity check
directory #2 offset=3D0, inode=3D2, rec_len=12, name_len=3D1


I have plenty of printk data showing calls and data along the way.

Thanx
  Ray


