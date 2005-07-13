From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 13 Jul 2005 15:21:22 +0000
Subject: Re: [PATCH] modpost needs to cope with new glibc elf header on sparc (resend - my MTA did eat the pr
Message-Id: <20050713170655.GA8197@mars.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20050713062549.1ED325032@trider-g7.fabbione.net>
In-Reply-To: <20050713062549.1ED325032@trider-g7.fabbione.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

> Hi everybody,
>   recently a change in the glibc elf.h header has been introduced causing
> modpost to spawn tons of warnings (like the one below) building the kernel on sparc:
> 
Applied.

You need to reread SubmittingPatches:
> diff -urNad --exclude=CVS --exclude=.svn ./scripts/mod/modpost.c /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c
> --- ./scripts/mod/modpost.c	2005-06-17 21:48:29.000000000 +0200
> +++ /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c	2005-06-30 09:29:54.000000000 +0200

This does not apply with patch -p1. I fixed it manually.

	Sam
