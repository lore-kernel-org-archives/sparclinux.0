From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 06 Nov 2005 20:56:45 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <20051106.125645.09897025.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 05 Nov 2005 22:13:39 -0600

> On Sat, 2005-11-05 at 16:40 -0800, David S. Miller wrote:
> 
> > I think I missed the idea whilst trying to implement
> > your suggestion, as below, but it will not compile:
> 
> Whoever "fixes" this issue, please test with module-init-tools as part
> of the confirmation process. It's never fun to discover that kernel
> modules just don't work.

If I do the work I'll send you a patch to test since I lack
any 32-bit sparc system on which to test this.
