From: David Miller <davem@davemloft.net>
Date: Mon, 17 Nov 2008 07:18:08 +0000
Subject: Re: [2.6.26.4] Oops: Unable to handle kernel paging request at
Message-Id: <20081116.231808.145277110.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200811152343.58603.elendil@planet.nl>
In-Reply-To: <200811152343.58603.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Sat, 15 Nov 2008 23:43:58 +0100

> During a test installation of Debian I got the following Oops at the point
> where either the installer's internal webserver (implemented in shell using
> netcat ;-) was started or where that server was contacted a bit later.
> The oops did not repeat; the installation as a whole succeeded.
> 
> I know this is not a very current kernel, but this is what we're releasing
> with. Well, the release will be using 2.6.26.7 actually.

Some driver module is unloading without releasing it's held I/O
resources, then something does cat on /proc/iomem or /proc/ioport
and we go splat accessing unmapped memory from that unloaded
driver module.

