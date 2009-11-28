From: David Miller <davem@davemloft.net>
Date: Sat, 28 Nov 2009 02:30:15 +0000
Subject: Re: Boot problems on a V880
Message-Id: <20091127.183015.09193843.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Patrick Finnegan <pat@computer-refuge.org>
Date: Fri, 27 Nov 2009 20:52:17 -0500

> On Friday 27 November 2009, David Miller wrote:
>> From: Patrick Finnegan <pat@computer-refuge.org>
>> Date: Thu, 26 Nov 2009 22:02:45 -0500
>> 
>> > I seem to have a new/different problem with booting on a Sun V880. 
>> > I have tried Debian/sarge, etch, and lenny installers, each fails. 
>> > After reading through a bit of this list, I downloaded
>> > sparc-next-2.6 via git, and compiled a kernel (based on
>> > Debian/lenny's 2.6.26-2-sparc64 kernel config), and it still won't
>> > boot.  I also updated to the latest OpenBoot image, hoping that
>> > would help, but I didn't see any difference.
>> 
>> sparc-next-2.6 doesn't have the bug fix, sparc-2.6 does
> 
> Ok, with sparc-2.6, I get farther.  If I pull the RSC card, it actually 
> gets to a point where it tries to mount the root filesystem (and fails, 
> because I don't have one for it yet).  With the RSC in, it hangs after 
> the following output.  I have tried this with the OpenBoot console set 
> to both ttya and rsc-console, and passed a "console=ttyS0" each time. At 
> the point that the machine hangs, it locks up hard enough that sending a 
> break doesn't send me to an "ok" prompt.

try booting with "initcall_debug=1 ignore_level" on the kernel command line

And in the mean time you can install and test with the RSC card removed
