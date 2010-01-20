From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 20 Jan 2010 11:26:59 +0000
Subject: Re: [PATCH]: sparc64: Add perf callchain support.
Message-Id: <20100120112659.GB13771@kernel.dk>
List-Id: <sparclinux.vger.kernel.org>
References: <20100119.002645.70252139.davem@davemloft.net>
In-Reply-To: <20100119.002645.70252139.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 19 2010, David Miller wrote:
> 
> Pretty straightforward, and it should be easy to add accurate
> walk through of signal stack frames in userspace.

I tested it, works for me. Thanks Dave! You can add my Tested-by, if you
wish.

-- 
Jens Axboe

