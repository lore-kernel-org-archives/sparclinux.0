From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Sun, 04 Jan 2009 10:10:42 +0000
Subject: Re: [PATCH] sparc: Clean arch-specific code in prom_common.c
Message-Id: <646765f40901040210y2137e0aao318dfe945727af1c@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <49601548.509@gmail.com>
In-Reply-To: <49601548.509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 4, 2009 at 19:51, Sam Ravnborg <sam@ravnborg.org> wrote:
> Looks good.
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Thanks!

> As a natural next step you could eliminate the following:
> #ifdef CONFIG_SPARC32
>                strcpy(p->name, name);
> #endif
>
> by moving this strcpy() to the prom_* functions
> for sparc32.

It's happening soon, but there's other changes that have to happen at
the same time to have it not be useless code, so that's happening with
some of the cleanups of the prom/tree_*.c files prior to their
unification.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
