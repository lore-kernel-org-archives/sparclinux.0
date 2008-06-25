From: David Miller <davem@davemloft.net>
Date: Wed, 25 Jun 2008 22:09:31 +0000
Subject: Re: [10 PATCHES] inline functions to avoid stack overflow
Message-Id: <20080625.150931.182895076.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
	<486216E7.8000002@aitel.hist.no>
	<Pine.LNX.4.64.0806250843460.20379@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806250843460.20379@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: helge.hafting@aitel.hist.no, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 25 Jun 2008 08:53:10 -0400 (EDT)

> Even worse, gcc doesn't use these additional bytes. If you try this:
> 
> extern void f(int *i);
> void g()
> {
>          int a;
>          f(&a);
> }
> 
> , it allocates additional 16 bytes for the variable "a" (so there's total 
> 208 bytes), even though it could place the variable into 48-byte 
> ABI-mandated area that it inherited from the caller or into it's own 
> 16-byte padding that it made when calling "f".

The extra 16 bytes of space allocated is so that GCC can perform a
secondary reload of a quad floating point value.  It always has to be
present, because we can't satisfy a secondary reload by emitting yet
another reload, it's the end of the possible level of recursions
allowed by the reload pass.

GCC could be smart and eliminate that slot when it's not used, but
such a thing is not implemented yet.

It would also require quite a bit of new code to determine cases
like you mention above, where the incoming arg slots from the
caller are unused, assuming this would be legal.

And that legality is doubtful.  We'd need to be careful because I
think the caller is allowed to assume that those slots are untouched
by the callee, and thus can be assumed to have whatever values the
caller put there even after the callee returns.
