From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 21 Sep 2020 15:11:19 +0000
Subject: Re: [PATCH 04/11] iov_iter: explicitly check for CHECK_IOVEC_ONLY in rw_copy_check_uvector
Message-Id: <20200921151119.GU3421308@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200921143434.707844-1-hch@lst.de>
 <20200921143434.707844-5-hch@lst.de>
 <7336624280b8444fb4cb00407317741b@AcuMS.aculab.com>
In-Reply-To: <7336624280b8444fb4cb00407317741b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Laight <David.Laight@aculab.com>
Cc: 'Christoph Hellwig' <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

On Mon, Sep 21, 2020 at 03:05:32PM +0000, David Laight wrote:

> I've actually no idea:
> 1) Why there is an access_ok() check here.
>    It will be repeated by the user copy functions.

Early sanity check.

> 2) Why it isn't done when called from mm/process_vm_access.c.
>    Ok, the addresses refer to a different process, but they
>    must still be valid user addresses.
> 
> Is 2 a legacy from when access_ok() actually checked that the
> addresses were mapped into the process's address space?

It never did.  2 is for the situation when a 32bit process
accesses 64bit one; addresses that are perfectly legitimate
for 64bit userland (and fitting into the first 4Gb of address
space, so they can be represented by 32bit pointers just fine)
might be rejected by access_ok() if the caller is 32bit.
