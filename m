From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: Mon, 17 May 2004 14:59:40 +0000
Subject: Re: [SPARC64] Need help..
Message-Id: <xlty8nrt7z7.fsf@shookay.newview.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58L.0405171051230.1247@alpha.zarz.agh.edu.pl>
In-Reply-To: <Pine.LNX.4.58L.0405171051230.1247@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, you're cross-compiling I guess, no?

cieciwa@alpha.zarz.agh.edu.pl ("Wojciech 'Sas' Cieciwa") writes:
> I try to build kernel 2.6.6 on my machine, but when I build module I got 
> some strange message:
> 
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "" [lib/zlib_inflate/zlib_inflate.ko] undefined!
> *** Warning: "current_thread_info_reg" [lib/zlib_inflate/zlib_inflate.ko] undefined!
> [...]
> 
> This message i teke from all modules which I build.
> What's wrong ?
> And how to repair this?

Nothing's wrong, it's a bug in scripts/modpost.c. I've sent a fix and it's
in bk now. Here it is:

--- scripts/modpost.c.orig      2004-05-12 13:58:58.000000000 -0400
+++ scripts/modpost.c   2004-05-12 14:05:20.000000000 -0400
@@ -267,6 +267,7 @@
        hdr->e_shoff    = TO_NATIVE(hdr->e_shoff);
        hdr->e_shstrndx = TO_NATIVE(hdr->e_shstrndx);
        hdr->e_shnum    = TO_NATIVE(hdr->e_shnum);
+       hdr->e_machine  = TO_NATIVE(hdr->e_machine);
        sechdrs = (void *)hdr + hdr->e_shoff;
        info->sechdrs = sechdrs;


-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
