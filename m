From: Frans Pop <elendil@planet.nl>
Date: Mon, 15 Dec 2008 13:27:24 +0000
Subject: Re: [2.6.26.4] Oops: Unable to handle kernel paging request at virtual address 00000000491f2000
Message-Id: <200812151427.24737.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <200811152343.58603.elendil@planet.nl>
In-Reply-To: <200811152343.58603.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Monday 17 November 2008, David Miller wrote:
> Some driver module is unloading without releasing it's held I/O
> resources, then something does cat on /proc/iomem or /proc/ioport
> and we go splat accessing unmapped memory from that unloaded
> driver module.

On Monday 17 November 2008, Frans Pop wrote:
> So I guess I'll have one more go at it with the hard disk
> pre-partitioned with LVM. If that does not reproduce it, I guess we'll
> just have to leave this one to someone else to rediscover.

Just for the record...

That failed as well. I cannot reproduce this oops, so it seems we'll just 
have to forget about it for now.

Cheers,
FJP
