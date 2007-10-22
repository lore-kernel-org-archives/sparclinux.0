From: David Miller <davem@davemloft.net>
Date: Mon, 22 Oct 2007 09:33:19 +0000
Subject: Re: [PATCH] sparc64: small Makefile cleanups
Message-Id: <20071022.023319.74749910.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071022091733.GA11932@uranus.ravnborg.org>
In-Reply-To: <20071022091733.GA11932@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Oct 2007 11:17:33 +0200

> A few trivial Makefile cleanups
> - dependencipes in head.o was all wrong - deleted
> - CMODEL_CFLAG was not used anywhere
> - NEW_GCC was then not used outside sparc64/Makefe - do not export it
> - FIXME seems not appropriate - all other put oprofile in drivers-y too
> - No reason to do -I. (and it still builds)
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks!
