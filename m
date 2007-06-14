From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Thu, 14 Jun 2007 16:33:16 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <1181838796.30703.20.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2007-06-14 at 10:13 +0200, Mikael Pettersson wrote:
> Dmitry Artamonow writes:
>  > On Tue, Jun 12, 2007 at 04:55:34PM -0700, David Miller wrote:
>  > > 
>  > > This should fix the problem, thanks for all of the debugging
>  > > information.
>  > > 
>  > > Let me know if the X regression is still not fixed.
>  > > 
>  > > commit cf58de958f939587637ea74cdc3382bc140a936b
>  > > Author: David S. Miller <davem@sunset.davemloft.net>
>  > > Date:   Tue Jun 12 16:54:08 2007 -0700
>  > > 
>  > >     [SPARC64]: Fix IO/MEM space sizing for PCI.
>  > >     
>  > >     In pci_determine_mem_io_space(), do not hard code the region sizes.
>  > >     Instead, use the values given to us in the ranges property.
>  > >     
>  > >     Thanks goes to Mikael Petterson for the original Xorg failure
>  > >     bug repoert, and strace dumps from Mikael and Dmitry Artamonow.
>  > >     
>  > >     Signed-off-by: David S. Miller <davem@davemloft.net>
>  > > 
>  > Hello, David.
>  > 
>  > Just compiled -rc4 with your patch and Xorg still doesn't work. Now it
>  > breaks in ati module with such errors:
>  > (EE) ATI(0): Unable to mmap() adapter registers.
>  > (EE) Screen(s) found, but none have a usable configuration.
>  > 
>  > Also there's a couple of strange warnings before it breaks:
>  > (WW) ****INVALID MEM ALLOCATION**** b: 0xe1000000 e: 0xe1ffffff correcting
>  > (WW) ****INVALID MEM ALLOCATION**** b: 0xe2000000 e: 0xe2000fff correcting
> 
> Same failure here with xorg-6.8.1 and 2.6.22-rc4 + this patch, unfortunately.

FWIW, we're _NOT_ seeing X failures on a U5 with xorg-7.1 and 2.6.21.1 +
this patch (well, this patch in the four relevant pci files, this kernel
predates the pci_common cleanups).

Proof:
http://beer.tclug.org/jima/pix/aurora/u5-corona-20070614.png

~spot

