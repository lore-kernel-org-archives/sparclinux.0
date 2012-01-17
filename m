From: David Miller <davem@davemloft.net>
Date: Tue, 17 Jan 2012 18:51:51 +0000
Subject: Re: silo fails to build with recent ext2fs libraries
Message-Id: <20120117.135151.101864466578556251.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120115140938.GA7564@wooyd.org>
In-Reply-To: <20120115140938.GA7564@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 17 Jan 2012 12:56:56 -0500 (EST)

> I'm looking into the rest.

So just adding the stubs (or your idea, linking with libc) doesn't
work at all.

All the new features in libext2 that get linked in cause the second
stage bootloader image to grow too large.

I'll just have to extract the parts of libext2 that we actually need
into a stripped down local copy in SILO and I guess this will make
us immune to this issue showing up again in the future.
