From: David Miller <davem@davemloft.net>
Date: Mon, 17 Nov 2008 10:37:27 +0000
Subject: Re: [2.6.26.4] Oops: Unable to handle kernel paging request at
Message-Id: <20081117.023727.127222371.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200811152343.58603.elendil@planet.nl>
In-Reply-To: <200811152343.58603.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Mon, 17 Nov 2008 11:36:04 +0100

> We also collect info for a hardware summary at that point. It could well 
> be that one of the commands there caused it. ... And that does indeed 
> include a cat of /proc/iomem and /proc/ioports.
> 
> Now for the difficult part: how do we find out which driver this was?

Good question.  Perhaps you can find a way to make modprobe,
insmod, and rmmod log something into the installation log?

> I'll see if I can reproduce while keeping a watch on loaded mods.

Good luck, either way.
