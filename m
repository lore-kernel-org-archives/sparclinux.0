From: Olivier Danet <odanet@caramail.com>
Date: Sat, 19 Apr 2014 23:31:33 +0000
Subject: Re: Time to let sun4m + sun4d RIP?
Message-Id: <53530755.3000507@caramail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140419114802.GA13716@ravnborg.org>
In-Reply-To: <20140419114802.GA13716@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 19/04/2014 13:48, Sam Ravnborg wrote:
> Hi all sparc lovers/users.
> 
> We all know that is is a long time ago that a sun4m or sun4d machine was produced,
> and I wonder if there are anyone using these today.
> The questions pops up as there are still stuff to do before the sparc32 port
> is in good shape.
> 
> So the question to you guys...
> Shall we keep support for sun4d and sun4m?
> If yes then why?
> 
> LEON is in active use in several applications - so the sparc32 port is
> as relevant as ever.
> 
> 	Sam

I wish Linux could keep the Sun4m port a bit longer, even if I cannot help much, I just posted a small patch last year.

There is a project for the recreation of Sun4m hardware in a FPGA : http://temlib.org.
Running current Linux kernel on this hardware could be interesting. It would also be preferable as a base for patchs to optimise
the kernel to TEMLIB's CPU which emulates legacy Sun CPUs (MicroSparc) but is not exactly identical to them
(different TLBs organisation, for example).

QEMU currently supports Sun4m quite well, despite some issues with SCSI emulation.
All operating systems can be run, except NextSTEP : Linux, *BSD, Solaris are supported.
It is now much faster than genuine Sun hardware (particulary for disk accesses !).

Regards
O.Danet

