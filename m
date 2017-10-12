From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 12 Oct 2017 16:06:46 +0000
Subject: Re: [PATCH] video: fbdev: make fb_var_screeninfo static, const and __initconst
Message-Id: <4996127.oJ8tDUhiv1@amdc3058>
List-Id: <sparclinux.vger.kernel.org>
References: <CGME20170914123228epcas3p4350c227f0fc18cd8d36bd92c1e93eff8@epcas3p4.samsung.com>
        <1505392334-8001-1-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1505392334-8001-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, sparclinux@vger.kernel.org


[ added dri-devel & sparclinux MLs to cc: ]

On Thursday, September 14, 2017 06:02:14 PM Bhumika Goyal wrote:
> Make these structures static as they are not referenced in any other
> file. Make them const as they are used only during a copy operation.
> Replace __initdata with __initconst in file igafb.c to avoid section
> conflict error.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> The changes are not compile tested as I could not find the right 
> architecture to cross compile the files.
> 
>  drivers/video/fbdev/dnfb.c  | 2 +-
>  drivers/video/fbdev/igafb.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

You can deduce such things by looking into Makefile-s and KConfig-s:
- dnfb is used by apollo platform of m68k arch
- igafb can be used on sparc32 arch

I took care of compile testing these changes and discovered that
in the current vanilla kernel (v4.14-rc4) igafb fails to build.

Thus I've only queued dnfb changes for v4.15 kernel for now.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

