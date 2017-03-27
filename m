From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Mar 2017 07:49:51 +0000
Subject: Re: Build regressions/improvements in v4.11-rc4
Message-Id: <CAMuHMdUoe1ksQFtNFnqWm+TASEX0kTMhTQ6UMZ7+fyGskqg3YQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1490600680-26426-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1490600680-26426-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: sparclinux <sparclinux@vger.kernel.org>

On Mon, Mar 27, 2017 at 9:44 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.11-rc4[1] to v4.11-rc3[3], the summaries are:
>   - build errors: +2/-1

  + error: "vac_cache_size" [drivers/infiniband/sw/rxe/rdma_rxe.ko]
undefined!:  => N/A

sparc64/sparc-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/c02ed2e75ef4c74e41e421acb4ef1494671585e8/ (all 266 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/97da3854c526d3a6ee05c849c96e48d21527606c/ (all 266 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
