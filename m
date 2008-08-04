From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 04 Aug 2008 14:05:32 +0000
Subject: Re: sparc64: build failure at sys_sparc32.c
Message-Id: <20080804140532.GI6088@cs181140183.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20080729065914.GA30878@orion> <20080729.001256.203097603.davem@davemloft.net> <a4423d670807290138p4a666337id74fe1fa637932e4@mail.gmail.com> <20080803.181934.262275514.davem@davemloft.net>
In-Reply-To: <20080803.181934.262275514.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: a.beregalov@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Aug 03, 2008 at 06:19:34PM -0700, David Miller wrote:
> From: "Alexander Beregalov" <a.beregalov@gmail.com>
> Date: Tue, 29 Jul 2008 12:38:38 +0400
> 
> > 2008/7/29 David Miller <davem@davemloft.net>:
> > > From: Alexander Beregalov <a.beregalov@gmail.com>
> > > Date: Tue, 29 Jul 2008 10:59:14 +0400
> > >
> > >> I am testing build using randconfig.
> > >>
> > >> arch/sparc64/kernel/sys_sparc32.c: In function 'sys32_chown16':
> > >> arch/sparc64/kernel/sys_sparc32.c:63: error: implicit declaration of
> > >> function 'low2highuid'
> > >> arch/sparc64/kernel/sys_sparc32.c:63: error: implicit declaration of
> > >> function 'low2highgid'
> > >> arch/sparc64/kernel/sys_sparc32.c: In function 'sys32_getresuid16':
> > >> arch/sparc64/kernel/sys_sparc32.c:106: error: implicit declaration of
> > >> function 'high2lowuid'
> > >> arch/sparc64/kernel/sys_sparc32.c: In function 'sys32_getresgid16':
> > >> arch/sparc64/kernel/sys_sparc32.c:123: error: implicit declaration of
> > >> function 'high2lowgid'
> > >>
> > >> These functions are defined in linux/highuid.h only if CONFIG_UID16 is enabled.
> > >
> > > Thanks, what kernel version is this?
> > 
> > It is current by default - .27-rc1. These files were not touched for a
> > long time.
> > But, OK, I will mention the kernel version every time.
> 
> This is basically setup to fail.
> 
> If SPARC64 && COMPAT this option should always be set.  But it's
> left as an option the user can still disable in this case down
> in init/Kconfig.
> 
> This can be triggered very likely on other platforms too.
> 
> Can someone take a look at fixing this properly?  Make it something
> that is selected on necessary platforms, for example.

The only platforms that do their own stuff instead of using the 
functions from kernel/uid16.c are sparc64 and s390.

Is there any reason why sparc64 has it's own functions?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

