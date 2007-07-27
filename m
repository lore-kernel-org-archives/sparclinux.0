From: David Miller <davem@davemloft.net>
Date: Fri, 27 Jul 2007 20:47:19 +0000
Subject: Re: ioctl32 warning on framebuffer
Message-Id: <20070727.134719.98863529.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 27 Jul 2007 22:23:53 +0300 (EEST)

> Maybe related to the just solved X debugging problem, maybe not: 
> 
> I booted todays git (d941cf5e) on my U5 and XOrg is set to autostart 
> (the box is currently headless so I do not know whether it actually 
> works). Anyway, XOrg startup gives these 2 lines to dmesg:
> 
> ioctl32(Xorg:1892): Unknown cmd fd(6) cmd(40584606){t:'F';sz:88} arg(ffdabb4c) on /dev/fb0 
> ioctl32(Xorg:1892): Unknown cmd fd(6) cmd(40184600){t:'F';sz:24} arg(ffdabb54) on /dev/fb0

This has been there forever, I'll look at it again but I think
it's one of those warnings that is hard to eliminate without
a lot of internal pain implementation wise.
