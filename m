From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Tue, 13 Jan 2004 20:06:34 +0000
Subject: Re: Status of Ross hyperSPARC on linux-2.4.x and linux-2.6.x?
Message-Id: <1074024394.4990.75.camel@zorak>
List-Id: <sparclinux.vger.kernel.org>
References: <20040113204206.A988@sparky.j-son.org>
In-Reply-To: <20040113204206.A988@sparky.j-son.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2004-01-13 at 13:42, christian@j-son.org wrote:
> Just a little ping for me (and anyone else).. what's the status of the
> linux kernels 2.4 and 2.6 for running Ross' hyperSPARC processors?

The code to deal with HyperSPARCs hasn't changed between 2.4 and 2.6.
There are definitely lurking bugs in the HyperSPARC implementation
(anaconda triggers a hard lock in Aurora). The kernel will boot, but its
probably not overly stable.

I honestly don't think that 2.2 (or older) has these problems resolved,
but rather that they're not as easily exposed.

Peter Jones will undoubtedly correct me if I said anything wrong here,
as he knows more about this than me.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

