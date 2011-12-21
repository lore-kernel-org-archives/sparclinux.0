From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Dec 2011 07:59:03 +0000
Subject: sparc: __mcount_loc already exists (was: Re: Build
Message-Id: <CAMuHMdUvnTWvaTndObFjA_pJXNWVpDBqxviyDpYvihc7pDiV3Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linux-Next <linux-next@vger.kernel.org>

On Wed, Dec 21, 2011 at 08:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Note that I deleted 5238 lines about "__mcount_loc already exists", to avoid
> my email being rejected.

I anyone planning to fix this? It only happens for sparc64/sparc-allmodconfig,
and appeared in v3.2-rc3.

linus: http://kisskb.ellerman.id.au/kisskb/buildresult/5167232/
linux-next: http://kisskb.ellerman.id.au/kisskb/buildresult/5166753/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
