From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
Date: Wed, 13 Jul 2005 19:20:51 +0000
Subject: Re: [PATCH] modpost needs to cope with new glibc elf header on sparc
Message-Id: <42D56993.2040102@fabbione.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050713062549.1ED325032@trider-g7.fabbione.net> <20050713170655.GA8197@mars.ravnborg.org>
In-Reply-To: <20050713170655.GA8197@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Sam Ravnborg wrote:
>>Hi everybody,
>>  recently a change in the glibc elf.h header has been introduced causing
>>modpost to spawn tons of warnings (like the one below) building the kernel on sparc:
>>
> 
> Applied.
> 

Thanks

> You need to reread SubmittingPatches:

I will..

> 
>>diff -urNad --exclude=CVS --exclude=.svn ./scripts/mod/modpost.c /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c
>>--- ./scripts/mod/modpost.c	2005-06-17 21:48:29.000000000 +0200
>>+++ /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c	2005-06-30 09:29:54.000000000 +0200
> 
> 
> This does not apply with patch -p1. I fixed it manually.

.. but it does here...

fabbione@gordian:/usr/src/wartydevel/kernel/breezy/linux-source-2.6.12-2.6.12$ patch -p1 <
debian/patches/scripts-mod-modpost_deal-with-new-glibc.dpatch
patching file scripts/mod/modpost.c
fabbione@gordian:/usr/src/wartydevel/kernel/breezy/linux-source-2.6.12-2.6.12$ patch -Rp1 <
debian/patches/scripts-mod-modpost_deal-with-new-glibc.dpatch
patching file scripts/mod/modpost.c
fabbione@gordian:/usr/src/wartydevel/kernel/breezy/linux-source-2.6.12-2.6.12$

Thanks a lot.
Fabio

-- 
no signature file found.
