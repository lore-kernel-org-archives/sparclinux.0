From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Nov 2010 14:01:27 +0000
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>
	<1290692075.689.20.camel@concordia>
In-Reply-To: <1290692075.689.20.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: michael@ellerman.id.au
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>

On Thu, Nov 25, 2010 at 14:34, Michael Ellerman <michael@ellerman.id.au> wrote:
> I've left for_each_child_of_node(), because I read it as "of", but maybe
> it's "OF"?

I always read it as "for each child-OF-node", so I would rename it to
"dt_for_each_child_node".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
