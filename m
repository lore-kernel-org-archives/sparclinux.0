From: David Miller <davem@davemloft.net>
Date: Wed, 02 Dec 2009 22:42:55 +0000
Subject: Re: Sun V880 + Infiniband?
Message-Id: <20091202.144255.137848873.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200912021045.02970.pat@computer-refuge.org>
	<adaocmhuupk.fsf@roland-alpha.cisco.com>
In-Reply-To: <adaocmhuupk.fsf@roland-alpha.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rdreier@cisco.com
Cc: pat@computer-refuge.org, sparclinux@vger.kernel.org, linux-rdma@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 02 Dec 2009 09:55:19 -0800

> 
>  > [   99.664193] ib_mthca 0003:01:00.0: Missing DCS, aborting.
>  > 
>  > I'm using a kernel compiled off of Linus's git tree as of a few days ago 
>  > (to fix other SPARC issues).  From what I've seen from google searches, 
>  > this means that the first BAR isn't mapped or visible to the driver, so 
>  > maybe this is a SPARC related thing?
> 
> I think the problem is related to:
> 
>  >         Memory at fffff80500000000 (64-bit, non-prefetchable) [size=1]
>  >         Memory at fffff80500000000 (64-bit, prefetchable) [size=1]
>  >         Memory at fffff80500000000 (64-bit, prefetchable) [size=1]
> 
> So it says you have 3 BARs at the same address, all with size 1 (?!)
> which means the PCI setup or probing is messed up.  The mthca driver
> checks that the first BAR has size 1 megabyte as it should, and it's
> bailing out because the kernel is telling it that it's the wrong size.

These BARs are allocated and setup by the boot firmware long before
Linus boots up.  Not being able to handle 64-bit BARs properly
wouldn't surprise me.

But there could also be a Linux bug in decoding the openfirmware
property values as well, so let's investigate that.

Patrick, can you post a new "prtconf -pv" dump under Linux with this
card in the machine?  Also, please bootup with:

	of_debug=1 ofpci_debug=1

added to the kernel command line and post the resulting "dmesg".

If there's something Linux isn't doing right, those dumps will help
me spot it.

Thanks!
