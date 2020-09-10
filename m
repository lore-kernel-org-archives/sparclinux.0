From: peterz@infradead.org
Date: Thu, 10 Sep 2020 13:40:40 +0000
Subject: Re: [sparc64] kernel OOPS bisected from "lockdep: improve current->(hard|soft)irqs_enabled synchroni
Message-Id: <20200910134040.GZ1362448@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwGH3c5SvByBB3WSQhR_0NLCY=3RZ6541m8afX-scA4HA@mail.gmail.com>
In-Reply-To: <CADxRZqwGH3c5SvByBB3WSQhR_0NLCY=3RZ6541m8afX-scA4HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>

On Thu, Sep 10, 2020 at 02:43:13PM +0300, Anatoly Pugachev wrote:
> Hello!
> 
> The following git patch 044d0d6de9f50192f9697583504a382347ee95ca
> (linux git master branch) introduced the following kernel OOPS upon
> kernel boot on my sparc64 T5-2 ldom (VM):

https://lkml.kernel.org/r/20200908154157.GV1362448@hirez.programming.kicks-ass.net
