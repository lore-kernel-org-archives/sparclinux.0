From: David Miller <davem@davemloft.net>
Date: Sun, 06 Aug 2006 23:37:10 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <20060806.163710.13747870.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200608062109.k76L9c1T017778@harpo.it.uu.se>
In-Reply-To: <200608062109.k76L9c1T017778@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sun, 6 Aug 2006 23:09:38 +0200 (MEST)

> Correction, it turns out that all my 2.6 sparc64 kernels have
> had CONFIG_HUGETLBFS and CONFIG_HUGETLB_PAGE enabled.

Ok, thanks for the info.

I'm still a bit stumped about this bug and trying to figure out what's
wrong.  I'll let you know when I have a patch to test.

