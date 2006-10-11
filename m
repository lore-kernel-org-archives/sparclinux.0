From: David Miller <davem@davemloft.net>
Date: Wed, 11 Oct 2006 21:51:03 +0000
Subject: Re: [PATCH 1/4] fix sparc32 modpost warnings
Message-Id: <20061011.145103.55575066.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061010154416.GB30909@palantir8>
In-Reply-To: <20061010154416.GB30909@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 11 Oct 2006 22:02:29 +0100

> OK, I am less confused now: the crux of the matter is that modpost only
> checks the relocatable sections. i386 vmlinux has none, so modpost does
> no checking on it (it does on the modules).
> However, sparc vmlinux has plenty of relocatable sections because it is
> being built with 'ld -r' (to allow for btfixup processing).
> So for sparc, modpost does do a lot of checking. Sure enough, running
> modpost on arch/sparc/boot/image yields no output (i.e. all is well).

Thanks for figuring this out, I'll apply your original patch now
that I understand what's going on :-)
