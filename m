From: David Miller <davem@davemloft.net>
Date: Thu, 13 Sep 2007 09:33:15 +0000
Subject: Re: Is Sun putting much effort into supporting the gcc/binutils
Message-Id: <20070913.023315.74722453.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46E7CF5F.3090909@walrond.org>
In-Reply-To: <46E7CF5F.3090909@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Date: Thu, 13 Sep 2007 11:16:00 +0200

> As far as I know, GCC for SPARC appears to be a front end
> to the Sun Studio compiler which happens to translate GCC
> flags to ones suitable for their own compiler.

That's correct, it's essentially GCC's language front ends
plugged into Sun's compiler backend.
