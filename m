From: David Miller <davem@davemloft.net>
Date: Fri, 24 Sep 2010 04:53:21 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100923.215321.90804782.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100922204323.GG19804@ZenIV.linux.org.uk>
	<20100922.141514.232744402.davem@davemloft.net>
	<20100923002757.GI19804@ZenIV.linux.org.uk>
In-Reply-To: <20100923002757.GI19804@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Thu, 23 Sep 2010 01:27:57 +0100

> Dave, are you OK with the following patch?  That should cover both sparc32
> and sparc64...
> 
> Subject: [PATCH] sparc: keep calling do_signal() as long as pending signals remain

Looks great, I'll apply this and give it some of my own testing.

I'll also take care of that unaligned stack pointer issue on sparc32.

Thanks!
