From: David Miller <davem@davemloft.net>
Date: Tue, 25 Jan 2011 00:11:32 +0000
Subject: Re: [RFC PATCH 0/7] sparc32: cleanup irq + smp files
Message-Id: <20110124.161132.242141846.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110123213940.GA15063@merkur.ravnborg.org>
In-Reply-To: <20110123213940.GA15063@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 23 Jan 2011 22:54:38 +0100

> The patches survied my SPARCclassic config and defconfig.
> But allnoconfig bails out with an error.
> 
> This is because asm-generic/tlb.h require linux/pagemap.h.
> The include happended implicitly before.
> 
> 
> Workaround is simple - see below.
> I will try to get it fixed in asm-generic for benefit of all users.

Please get this fix in asm-generic and merged upstream, then
repost your series and mention this dependency so I can merge
in Linus's tree first.

Thanks.
