From: David Miller <davem@davemloft.net>
Date: Mon, 07 Jul 2008 01:18:22 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080706.181822.104941033.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 6 Jul 2008 22:06:37 +0200

> I have now added the appended commit and the full series
> can be pulled from:
> 
>    ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc2.git master
> 
> I have tested that sparc64 continue to build and that we indeed
> add the -m64 option to gcc when we build vmlinux.lds
> iLet me know if this series is better.

Something is still messed up, the whole build now complains about
things like:

init/initramfs.c: In function 'flush_window':
init/initramfs.c:433: warning: pointer targets in passing argument 1 of 'flush_buffer' differ in signedness
init/initramfs.c: In function 'unpack_to_rootfs':
init/initramfs.c:474: warning: pointer targets in assignment differ in signedness

So things are still busted with bi-arch compilers.

It seems that adding "-m64" to the kbuild CPPFLAGS does not propagate
"-m64" to the kbuild CFLAGS.  So your "fix" changeset idea to remove
"-m64" from the kbuild CFLAGS does not aparently work.

Please build a bi-arch compiler that defaults to -m32 ;-) Or at least,
look at the command line with some higher verbosity levels.  You know
how to do that right? :-)))



