From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 08 Jun 2004 15:53:59 +0000
Subject: Re: sun4c driver/dma problems
Message-Id: <20040608155359.GA10483@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200406020818.13705.luckas@musoft.de>
In-Reply-To: <200406020818.13705.luckas@musoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 08, 2004 at 09:22:44AM +0200, Uli Luckas wrote:

> the above cited DMA message seems to be the root of the driver problems. From 
> the 2.2.26 kernel I know it should read:
> dma0: Revision 1
> 
> So what can I do to help, getting this fixed? Who works on this code?
> I already know, it's not only the version detection. Defining a new version 
> 70000000 "Revision 1 broken" and initialising it just as a "Revision 1" works 
> around the above message, but all the device drivers report all kind of DMA 
> related problems later on and of course don't work.

Reading your messages, I'm uncertain exactly how well 2.2.26 works.
Can you please clarify?  If it's perfect, then I may invest a few
hours trying to fix this for you in 2.6.  If there's no known-working
kernel, it's unlikely that it ever will be fixed.

-- 
Keith M Wesolowski
