From: Kyle Huey <me@kylehuey.com>
Date: Mon, 26 Oct 2020 22:55:13 +0000
Subject: [REGRESSION] mm: process_vm_readv testcase no longer works after compat_prcoess_vm_readv removed
Message-Id: <CAP045Aqrsb=CXHDHx4nS-pgg+MUDj14r-kN8_Jcbn-NAUziVag@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Robert O'Callahan <robert@ocallahan.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

A test program from the rr[0] test suite, vm_readv_writev[1], no
longer works on 5.10-rc1 when compiled as a 32 bit binary and executed
on a 64 bit kernel. The first process_vm_readv call (on line 35) now
fails with EFAULT. I have bisected this to
c3973b401ef2b0b8005f8074a10e96e3ea093823.

It should be fairly straightforward to extract the test case from our
repository into a standalone program.

- Kyle

[0] https://rr-project.org/
[1] https://github.com/mozilla/rr/blob/master/src/test/vm_readv_writev.c
