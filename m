From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 05 Jun 2005 21:30:21 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32
Message-Id: <20050605.143021.59473087.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Sat, 04 Jun 2005 11:34:25 -0500

> Look for hypersparc_copy_1page in arch/sparc/mm/hypersparc.S where it 
> uses ASI_M_BCOPY.  I think the src and dest need to be 32 byte aligned 
> in this case.

We fixed a similar problem in the past, by putting the
"aligned to 8 bytes" check into __constant_memcpy().

Let's just remove the __copy_1page() optimization altogether,
it causes more trouble than it's worth.  Similarly for
memset().

In fact, most of this inline stuff can be removed entirely.
In particular, we should just use a plain memcpy() symbol
and let GCC output the inline builtin copy if it wants
to automatically.
