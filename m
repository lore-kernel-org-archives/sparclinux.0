From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 06:32:54 +0000
Subject: Re: [PATCH 0/8] diverse sparc32 patches (mostly leon related)
Message-Id: <20120520.023254.1380633029031644937.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120520060009.GA18477@merkur.ravnborg.org>
In-Reply-To: <20120520060009.GA18477@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 08:00:09 +0200

> I have looked a bit more into proper integration of leon.
> Following is a few random patches as spin-off by this.
> 
> I actually considered creating mm/mmu_viking.c, mm/mmu_turbosparc.c etc.
> But for now I left it all in srmmu.c.
> 
> As I introduced a dedicated traptable file for sparc32, I renamed
> the sparc64 variant.
> This change is not build tested (lacks sparc64 gcc on this box).

All applied, and I'll test the sparc64 trap table bit.

Also, some of your patches added empty newlines at end of file,
I fixed it up.  This has happened a few times before, please do
something to prevent this in the future if you don't mind :)
