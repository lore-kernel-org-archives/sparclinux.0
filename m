From: David Miller <davem@davemloft.net>
Date: Sat, 29 Mar 2008 00:37:15 +0000
Subject: Re: PCIe Graphic card for SPARC T1000/2000 Platform
Message-Id: <20080328.173715.55485309.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <47ED8CBC.8050900@Sun.COM>
In-Reply-To: <47ED8CBC.8050900@Sun.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nasser Shayesteh <Nasser.Shayesteh@Sun.COM>
Date: Fri, 28 Mar 2008 17:26:36 -0700

> I have a SPARC T2000 system installed with Ubuntu 7.10  Server Edition 
> running "2.6.22-14-sparc64-smp"  kernel.
> 
> I am interested to know whether anyone knows of  any low power PCIe 
> graphics card and corresponding driver that works on T1000T2000 SPARC 
> based platforms.
> 
> I also tried  Nvidia (NVS440)  graphic card without the FCODE to see if 
> I can start X using the nvidiafb.ko driver that comes with stock Ubuntu 
> kernel distribution for servers. The device was recognized OK. However, 
> there is a fatal mmap() failure.

NVIDIA isn't going to work, Radeon (XVR-100) cards should
work if you configure X to use the "fb" acceleration-less
driver.

The state of X is very poor under Linux at the moment,
although it should improve substantially in future
releases.
