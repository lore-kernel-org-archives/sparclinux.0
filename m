From: David Miller <davem@davemloft.net>
Date: Mon, 16 Jun 2008 23:33:03 +0000
Subject: Re: unify sparc and sparc64 headers
Message-Id: <20080616.163303.13826112.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080613195449.GA9141@uranus.ravnborg.org>
In-Reply-To: <20080613195449.GA9141@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 21:54:49 +0200

> The full set can be pulled from:
> 
>    ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc.git
> 
> And will follow as mails too.

This looks OK.

About asm/openprom.h, I am very sure we can kill that export to
userspace.  The only real user is the SILO boot loader and nowadays
SILO includes it's own copy of the kernel headers it needs so we can
safely remove the export on the kernel side.
