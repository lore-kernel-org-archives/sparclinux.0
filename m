From: David Miller <davem@davemloft.net>
Date: Tue, 26 Jan 2016 06:51:00 +0000
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate in_compat_syscall implementation
Message-Id: <20160125.225100.1932707129794761764.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
	<e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
	<20160126062951.GA17107@ravnborg.org>
In-Reply-To: <20160126062951.GA17107@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: luto@kernel.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, torvalds@linux-foundation.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, cmetcalf@ezchip.com, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 26 Jan 2016 07:29:51 +0100

> Could you please add a comment about where 0x110 comes from.
> I at least failed to track this down.

Frankly I'm fine with this.  Someone who understands sparc64 can look
at the trap table around entry 0x110 and see:

tl0_resv10e:	BTRAP(0x10e) BTRAP(0x10f)
tl0_linux32:	LINUX_32BIT_SYSCALL_TRAP
tl0_oldlinux64:	LINUX_64BIT_SYSCALL_TRAP
