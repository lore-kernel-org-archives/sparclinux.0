From: joey@odoherty.net
Date: Mon, 03 May 2004 19:11:51 +0000
Subject: Re: Losing my mind, RAID1 on Sparc completely broken?
Message-Id: <20040503191151.GB23124@odoherty.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi James,

> One thing is that SILO now only gets as far as S and then I get 
> "Program terminated" - I'm not sure what's causing this, but now I have 
> to do "boot cdrom /iommu/.....;1/vmlinuz root=/dev/md0 ro" to start my 
> machine.  Anyone have any ideas about what's up with SILO?
> 
> I have the latest SILO from sarge installed.

I had this exact same problem (on Sarge, no less.) The solution was to make
sure that the same silo boot partition was installed to both disks which
made up the array. I did this by individually mounting each disk that made-up
the raid and issued a 'silo -r /mountpoint'. After that it worked fine.. 

The only resource I found suggesting this is here:
http://www.ultralinux.org/faq.html#q_5_40

/joeyo
