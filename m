From: David Miller <davem@davemloft.net>
Date: Wed, 08 Aug 2007 10:19:16 +0000
Subject: Re: 2.6.22.1 kernel grinds...to......a............halt......
Message-Id: <20070808.031916.121294992.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46B98697.8090802@walrond.org>
In-Reply-To: <46B98697.8090802@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Walrond <andrew@walrond.org>
Date: Wed, 08 Aug 2007 10:32:35 +0100

> Please disregard. I have just realised that initramfs uses ramfs, not
> tmpfs as I assumed, so is not swappable and the oom-killer is quite
> possible in these circumstances given the size of the build job.
> 
> (There was a patch by Al Boldi around 2.6.18 to use tmpfs but it seems
> it didn't go into the kernel)

Oh, that explains everything.
