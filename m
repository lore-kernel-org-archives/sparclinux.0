From: Patrick Finnegan <pat@computer-refuge.org>
Date: Thu, 03 Dec 2009 06:44:18 +0000
Subject: Re: Sun V880 + Infiniband?
Message-Id: <200912030144.18971.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200912021045.02970.pat@computer-refuge.org> <adaocmhuupk.fsf@roland-alpha.cisco.com> <20091202.144255.137848873.davem@davemloft.net>
In-Reply-To: <20091202.144255.137848873.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: rdreier-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wednesday 02 December 2009, David Miller wrote:
> From: Roland Dreier <rdreier@cisco.com>
> Date: Wed, 02 Dec 2009 09:55:19 -0800
> 
> >  > [   99.664193] ib_mthca 0003:01:00.0: Missing DCS, aborting.
> >  >
> >  > I'm using a kernel compiled off of Linus's git tree as of a few
> >  > days ago (to fix other SPARC issues).  From what I've seen from
> >  > google searches, this means that the first BAR isn't mapped or
> >  > visible to the driver, so maybe this is a SPARC related thing?
> >
> > I think the problem is related to:
> >  >         Memory at fffff80500000000 (64-bit, non-prefetchable)
> >  > [size=1] Memory at fffff80500000000 (64-bit, prefetchable)
> >  > [size=1] Memory at fffff80500000000 (64-bit, prefetchable)
> >  > [size=1]
> >
> > So it says you have 3 BARs at the same address, all with size 1
> > (?!) which means the PCI setup or probing is messed up.  The mthca
> > driver checks that the first BAR has size 1 megabyte as it should,
> > and it's bailing out because the kernel is telling it that it's the
> > wrong size.
> 
> These BARs are allocated and setup by the boot firmware long before
> Linus boots up.  Not being able to handle 64-bit BARs properly
> wouldn't surprise me.
> 
> But there could also be a Linux bug in decoding the openfirmware
> property values as well, so let's investigate that.
> 
> Patrick, can you post a new "prtconf -pv" dump under Linux with this
> card in the machine?  Also, please bootup with:
> 
> 	of_debug=1 ofpci_debug=1
> 
> added to the kernel command line and post the resulting "dmesg".

I have placed an updated prtconf here:

http://ned.cc.purdue.edu/prtconf-v880-8cpu

The last two entries on it (PCI bridge and pci15b3,5a44) are from the 
card.

Based upon my best guess as to what the fields indicate, it looks like 
the OF tree may have the proper BAR sizes in it at least (I believe that 
they're supposed to be 1MB, 8MB and 128MB respectively), so I think it's 
a Linux thing not an OpenBoot thing.

The console output after booting with the debugging options is here:

http://ned.cc.purdue.edu/v880-of_debug-dmesg

I see that the output claims that the 3 BARs start and end at address 
"0" which doesn't look right.

> If there's something Linux isn't doing right, those dumps will help
> me spot it.

Thanks again!

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
