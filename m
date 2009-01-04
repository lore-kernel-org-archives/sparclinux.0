From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Sun, 04 Jan 2009 10:20:27 +0000
Subject: Re: [PATCH] sparc: Merge sparc_ksyms_{32,64}.c
Message-Id: <646765f40901040220k5381b746he3997f8fd0abb953@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4960225E.1000801@gmail.com>
In-Reply-To: <4960225E.1000801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 4, 2009 at 19:43, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Julian.
>
> As a first step before trying to merge these two files
> all EXPORT_SYMBOL() that exports symbols defined in .C files
> shall be moved out to their respective definition site.

Ok.

> You also need to pay attention to all the
> prototypes and extern's in the sparc_kysms.c files.
>
> If they are still needed they belong to a header file.

Ok.

> This is all straightforward to do it just take some time.
> And if you keep your patches sufficienly small then it
> should be easy to review too.

Ok.

Some explanation:

This was a (wrong) first step before doing the unification of arch/sparc/prom/*.

I think I'll take some of the lower hanging fruit first.

After I kill PROMLIB_INTERNAL and the exported definitions of
__prom_*(), I think I'll work on unifying include/asm/oplib_*.h as
that will make later changes smaller.

As for moving the EXPORT_SYMBOL()s out of here, I think I'll leave the
code as it is and eliminate most of the code in kernel/sparc_ksyms_*.c
as a final step.

Thanks for the advice!

-- 

Julian Calaby

Email: julian.calaby@gmail.com
