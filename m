From: David Miller <davem@davemloft.net>
Date: Sun, 25 Jun 2017 20:46:11 +0000
Subject: Re: [PATCH v2 00/12] Add MDESC & VIO support for VCC
Message-Id: <20170625.164611.80383357608966104.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1498238657.git.jag.raman@oracle.com>
In-Reply-To: <cover.1498238657.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 23 Jun 2017 14:58:28 -0400

> This series of patches is part of an effort to add VCC (Virtual Console
> Concentrator) support to Linux.
 ...

Series applied to sparc-next thanks.

I'm concerned about the MDESC allocation GFP flags change.

If we fail the MDESC update, that's it, we can end up never seeing the
new devices which were advertised or properly releasing the ones which
got removed.

If GFP_NOFAIL isn't the solution, then we need something that is.

A bulletproof solution would be possible if we knew the sizes of the
MDESC or an upper bounds ahead of time, but of course we do not.  That
way we could simply always have two buffers, and switch from one to
the other when an MDESC update occurs.

Any better ideas?
