From: Uli Luckas <luckas@musoft.de>
Date: Thu, 15 Jul 2004 06:21:46 +0000
Subject: Re: sun4c driver/dma problems
Message-Id: <200407150821.46973.luckas@musoft.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200406020818.13705.luckas@musoft.de>
In-Reply-To: <200406020818.13705.luckas@musoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Am Donnerstag, 15. Juli 2004 00:23 schrieb Keith M Wesolowski:
> On Tue, Jul 13, 2004 at 11:39:00PM +0200, Uli Luckas wrote:
> > > > So what can I do to help, getting this fixed? Who works on this code?
> > > > I already know, it's not only the version detection. Defining a new
> > > > version 70000000 "Revision 1 broken" and initialising it just as a
> > > > "Revision 1" works around the above message, but all the device
> > > > drivers report all kind of DMA related problems later on and of
> > > > course don't work.
> >
> > As I have read, you are retiering from sparc32 kernel development. Is
> > there any hint that could get me going on fixing the above problems
> > myself? Do you have asumptions on where the problem can be found?
>
> I do not know the cause of this problem.  However, it's entirely
> possible it's just a detection issue.  You might consider grepping for
> these messages in the source, then diffing between a working and
> non-working kernel to see what's changed.  If it's not simple
> detection, it may be related to the hypersparc DMA issue I've noted,
> which has not been diagnosed.
Hi Keith,
thanks for your reply. I'll see what I can do. Even though I might not be 
clued in to sparc internals enough.

Regards
Uli

-- 
Im Kapitalismus beutet der Mensch den Menschen aus.
Im Sozialismus ist es genau umgekehrt.
- Ben Tucker
