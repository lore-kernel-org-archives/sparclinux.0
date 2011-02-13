From: David Miller <davem@davemloft.net>
Date: Sun, 13 Feb 2011 23:05:28 +0000
Subject: Re: [PATCH 4/4] sparc32: genirq conversion (buggy)
Message-Id: <20110213.150528.232911419.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110213192952.GD25069@merkur.ravnborg.org>
In-Reply-To: <20110213192952.GD25069@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 23:30:18 +0100

> On Sun, Feb 13, 2011 at 02:00:26PM -0800, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Sun, 13 Feb 2011 22:48:44 +0100
>> 
>> > In the original implmentation we did the same via __enable_irq().
>> 
>> And we did so Via a function that's invoked by every cpu as it is booted.
>> 
>> Right?
> 
> To the best of my knowledge - no.

I was thinking of:
ofarch/sparc/kernel/sun4m_smp.c:smp_setup_percpu_timer()

which enables it explicitly via enable_pil_irq(14).

Oh, it's a global IRQ, so we should be Ok nevermind. :-)

