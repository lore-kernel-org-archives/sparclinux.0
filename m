From: Baurzhan Ismagulov <ibr@radix50.net>
Date: Thu, 03 Mar 2005 19:40:22 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <20050303194022.GA27502@radix50.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Mar 03, 2005 at 09:19:40AM -0800, Dennis Jenkins wrote:
> Yup, I read that too.  And immediately there after I
> downloaded the last 2.2 kernel and tried to compile
> it.  Unfortunately for me, GCC 3.3.5 choked heavily on
> it.  I will try again when I figure out how to get
> Gentoo to downgrade gcc.  The question is, what
> version should I downgrade to?

Perhaps something like
ftp://ftp.de.debian.org/debian-archive/dists/potato/main/source/devel/egcs64_19980921-4.dsc

However, I don't know which version you need to compile it :) .

With kind regards,
Baurzhan.
