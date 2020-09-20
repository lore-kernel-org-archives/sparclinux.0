From: Matthew Wilcox <willy@infradead.org>
Date: Sun, 20 Sep 2020 19:22:59 +0000
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-Id: <20200920192259.GU32101@casper.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-2-hch@lst.de>
 <20200920151510.GS32101@casper.infradead.org>
 <20200920180742.GN3421308@ZenIV.linux.org.uk>
 <20200920190159.GT32101@casper.infradead.org>
 <20200920191031.GQ3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200920191031.GQ3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Sun, Sep 20, 2020 at 08:10:31PM +0100, Al Viro wrote:
> IMO it's much saner to mark those and refuse to touch them from io_uring...

Simpler solution is to remove io_uring from the 32-bit syscall list.
If you're a 32-bit process, you don't get to use io_uring.  Would
any real users actually care about that?
