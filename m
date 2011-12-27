From: David Miller <davem@davemloft.net>
Date: Tue, 27 Dec 2011 19:12:02 +0000
Subject: Re: [PATCH 2/2] sparc32: drop useless preprocessor conditional in
Message-Id: <20111227.141202.1778554639950746015.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111226222955.GB20839@merkur.ravnborg.org>
In-Reply-To: <20111226222955.GB20839@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 26 Dec 2011 23:29:55 +0100

>>From 87e57f5d7e32a974416f91e238b33fb6d8297e93 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 26 Dec 2011 21:05:27 +0100
> Subject: [PATCH 2/2] sparc32: drop useless preprocessor conditional in atomic_32.h
> 
> arch/sparc/include/asm/atomic_32.h is not exported to userspace.
> So there is no need to protect code using __KERNEL__.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
