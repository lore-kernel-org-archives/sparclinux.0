From: "David S. Miller" <davem@redhat.com>
Date: Thu, 19 Aug 2004 14:33:04 +0000
Subject: Re: Patch - Sun4d SMP now boots
Message-Id: <20040819073304.42ab30d8.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.53.0408191358400.2910@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.53.0408191358400.2910@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 19 Aug 2004 07:12:13 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> One major question is *WHY* spin_lock_bh() vs. spin_lock_irqsave()
> works. Only trouble there is that we can't see what happens after
> spin_lock_irqsave() very easily. One rather large possibility is that
> since disabling bh's doesn't disable interrupts, some smp_call_function()
> or similar that would deadlock if interrupts weren't disabled suddenly
> appears to work and/or works for some limited cases...
> 
> This is in my queue also, though preferably some explanation of what's
> going on with this (e.g. the real issue, maybe a better fix) will
> happen instead.

Another thing to keep in mind on sparc32 is that %psr writes have
a 3 instruction latency, which is why we usually put 3 nops after it.
Also, writing garbage into the %psr can easily wedge the chip or
cause it to take a fatal trap.
