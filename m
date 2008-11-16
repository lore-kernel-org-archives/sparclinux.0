From: David Miller <davem@davemloft.net>
Date: Sun, 16 Nov 2008 09:06:09 +0000
Subject: Re: [PATCH] sparc,sparc64: unify Kconfig
Message-Id: <20081116.010609.39990282.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1226825821-10125-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1226825821-10125-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 09:56:57 +0100

> +config ARCH_SPARSEMEM_DEFAULT
> +	def_bool y if PSARC64

Come on Sam... obvious typo making ARCH_SPARSEMEM_DEFAULT not
get set after this change on sparc64.

Also, there are other bugs, RWSEM_XCHGADD_ALGORITHM is now also
different.  sparc32 just has it as "bool" whereas sparc64 makes it:

	bool
	default y

Every time I get this patch I start with a fresh "make oldconfig"
of arch/sparc64/defconfig, I apply the change, and I rerun
"make oldconfig" and diff the result.  Are you doing this too? :)

Also, none of the patch postings are numbered, so I will need to
figure out the dependencies and ordering of the math-emu bits.
