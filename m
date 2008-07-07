From: David Miller <davem@davemloft.net>
Date: Mon, 07 Jul 2008 07:54:40 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080707.005440.215601883.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 7 Jul 2008 09:46:00 +0200

> # disable pointer signed / unsigned warnings in gcc 4.0
> KBUILD_CFLAGS += $(call cc-option,-Wno-pointer-sign,)
> 
> When we do the above check we use KBUILD_CFLAGS direct
> and does not include KBUILD_CPPFLAGS - thus missing -m64.
> 
> So I think that your bi-arch sparc gcc only accepts
> -Wno-pointer-sign if -m64 is specified and that this
> option is missing with current patchset.
> At least that is my best explanation so far.

Yep, that the source of the problem.

What is happening is that the other sparc64 KBUILD_CFLAGS (such as
-mcmodel=medlow, etc.) are only legal during a 64-bit compile.  When
compiling 32-bit those options are not allowed.
