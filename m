From: Petr Mladek <pmladek@suse.com>
Date: Mon, 30 Nov 2015 14:25:45 +0000
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
Message-Id: <20151130142545.GB8047@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <CAMo8BfJKrrCxhHFEgOrB+KgttjZOSKO1a=FMdEw=YcHa2KDCqw@mail.gmail.com>
In-Reply-To: <CAMo8BfJKrrCxhHFEgOrB+KgttjZOSKO1a=FMdEw=YcHa2KDCqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 2015-11-27 17:26:16, Max Filippov wrote:
Hi Max,

> > Another exception is Xtensa architecture that uses just a
> > fake NMI.
> 
> It's called fake because it's actually maskable, but sometimes
> it is safe to use it as NMI (when there are no other IRQs at the
> same priority level and that level equals EXCM level). That
> condition is checked in arch/xtensa/include/asm/processor.h
> So 'fake' here is to avoid confusion with real NMI that exists
> on xtensa (and is not currently used in linux), otherwise code
> that runs in fake NMI must follow the NMI rules.
> 
> To make xtensa compatible with your change we can add a
> choice whether fake NMI should be used to kconfig. It can
> then set HAVE_NMI accordingly. I'll post a patch for xtensa.

Thanks a lot for explanation. I'll wait for the destiny of
the patch adding CONFIG_XTENSA_FAKE_NMI. It is not easy
for me to review. Anyway, we could select HAVE_NMI for
Xtensa anytime later if this patchset goes in earlier.

Best Regards,
Petr
