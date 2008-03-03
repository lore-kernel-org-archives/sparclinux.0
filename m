From: David Miller <davem@davemloft.net>
Date: Mon, 03 Mar 2008 22:02:03 +0000
Subject: Re: sparc vs. gcc 4.3
Message-Id: <20080303.140203.201465683.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080303192651.GL26072@cs181133002.pp.htv.fi>
	<20080303.130348.25289482.davem@davemloft.net>
	<1204580471.22933.17.camel@brick>
In-Reply-To: <1204580471.22933.17.camel@brick>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harvey.harrison@gmail.com
Cc: bunk@kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Mon, 03 Mar 2008 13:41:11 -0800

> Could you hide the asm inside an actual function and annotate the
> function with __used?

Won't work, the asm needs to be inlined because it needs to:

1) Know where local variables are located

2) Has to run in the context of the stack frame the
   call site runs in so that the tail-call it's doing works

And actually all of this is why the sparc64 fix turned out to
be so invasive, and I'll need to do the same for sparc32
as a result.
