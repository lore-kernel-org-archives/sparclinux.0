From: Frans Pop <elendil@planet.nl>
Date: Mon, 17 Nov 2008 10:36:04 +0000
Subject: Re: [2.6.26.4] Oops: Unable to handle kernel paging request at virtual address 00000000491f2000
Message-Id: <200811171136.04949.elendil@planet.nl>
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

Hmm. Strange. I cannot relate that to what I was doing at that point in 
the installation.

Ah, hang on (imagine me waking up; should maybe have breakfast first...).

We also collect info for a hardware summary at that point. It could well 
be that one of the commands there caused it. ... And that does indeed 
include a cat of /proc/iomem and /proc/ioports.

Now for the difficult part: how do we find out which driver this was?

I'll see if I can reproduce while keeping a watch on loaded mods.

Cheers,
FJP
