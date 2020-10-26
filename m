From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 26 Oct 2020 23:56:11 +0000
Subject: Re: [REGRESSION] mm: process_vm_readv testcase no longer works after compat_prcoess_vm_readv removed
Message-Id: <70d5569e-4ad6-988a-e047-5d12d298684c@kernel.dk>
List-Id: <sparclinux.vger.kernel.org>
References: <CAP045Aqrsb=CXHDHx4nS-pgg+MUDj14r-kN8_Jcbn-NAUziVag@mail.gmail.com>
In-Reply-To: <CAP045Aqrsb=CXHDHx4nS-pgg+MUDj14r-kN8_Jcbn-NAUziVag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kyle Huey <me@kylehuey.com>, open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Robert O'Callahan <robert@ocallahan.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On 10/26/20 4:55 PM, Kyle Huey wrote:
> A test program from the rr[0] test suite, vm_readv_writev[1], no
> longer works on 5.10-rc1 when compiled as a 32 bit binary and executed
> on a 64 bit kernel. The first process_vm_readv call (on line 35) now
> fails with EFAULT. I have bisected this to
> c3973b401ef2b0b8005f8074a10e96e3ea093823.
> 
> It should be fairly straightforward to extract the test case from our
> repository into a standalone program.

Can you check with this applied?

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index fd12da80b6f2..05676722d9cd 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -273,7 +273,8 @@ static ssize_t process_vm_rw(pid_t pid,
 		return rc;
 	if (!iov_iter_count(&iter))
 		goto free_iov_l;
-	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r, false);
+	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r,
+				in_compat_syscall());
 	if (IS_ERR(iov_r)) {
 		rc = PTR_ERR(iov_r);
 		goto free_iov_l;

-- 
Jens Axboe
