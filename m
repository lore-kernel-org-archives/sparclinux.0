From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 15 Apr 2006 02:44:44 +0000
Subject: Re: More on the Sun Disk Label Issue
Message-Id: <20060414.194444.00566729.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <443AE0BA.8070706@jg555.com>
In-Reply-To: <443AE0BA.8070706@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Fri, 14 Apr 2006 17:47:47 -0700

> http://www.linuxfromscratch.org/patches/downloads/util-linux/util-linux-2.12r-gcc41_sun_disklabel_fixes-1.patch

Looks like you're simply working around a bug in the compiler.
That code has been in the kernel and util-linux for 10+ years.

Submit a bug report for gcc and get that bug fixed instead of papering
around the problem.

Thanks.
