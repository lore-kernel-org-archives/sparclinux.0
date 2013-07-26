From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jul 2013 10:23:26 +0000
Subject: kisskb: sparc-allmodconfig is actually sparc64
Message-Id: <CAMuHMdUjaGRnHZpxs1j4VkYgTUXQNXvqu8LstpxLe8tYdf1oVw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <michael@ellerman.id.au>
Cc: sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>

Hi Michael, Stephen,

The sparc-allmodconfig builds on http://kisskb.ellerman.id.au/kisskb/matrix/
seem to be sparc64, not sparc32, allmodconfig builds.
The sparc-allnoconfig builds are sparc32.

BTW, what's the simplest way to make an all*config build with fixed sparc32 or
sparc64?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
