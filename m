Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ADFC433EF
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 08:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6766109D
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 08:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbhIGI6E (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 04:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242828AbhIGI6E (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 7 Sep 2021 04:58:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50391610E9;
        Tue,  7 Sep 2021 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631005018;
        bh=5FwQgdqHiCk4qrBnRBDZ7R7Y2Jv/W7kGMEfNG3K45Ow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IxBWPDbyminDJoUjkG8JLHkVQs53VG2rSy2PMTLjhNcpkmGV/rqRf7JS/LDrPOvvL
         wSDxqqwD11o+Mfp/VnMhKJoxmiFXqP0yBBRy/QmAVinmfb7kO7IQ4bH1Y27Lrgpvjp
         UJJ9zPVeRkZwwddAB3GMtVsFsQPM3dOXsSNZ+OFW49RhRp5t+02cxvMAUXwgVY4vvQ
         URLmN+R8zK8gjZivYLS546CYX6mtWP/dJIJuKjQaY2QpNPyQ3QBYZ42tY5YfQdT9F9
         xFvmc64wXVS0AVmJ/HKtdAWGix+Dq7GZjqsFl47aL4BYwjFz9n3fwn6Z+LcUfMDRsm
         iPiRJAjY7D9sA==
Received: by mail-wm1-f52.google.com with SMTP id m2so6272504wmm.0;
        Tue, 07 Sep 2021 01:56:58 -0700 (PDT)
X-Gm-Message-State: AOAM533yNAenEQkhiknSAHEo/BLeoi4iBidPQeKBSsrXIkbzXlCOkJxA
        tvy/cGY1h7OHKmpi/bFmuDljPoeY/+9gsltPs5I=
X-Google-Smtp-Source: ABdhPJyIHAJwziASQyXA9WKTYbsUInPiF9gmsApUbOfB+4JGIVFUSDgi+Cwpjh7mT4/KI95EIaWeWfoocM4PirSjR0s=
X-Received: by 2002:a1c:3182:: with SMTP id x124mr2756387wmx.35.1631005016875;
 Tue, 07 Sep 2021 01:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
In-Reply-To: <20210906234921.GA1394069@roeck-us.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 7 Sep 2021 10:56:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2H6HMpz26myHXYr+5cR=PM1hbW8=afy5LaEJTj28a8WQ@mail.gmail.com>
Message-ID: <CAK8P3a2H6HMpz26myHXYr+5cR=PM1hbW8=afy5LaEJTj28a8WQ@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 7, 2021 at 1:51 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Sep 06, 2021 at 04:06:04PM -0700, Linus Torvalds wrote:
> > [ Adding some subsystem maintainers ]
> >
> > On Mon, Sep 6, 2021 at 10:06 AM Guenter Roeck <linux@roeck-us.net> wrot=
e:
> > >
> > > > But hopefully most cases are just "people haven't cared enough" and
> > > > easily fixed.
> > >
> > > We'll see. For my testbed I disabled the new configuration flag
> > > for the time being because its primary focus is boot tests, and
> > > there won't be any boot tests if images fail to build.
> >
> > Sure, reasonable.
> >
> > I've checked a few of the build errors by doing the appropriate cross
> > compiles, and it doesn't seem bad - but it does seem like we have a
> > number of really pointless long-standing warnings that should have
> > been fixed long ago.

I have a tree with fixes for anything that has hit on arm, arm64 or x86.
There are many reasons why some patch never made it in, but usually
it's because I was not persistent about resending the fix when the first
version didn't make it. In other cases I wasn't sure about my own fix.

> > For example, looking at sparc64, there are several build errors due to
> > those warnings now being fatal:
> >
> >  - drivers/gpu/drm/ttm/ttm_pool.c:386
> >
> >    This is a type mismatch error. It looks like __fls() on sparc64
> > returns 'int'. And the ttm_pool.c code assumes it returns 'unsigned
> > long'.
> >    Oddly enough, the very line after that line does "min_t(unsigned
> > int" to get the types in line.
> >    So  the immediate reason is "sparc64 is different".

arc is the same as sparc here, but everything else uses unsigned long.
We've come a long way in making all those helper functions consistent
in their types, but there are still a number of exceptions.

> > But the deeper
> > reason seems to be that ttm_pool.c has odd type assumptions. But that
> > warning should have been fixed long ago, either way.
> >
> >    Christian/Huang? I get the feeling that both lines in that file
> > should use the min_t(). Hmm?
> >
> >  - drivers/input/joystick/analog.c:160
> >
> >    #warning Precise timer not defined for this architecture.
> >
> >    Unfortunate. I suspect that warning just has to be removed. It has
> > never caused anything to be fixed, it's old to the point of predating
> > the git history. Dmitry?
> >
> My solution would be to just remove the old code (that isn't using ktime)
> including the module parameter that disables it. Sure, we want to be
> backward compatible, but that code is 15+ years old and should really be
> retired.

Agreed. I added a couple of architectures to the #ifdef check over time,
but realistically this driver is only ever used on x86-32 anyway, and
we don't even care about the others here.

If we remove the #else path here, I'd make it "depends on ISA ||
COMPILE_TEST".

> >  - at least a couple of stringop-overread errors. Attached is a
> > possible for for one of them.
> >
> > The stringop overread is odd, because another one of them is
> >
> >    fs/qnx4/dir.c: In function =E2=80=98qnx4_readdir=E2=80=99:
> >    fs/qnx4/dir.c:51:32: error: =E2=80=98strnlen=E2=80=99 specified boun=
d 48 exceeds
> > source size 16 [-Werror=3Dstringop-overread]
> >       51 |                         size =3D strnlen(de->di_fname, size)=
;
> >          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > but I'm not seeing why that one happens on sparc64, but not on arm64
> > or x86-64. There doesn't seem to be anything architecture-specific
> > anywhere in that area.
> >
> > Funky.
> >
> Not really. That is because de->di_fname is always 16 bytes but size
> can be 48 if the node is really a link. The use of de is overloaded
> in that case; de is struct qnx4_inode_entry (where di_fname is 16 bytes)
> but the actual data is struct qnx4_link_info where the name is 48 bytes
> long. A possible fix (compile tested only) is below.
>
> I think the warning/error is only reported with gcc 11.x. Do you possibly
> use an older compiler for x86/arm64 ?
>
> Anyway, below is a partial list of build errors I have seen. Some of
> them are easy to fix (such as the ones due to unused functions),
> but others seem to be tricky.

This one is worse, I think this is the same warning as the one I
reported as a false-positive in
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99673
and https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99578

I submitted a patch in
https://lore.kernel.org/all/20210322160253.4032422-6-arnd@kernel.org/

To summarize the problems:

- gcc and clang have different approaches to this type of warning: clang
  tries to only produce diagnostics that are 100% reproducible regardless
  of compiler internals, while gcc tries to use as much information as it h=
as
  to warn about things that may go wrong, including things that it only kno=
ws
  because of inlining. Making this warning reliable is a variation of the
  halting problem, just like the -Wmaybe-uninitialized warnings. The diagno=
stic
  is definitely helpful and I found real bugs because of it, but you can ne=
ver
  be sure that you have found all instances.

- Some of the -Wstringop-overread warnings (and related ones) from gcc are
  actually wrong, because the object size is just a heuristic. If you
have multiple
  overlapping fixed-length fields in a union, gcc-11 picks one of the union
  members to determine the size of the string buffer within the structure, =
even
  when the string operation uses a different union member as the output, an=
d
  that member has the correct size.
  This is also a common problem: when a new warning option gets introduced
  first, there are false positives that get fixed in subsequent
compiler versions.


> alpha.log:arch/alpha/kernel/setup.c:493:13: error: 'strcmp' reading 1 or =
more bytes from a region of size 0 [-Werror=3Dstringop-overread]

I sent a couple of fixes for these: this is another false-postive bug
in gcc that made it
into the release, and it triggers on every architecture that accesses
the boot parameters
at a fixed pointer. The problem is that gcc treats '(void *)0x12345'
the same as 'NULL +
0x12345', and decides that this is an invalid NULL pointer access, so
the array has
zero readable bytes.

> alpha.log:drivers/atm/ambassador.c:1747:58: error: passing argument 1 of =
'virt_to_bus' discards 'volatile' qualifier from pointer target type [-Werr=
or=3Ddiscarded-qualifiers]

Surely an alpha specific mistake, though we could fix all those
drivers to drop the
'volatile'.

> alpha.log:drivers/net/ethernet/amd/ni65.c:751:37: error: cast from pointe=
r to integer of different size [-Werror=3Dpointer-to-int-cast]

Nobody tests ISA drivers on 64-bit architectures...

> alpha.log:drivers/net/hamradio/6pack.c:71:41: error: unsigned conversion =
from 'int' to 'unsigned char' changes value from '256' to '0' [-Werror=3Dov=
erflow]

This driver is apparently broken for any HZ >=3D 1024
> ppc.log:drivers/net/ethernet/cirrus/cs89x0.c:897:41: error: implicit decl=
aration of function 'isa_virt_to_bus' [-Werror=3Dimplicit-function-declarat=
ion]

My fix is in the network tree.

> riscv32.log:drivers/gpu/drm/rockchip/cdn-dp-core.c:1126:12: error: 'cdn_d=
p_resume' defined but not used [-Werror=3Dunused-function]
> riscv.log:drivers/gpu/drm/rockchip/cdn-dp-core.c:1126:12: error: 'cdn_dp_=
resume' defined but not used [-Werror=3Dunused-function]

A fix was submitted today, we get at least a dozen of those for each
kernel release, and there
is a plan for avoiding them altogether, but it's a giant treewide
change that nobody has managed
to tackle.

> s390.log:arch/s390/kernel/syscall.c:168:1: error: '__do_syscall' uses dyn=
amic stack allocation [-Werror]

This is add_random_kstack_offset(). No idea why it doesn't trigger on
x86, but that
warning should probably get shut up inside of the macro.

> sparc64.log:arch/sparc/kernel/mdesc.c:647:22: error: 'strcmp' reading 1 o=
r more bytes from a region of size 0 [-Werror=3Dstringop-overread]
> sparc64.log:arch/sparc/kernel/mdesc.c:692:22: error: 'strcmp' reading 1 o=
r more bytes from a region of size 0 [-Werror=3Dstringop-overread]
> sparc64.log:arch/sparc/kernel/mdesc.c:719:21: error: 'strcmp' reading 1 o=
r more bytes from a region of size 0 [-Werror=3Dstringop-overread]

Same as on alpha

       Arnd
