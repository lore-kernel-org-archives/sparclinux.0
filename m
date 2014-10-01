From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 01 Oct 2014 16:23:54 +0000
Subject: Re: [PATCH] sparc64: Add vio_set_intr() to enable/disable Rx interrupts
Message-Id: <20141001162354.GF17706@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140923153744.GB11042@oracle.com>
In-Reply-To: <20140923153744.GB11042@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (09/30/14 17:41), David Miller wrote:
> 
> > The vio_set_intr() API should be used by VIO consumers to enable/disable
> > Rx interrupts to facilitate deferred processing in softirq/bottom-half
> > context.
> > 
> > Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> 
> Applied, thanks.

I'm just getting ready to submit some sunvnet changes to net-next that use
the above functions. Do I need to resend this patch to net-next at that time
(I noticed that the Jumbo-mtu patch did that)?

I do plan to call out the dependancy in the cover-letter for the sunvnet
series, of course. 

--Sowmini

