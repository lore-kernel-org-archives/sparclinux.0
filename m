From: David Miller <davem@davemloft.net>
Date: Tue, 17 Jun 2008 21:58:52 +0000
Subject: Re: unify sparc and sparc64 headers
Message-Id: <20080617.145852.182915499.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080613195449.GA9141@uranus.ravnborg.org>
In-Reply-To: <20080613195449.GA9141@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 17 Jun 2008 20:22:39 +0200

> If this is feasible for small packages like SILO is another matter. IMHO
> SILO and alikes should use the exported headers like gcc/glibc does
> it. But I think I share this opinion with the other kernel folks
> but I have never asked direct.

SILO has some special cases.  For example it wants to use the UFS
filesystem headers, but just to get the on-disk datastructures it
require requires way too many inappropriate dependant other kernel
headers.

So we couldn't get anyone to add the ufs*.h bits to the exported
header list.  Which was fair enough, and we therefore added an
appropriate copy to the SILO sources.
