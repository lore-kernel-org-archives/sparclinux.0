From: David Miller <davem@davemloft.net>
Date: Mon, 26 Feb 2007 19:12:19 +0000
Subject: Re: [PATCH 2.6.21-rc1] sparc64: fix CONFIG_PCI_MSI=n compile
Message-Id: <20070226.111219.41878241.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200702261854.l1QIs8D9013016@alkaid.it.uu.se>
In-Reply-To: <200702261854.l1QIs8D9013016@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 26 Feb 2007 19:54:08 +0100 (MET)

> 2.6.21-rc1 fails to build on sparc64 when CONFIG_PCI_MSI=n:

This is already fixed in my sparc-2.6 GIT tree as of a few
days ago, I'll push the fix to Linus later today.
