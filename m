From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Mar 2011 22:56:11 +0000
Subject: Re: [PATCH] sparc: Provide NO_IRQ definition.
Message-Id: <20110318225611.GA16249@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110318.150435.241941372.davem@davemloft.net>
In-Reply-To: <20110318.150435.241941372.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Mar 18, 2011 at 03:50:12PM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 18 Mar 2011 23:48:10 +0100
> 
> > Why -1 (0xffffffff)?
> 
> Because that is what the OF device object creation layer
> treats as no-IRQ.
> 
> See for example the test in of_device_64.c:build_one_device_irq()
> where we go:
> 
> 	if (irq = 0xffffffff)
> 		return irq;

Understood - thanks.

	Sam

