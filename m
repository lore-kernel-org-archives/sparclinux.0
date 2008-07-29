From: David Miller <davem@davemloft.net>
Date: Tue, 29 Jul 2008 07:12:56 +0000
Subject: Re: sparc64: build failure at sys_sparc32.c
Message-Id: <20080729.001256.203097603.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080729065914.GA30878@orion>
In-Reply-To: <20080729065914.GA30878@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 29 Jul 2008 10:59:14 +0400

> I am testing build using randconfig.
> 
> arch/sparc64/kernel/sys_sparc32.c: In function 'sys32_chown16':
> arch/sparc64/kernel/sys_sparc32.c:63: error: implicit declaration of
> function 'low2highuid'
> arch/sparc64/kernel/sys_sparc32.c:63: error: implicit declaration of
> function 'low2highgid'
> arch/sparc64/kernel/sys_sparc32.c: In function 'sys32_getresuid16':
> arch/sparc64/kernel/sys_sparc32.c:106: error: implicit declaration of
> function 'high2lowuid'
> arch/sparc64/kernel/sys_sparc32.c: In function 'sys32_getresgid16':
> arch/sparc64/kernel/sys_sparc32.c:123: error: implicit declaration of
> function 'high2lowgid'
> 
> These functions are defined in linux/highuid.h only if CONFIG_UID16 is enabled.

Thanks, what kernel version is this?
