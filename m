From: David Miller <davem@davemloft.net>
Date: Fri, 05 Oct 2012 21:48:42 +0000
Subject: Re: [RESEND PATCH 1/2] sparc64: Rearrange thread info to cheaply clear syscall noerror state.
Message-Id: <20121005.174842.552673293980904869.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121004.174812.706050126936137696.davem@davemloft.net>
In-Reply-To: <20121004.174812.706050126936137696.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Al, this change turns out to be broken.

If you move the WSAVED byte down past bit 16, it runs into the bit
mask we for the _TI_* flag bits down lower in the file.

There's a big comment down there explaining the layout.

 * Thread information flags, only 16 bits are available as we encode
 * other values into the upper 6 bytes.
 *
 * On trap return we need to test several values:
 *
 * user:	need_resched, notify_resume, sigpending, wsaved
 * kernel:	fpdepth
 *
 * So to check for work in the kernel case we simply load the fpdepth
 * byte out of the flags and test it.  For the user case we encode the
 * lower 3 bytes of flags as follows:
 *	----------------------------------------
 *	| wsaved | flags byte 1 | flags byte 2 |
 *	----------------------------------------

So now things like syscall restart and the seccomp stuff triggers
on trap return when it shouldn't.  I just got an OOPS from this.

I'm reverting these two changes until we sort this out.

Thanks.
