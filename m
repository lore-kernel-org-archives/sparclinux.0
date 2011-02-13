From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 21:48:44 +0000
Subject: Re: [PATCH 4/4] sparc32: genirq conversion (buggy)
Message-Id: <20110213214844.GA29417@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110213192952.GD25069@merkur.ravnborg.org>
In-Reply-To: <20110213192952.GD25069@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 13, 2011 at 01:19:50PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 13 Feb 2011 22:06:51 +0100
> 
> > So I fixed this - but result is the same - we hang in calibrate_dealy().
> 
> Well, the next problem I noticed is that you only enable the timer IRQ
> on the cpu on which request_irq() executes, what about all of the
> other cpus in the system?

Trying to investigate this I actually found a bug:
@@ -267,7 +268,7 @@ static unsigned int sun4m_build_device_irq(struct platform_device *o
        }

        handler_data->mask = sun4m_imask[real_irq];
-       handler_data->percpu = irq < OBP_INT_LEVEL_ONBOARD;
+       handler_data->percpu = real_irq < OBP_INT_LEVEL_ONBOARD;
        set_irq_chip(irq, &sun4m_irq);
        set_irq_data(irq, handler_data);

percpu is a bool used in the enable/disable handlers to determine if this is
a system wide or a percpu specific irq.
Before the above change the timer interrupt was considered a cpu
specific irq - resulting in the wrong register being set.
With the above change I got one step further - now I see a "Watchdog Reset".
I am yet to investigate why.

> what about all of the other cpus in the system?
I really do not know :-(
This code is as much as I could a copy of the original
implementation (except a floppy hack).
In the original implmentation we did the same via __enable_irq().

And as the timer interrupt is enabled in the system wide interrupt
register - I think this is OK.
But I do not (yet) see how to cope with softint's.
As they are unused for now they can wait.

	Sam

