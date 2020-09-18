From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 18 Sep 2020 12:56:11 +0000
Subject: Re: [PATCH 3/9] fs: explicitly check for CHECK_IOVEC_ONLY in rw_copy_check_uvector
Message-Id: <20200918125611.GE32101@casper.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-4-hch@lst.de>
In-Reply-To: <20200918124533.3487701-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Sep 18, 2020 at 02:45:27PM +0200, Christoph Hellwig wrote:
>  		}
> -		if (type >= 0
> -		    && unlikely(!access_ok(buf, len))) {
> +		if (type != CHECK_IOVEC_ONLY && unlikely(!access_ok(buf, len))) {

drop the unlikely() at the same time?  if it's really advantageous,
that should be embedded in the access_ok macro.
