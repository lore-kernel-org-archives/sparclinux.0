From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 21 Sep 2020 15:20:02 +0000
Subject: Re: [PATCH 06/11] iov_iter: handle the compat case in import_iovec
Message-Id: <20200921152002.GW3421308@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200921143434.707844-1-hch@lst.de>
 <20200921143434.707844-7-hch@lst.de>
In-Reply-To: <20200921143434.707844-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Mon, Sep 21, 2020 at 04:34:29PM +0200, Christoph Hellwig wrote:
> Use in compat_syscall to import either native or the compat iovecs, and
> remove the now superflous compat_import_iovec, which removes the need for
> special compat logic in most callers.  Only io_uring needs special
> treatment given that it can call import_iovec from kernel threads acting
> on behalf of native or compat syscalls.  Expose the low-level
> __import_iovec helper and use it in io_uring to explicitly pick a iovec
> layout.

fs/aio.c part is not obvious...  Might be better to use __import_iovec()
there as well and leave the rest of aio.c changes to followup.

> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1683,7 +1683,7 @@ static int compat_copy_iovecs_from_user(struct iovec *iov,
>  	return ret;
>  }
>  
> -static ssize_t __import_iovec(int type, const struct iovec __user *uvector,
> +ssize_t __import_iovec(int type, const struct iovec __user *uvector,
>  		unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
>  		struct iov_iter *i, bool compat)
>  {

Don't make it static in the first place, perhaps?
