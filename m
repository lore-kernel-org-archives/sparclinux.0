From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 22 Sep 2019 11:46:40 +0000
Subject: Re: latest git kernel (v5.3-11506-gf7c3bf8fa7e5) does not compile
Message-Id: <CAK7LNASgNh04dAn6Fe4A2Dfhu55Vtk=jeNqC6_HNQHbyNMkoZA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwizJ2HXdiU7aSH9t=ecBEHnxdVVsQ4wUpTYRpCgdXf=w@mail.gmail.com>
 <CADxRZqzx=8jNQuvi8WN=7U_G5a0f+v_GODHH8q3QJVYmg=n1LA@mail.gmail.com>
In-Reply-To: <CADxRZqzx=8jNQuvi8WN=7U_G5a0f+v_GODHH8q3QJVYmg=n1LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Sun, Sep 22, 2019 at 5:33 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> On Sun, Sep 22, 2019 at 11:13 AM Anatoly Pugachev <matorola@gmail.com> wrote:
> >
> > Hello!
> >
> > Latest git kernel does not compile for me:
> >
> > ~/linux-2.6$ git desc
> > v5.3-11506-gf7c3bf8fa7e5
> >
> > ~/linux-2.6$ make
> >   CALL    scripts/checksyscalls.sh
> > <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> >   CALL    scripts/atomic/check-atomics.sh
> >   CHK     include/generated/compile.h
> >   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> > unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> > arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> > make[2]: *** [scripts/Makefile.build:266:
> > arch/sparc/vdso/vdso32/vclock_gettime.o] Error 1
> > make[2]: *** Deleting file 'arch/sparc/vdso/vdso32/vclock_gettime.o'
> > make[1]: *** [scripts/Makefile.build:509: arch/sparc/vdso] Error 2
> > make: *** [Makefile:1667: arch/sparc] Error
> >
> > but I was able to compile successfully v5.3-10169-g574cc4539762
> >
> > Not sure my bisect log is right, but here it is:
> >
> > $ git bisect good
> > 54b8ae66ae1a3454a7645d159a482c31cd89ab33 is the first bad commit
> > commit 54b8ae66ae1a3454a7645d159a482c31cd89ab33
> > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Date:   Fri Aug 30 13:34:01 2019 +0900
> >
> >     kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)
> >
> >     Kbuild provides per-file compiler flag addition/removal:
> >
> >       CFLAGS_<basetarget>.o
> >       CFLAGS_REMOVE_<basetarget>.o
> >       AFLAGS_<basetarget>.o
> >       AFLAGS_REMOVE_<basetarget>.o
> >       CPPFLAGS_<basetarget>.lds
> >       HOSTCFLAGS_<basetarget>.o
> >       HOSTCXXFLAGS_<basetarget>.o
> >
> >     The <basetarget> is the filename of the target with its directory and
> >     suffix stripped.
> >
> >     This syntax comes into a trouble when two files with the same basename
> >     appear in one Makefile, for example:
> >
> >       obj-y += foo.o
> >       obj-y += dir/foo.o
> >       CFLAGS_foo.o := <some-flags>
> >
> >     Here, the <some-flags> applies to both foo.o and dir/foo.o
> >
> >     The real world problem is:
> >
> >       scripts/kconfig/util.c
> >       scripts/kconfig/lxdialog/util.c
> >
> >     Both files are compiled into scripts/kconfig/mconf, but only the
> >     latter should be given with the ncurses flags.
> >
> >     It is more sensible to use the relative path to the Makefile, like this:
> >
> >       obj-y += foo.o
> >       CFLAGS_foo.o := <some-flags>
> >       obj-y += dir/foo.o
> >       CFLAGS_dir/foo.o := <other-flags>
> >
> >     At first, I attempted to replace $(basetarget) with $*. The $* variable
> >     is replaced with the stem ('%') part in a pattern rule. This works with
> >     most of cases, but does not for explicit rules.
> >
> >     For example, arch/ia64/lib/Makefile reuses rule_as_o_S in its own
> >     explicit rules, so $* will be empty, resulting in ignoring the per-file
> >     AFLAGS.
> >
> >     I introduced a new variable, target-stem, which can be used also from
> >     explicit rules.
> >
> >     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >     Acked-by: Marc Zyngier <maz@kernel.org>
> >
> >  arch/arm/kvm/Makefile                         |  5 +++--
> >  arch/x86/entry/vdso/Makefile                  |  3 ++-
> >  drivers/gpu/drm/amd/display/dc/calcs/Makefile |  6 +++---
> >  drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  2 +-
> >  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 17 +++++++----------
> >  drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  7 +++----
> >  drivers/gpu/drm/i915/Makefile                 |  2 +-
> >  scripts/Makefile.host                         | 22 +++++++++++-----------
> >  scripts/Makefile.lib                          | 13 ++++++++-----
> >  scripts/kconfig/Makefile                      |  8 ++++----
> >  10 files changed, 43 insertions(+), 42 deletions(-)
> > mator@ttip:~/linux-2.6$
> >
> >
> > If someone wants to check how kernel compiles on sparc64, could use
> > gcc compile farm machine (gcc202) to try on.
>
> and i cannot test compile 54b8ae66ae1a3454a7645d159a482c31cd89ab33 as well :
>
> ~/linux-2.6$ git checkout 54b8ae66ae1a3454a7645d159a482c31cd89ab33
> HEAD is now at 54b8ae66ae1a kbuild: change *FLAGS_<basetarget>.o to
> take the path relative to $(obj)
>
> ~/linux-2.6$ make -j clean; make -j olddefconfig && nice make -j24
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   LEX     scripts/kconfig/lexer.lex.c
>   YACC    scripts/kconfig/parser.tab.[ch]
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf  --olddefconfig Kconfig
> #
> # No change to .config
> #
> scripts/kconfig/conf  --syncconfig Kconfig
> { command -v gcc; } >/dev/null 2>&1 && echo "n" || echo "y": Cannot
> allocate memory
> make[2]: *** [scripts/kconfig/Makefile:73: syncconfig] Error 1
> make[1]: *** [Makefile:584: syncconfig] Error 2
> make: *** [Makefile:695: include/config/auto.conf.cmd] Error 2
> ~/linux-2.6$
>
>
>
> PS: unable to compile kernel makes its bisection impossible =(


I have no idea about this error because this
seems unrelated to commit 54b8ae66ae1a3454a7645d159a482c31cd89ab33

From the error message "Cannot allocate memory",
maybe, your machine was in the memory shortage.

(If you have the steps to reproduce it, please share it.)

Thanks.

-- 
Best Regards
Masahiro Yamada
