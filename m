From: David Miller <davem@davemloft.net>
Date: Wed, 25 Jul 2007 22:10:13 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <20070725.151013.74534910.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 25 Jul 2007 22:46:07 +0100 (BST)

> It looks like I will have to change the patch to use a kernal/module 
> parameter to enable VTOC checking. David, would this be suficient in your 
> view?

I still don't like it too much.  Please find a way to distinguish
the two situations, I truly believe there is some way to figure
this out.  For example, one thing you can depend upon is that the
faulty Linux tools will always zero out version and sanity along
with the num_partitions field in the VTOC.

> With regard to the id and flag values - the spare1 and spare2 values are 
> currently meant to be zero so using the 16bit filing system endian 
> conversion functions means that 8 partition disk label created on x86
> systems should work correctly as well as those created on Sparc systems. 
> It would be posible to change the code to use bytes but the coding begins 
> to get very messy when we start accessing bytes swaped partition labels 
> as these use spare1/2 for id/flags.

Yes, I believe this part of the changes are fine.  If you look at the
fdisk sun label fixes I made in util-linux-ng the other week I did
basically the same thing.

> The final part of the patch - increasing the number of x86 slices 
> (partitions) from 8 to 16 will correct the x86 Solaris disk label usually 
> used in x86 solaris systems but again may break Linux systems that have 
> been created using the incorrect value.

It is truly a shame that Sun decided to use a different number of
partitions value on x86.  BUT, for these cases it is easy to detect
dynamically because the num_partitions field will contain 16.

For broken linux tools and Solaris/Sparc, the field will contain
either 0 or 8.

So a lot of this should be dynamically detectable, even considering
tools that do not fill in version and sanity properly.

Please try hard to avoid a module parameter, I'm willing to help
with testing as I have all of the Linux and current generation
Solaris/Sparc disk label cases handy locally.
