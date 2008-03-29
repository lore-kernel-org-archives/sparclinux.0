From: Nasser Shayesteh <Nasser.Shayesteh@Sun.COM>
Date: Sat, 29 Mar 2008 00:26:36 +0000
Subject: PCIe Graphic card for SPARC T1000/2000 Platform
Message-Id: <47ED8CBC.8050900@Sun.COM>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hello

I have a SPARC T2000 system installed with Ubuntu 7.10  Server Edition 
running "2.6.22-14-sparc64-smp"  kernel.

I am interested to know whether anyone knows of  any low power PCIe 
graphics card and corresponding driver that works on T1000T2000 SPARC 
based platforms.

I also tried  Nvidia (NVS440)  graphic card without the FCODE to see if 
I can start X using the nvidiafb.ko driver that comes with stock Ubuntu 
kernel distribution for servers. The device was recognized OK. However, 
there is a fatal mmap() failure.


# startx

......


(WW) NV: No matching Device section for instance (BusID PCI:16:0:0) found
mmap failure: Invalid argument

Fatal server error:
xf86MapDomainMem():  mmap() failure

XIO:  fatal IO error 54 (Connection reset by peer) on X server ":0.0"
      after 0 requests (0 known processed) with 0 events remaining.


Is there any patch available that I can try?

Thanks,

--Nasser


