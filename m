From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 20 Jun 2008 21:25:26 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <Pine.LNX.4.64.0806201723120.14221@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806201143110.8789@engineering.redhat.com>
 <20080620.102601.06998427.davem@davemloft.net>
 <Pine.LNX.4.64.0806201707270.8990@engineering.redhat.com>
 <20080620.142034.30884440.davem@davemloft.net>
In-Reply-To: <20080620.142034.30884440.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com

On Fri, 20 Jun 2008, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Fri, 20 Jun 2008 17:14:41 -0400 (EDT)
>
>> Are you sure? What about this:
>> ide-io.c:ide_intr
>>          if (drive->unmask)
>>                  local_irq_enable_in_hardirq();
>>
>> or this:
>> kernel/irq/handle.c:handle_IRQ_event
>>          if (!(action->flags & IRQF_DISABLED))
>>                  local_irq_enable_in_hardirq();
>>
>>
>> --- how is number of nested interrupts here supposed to be limited?
>>
>> If these things are not limited, you get at most as many nested handlers
>> as there are hardware interrupts, which means crash.
>
> It means i386 and every other platform potentially has the same exact
> problem.
>
> What point wrt. sparc64 are you trying to make here? :-)

The difference is that i386 takes minimum 4 bytes per stack frame and 
sparc64 192 bytes per stack frame. So this problem will kill sparc64 
sooner.

But yes, it is general problem and should be solved in arch-independent 
code.

Mikulas
