From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 19 Aug 2005 19:27:39 +0000
Subject: Re: current_thread_info_reg undefined
Message-Id: <20050819.122739.91628267.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ben Collins <bcollins@debian.org>
Date: Fri, 19 Aug 2005 04:31:29 -0700

> The empty symbol warnings atleast are just a bug with
> scripts/mod/modpost.c (the patch fabbione sent you awhile back Dave, for
> STT_SPARC_REGISTER changes in glibc's elf.h).
> 
> I think the current_thread_info_reg went away with that patch aswell. If
> it didn't, I have a fix for that one aswell.

That fix should be in current 2.6.x... Oh I see, it's still checking
just STT_REGISTER.  Ben, can you resend that patch to me?

