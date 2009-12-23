From: David Miller <davem@davemloft.net>
Date: Wed, 23 Dec 2009 21:23:57 +0000
Subject: Re: arch/sparc/include/asm/uaccess_64.h warning/error
Message-Id: <20091223.132357.226765420.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.0912231041010.1790@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.0912231041010.1790@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Dec 2009 10:48:22 +0200 (EET)

> Like on x86, I got an error with CONFIG_DEBUG_STRICT_USER_COPY_CHECKS on 
> sparc64 too:

And like on x86 it's intentional.

Use this config option only if you want to help audit the kernel at
locations where this build failure triggers.
