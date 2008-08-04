From: David Miller <davem@davemloft.net>
Date: Mon, 04 Aug 2008 01:19:34 +0000
Subject: Re: sparc64: build failure at sys_sparc32.c
Message-Id: <20080803.181934.262275514.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080729065914.GA30878@orion>
	<20080729.001256.203097603.davem@davemloft.net>
	<a4423d670807290138p4a666337id74fe1fa637932e4@mail.gmail.com>
In-Reply-To: <a4423d670807290138p4a666337id74fe1fa637932e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Tue, 29 Jul 2008 12:38:38 +0400

> 2008/7/29 David Miller <davem@davemloft.net>:
> > From: Alexander Beregalov <a.beregalov@gmail.com>
> > Date: Tue, 29 Jul 2008 10:59:14 +0400
> >
> >> I am testing build using randconfig.
> >>
> >> arch/sparc64/kernel/sys_sparc32.c: In function 'sys32_chown16':
> >> arch/sparc64/kernel/sys_sparc32.c:63: error: implicit declaration of
> >> function 'low2highuid'
> >> arch/sparc64/kernel/sys_sparc32.c:63: error: implicit declaration of
> >> function 'low2highgid'
> >> arch/sparc64/kernel/sys_sparc32.c: In function 'sys32_getresuid16':
> >> arch/sparc64/kernel/sys_sparc32.c:106: error: implicit declaration of
> >> function 'high2lowuid'
> >> arch/sparc64/kernel/sys_sparc32.c: In function 'sys32_getresgid16':
> >> arch/sparc64/kernel/sys_sparc32.c:123: error: implicit declaration of
> >> function 'high2lowgid'
> >>
> >> These functions are defined in linux/highuid.h only if CONFIG_UID16 is enabled.
> >
> > Thanks, what kernel version is this?
> 
> It is current by default - .27-rc1. These files were not touched for a
> long time.
> But, OK, I will mention the kernel version every time.

This is basically setup to fail.

If SPARC64 && COMPAT this option should always be set.  But it's
left as an option the user can still disable in this case down
in init/Kconfig.

This can be triggered very likely on other platforms too.

Can someone take a look at fixing this properly?  Make it something
that is selected on necessary platforms, for example.
