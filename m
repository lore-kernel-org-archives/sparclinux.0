From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 19 Mar 2010 07:41:09 +0000
Subject: Re: [PATCH v2][GIT PULL][v2.6.34] ring-buffer: Do 8 byte alignment
Message-Id: <20100319074109.GB12576@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <1268966657.758.28.camel@gandalf.stny.rr.com>
 <20100318.200347.115945905.davem@davemloft.net>
 <1268968559.758.31.camel@gandalf.stny.rr.com>
In-Reply-To: <1268968559.758.31.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, akpm@linux-foundation.org, fweisbec@gmail.com, sparclinux@vger.kernel.org, tj@kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Rebased to add David's ACK.
> 
> Ingo,
> 
> Please pull the latest tip/tracing/urgent tree, which can be found at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
> tip/tracing/urgent
> 
> 
> Steven Rostedt (1):
>       ring-buffer: Do 8 byte alignment for 64 bit that can not handle 4 byte align

Pulled, thanks a lot Steve!

	Ingo
