From: carbonated beverage <ramune@net-ronin.org>
Date: Fri, 21 May 2004 11:44:44 +0000
Subject: Re: unkillable process in R state, 2.6.6
Message-Id: <20040521114444.GA3465@net-ronin.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040520064141.GA30223@net-ronin.org>
In-Reply-To: <20040520064141.GA30223@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, May 20, 2004 at 08:36:26AM -0400, Ben Collins wrote:
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> > CONFIG_PREEMPT=y
> 
> Try getting rid of these two just to see what happens.

Tried without, and still happens.  I repulled the bk tree before doing
so about 22:30 PDT, and booted with a kernel built with the above two
turned off -- system froze.

Is there a way to enable a watchdog oopser?  Or some other way of finding
out where the kernel's hanging?

-- DN
Daniel
