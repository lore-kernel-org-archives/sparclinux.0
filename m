From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 21 Sep 2020 15:14:56 +0000
Subject: Re: [PATCH 05/11] iov_iter: merge the compat case into rw_copy_check_uvector
Message-Id: <20200921151456.GV3421308@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200921143434.707844-1-hch@lst.de>
 <20200921143434.707844-6-hch@lst.de>
In-Reply-To: <20200921143434.707844-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Mon, Sep 21, 2020 at 04:34:28PM +0200, Christoph Hellwig wrote:
> +static int compat_copy_iovecs_from_user(struct iovec *iov,
> +		const struct iovec __user *uvector, unsigned long nr_segs)
> +{
> +	const struct compat_iovec __user *uiov > +		(const struct compat_iovec __user *)uvector;
> +	unsigned long i;
	         ^^^^
Huh?
