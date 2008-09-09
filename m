From: Manfred Spraul <manfred@colorfullife.com>
Date: Tue, 09 Sep 2008 18:49:04 +0000
Subject: Re: [PATCH] prevent sparc64 from invoking irq handlers on offline
Message-Id: <48C6C520.5070103@colorfullife.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903004211.GD6748@linux.vnet.ibm.com> <20080903.022138.31681256.davem@davemloft.net> <20080903154217.GA6807@linux.vnet.ibm.com> <20080908.171708.43575256.davem@davemloft.net>
In-Reply-To: <20080908.171708.43575256.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org, akpm@linux-foundation.org

David Miller wrote:
> And IPI handler runs in HW irq context, therefore such an IPI-creates-an-IPI
> should not be allowed, at least not directly.
>
> Actually the restriction seems to be that an IPI cannot be sent when
> "irqs_disabled()", hmmm...
>
>   
Does this apply to smp_send_reschedule() as well?
A [rare] codepath in the current rcu code does to trigger quiescent 
states on remote cpus.

--
    Manfred

