From: David Miller <davem@davemloft.net>
Date: Mon, 15 Jun 2009 09:12:04 +0000
Subject: Re: [PATCH] silo: move second to make room for larger kernel
Message-Id: <20090615.021204.08039905.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A325654.3050201@earthlink.net>
In-Reply-To: <4A325654.3050201@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Sun, 14 Jun 2009 08:59:50 -0400

> Would it be possible to use silo to load the kernel at its
> final destination like the sun bootloader aparently does?
> 
> This seems so simple that I can't believe it hasn't been
> done before so there must be issues with this approach.
> 
> Can anyone please give me some feedback?

We just never implemented this way because there was never
a need for such complexity.  Originally the kernel was A.OUT
and we need to support relocation for the sake of network
booting anyways.

You will need to make the relocation case work for the sake
of net booting no matter what.  Otherwise large kernels will
work for SILO boots but not for networking boots, which
eliminates an installation scheme for a whole class of users.

Why not simply make the relocating code move more than 3MB
of mappings to the final location?  What prevents that from
working?
