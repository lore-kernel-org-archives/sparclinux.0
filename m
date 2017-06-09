From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 Jun 2017 07:05:57 +0000
Subject: Re: [PATCH 2/2] include: warn for inconsistent endian config definition
Message-Id: <CAMuHMdX2u8vZGBVXitH+FcfeMwZ8a1-g2b-Dh7V9=HnqJpj=hw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1496960243-196898-1-git-send-email-babu.moger@oracle.com> <1496960243-196898-3-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1496960243-196898-3-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uclinux-h8-devel@lists.sourceforge.jp, Linux/m68k <linux-m68k@vger.kernel.org>, openrisc@lists.librecores.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

On Fri, Jun 9, 2017 at 12:17 AM, Babu Moger <babu.moger@oracle.com> wrote:
> Display warning if CPU_BIG_ENDIAN is not defined on big endian
> architecture and also warn if it defined on little endian architectures.
>
> We have seen some generic code(for example code include/asm-generic/qrwlock.h)
> uses CONFIG_CPU_BIG_ENDIAN to decide the endianess.

That example is IMHO the least harmful, as qrwlock must be selected explicitly
by the architecture.

The uses in

    drivers/of/base.c
    drivers/of/fdt.c
    drivers/tty/serial/earlycon.c
    drivers/tty/serial/serial_core.c

are more dangerous, and may have bitten people already.
In addition, people may have worked around them in DT, so this series may
actually introduce regressions.

> Here is the original discussion
> http://www.spinics.net/lists/devicetree/msg178101.html
>
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Hmm, the link above refers to a mail from me? ;-)

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
