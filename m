From: David Miller <davem@davemloft.net>
Date: Thu, 08 Jan 2009 16:33:51 +0000
Subject: Re: [PATCH] sparc: refactor code in fault_32.c
Message-Id: <20090108.083351.68367340.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090106205209.GA24034@uranus.ravnborg.org>
In-Reply-To: <20090106205209.GA24034@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 8 Jan 2009 13:02:34 +0100

> Can you think of any way we could improve the branch-tracer 
> instrumentation define in any way to prevent such trouble?

Steven was looking into this but every variant of the if() macro he
tried wasn't able to eliminate all of the problems.  We've been
discussing this with him in another thread for several days.  The
S390 folks are running into these kinds of problems too.

It's basically an issue of how deeply older GCCs will search
into the control flow of a very complex conditional.  There
really isn't anything we can do about that.
