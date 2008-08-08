From: David Miller <davem@davemloft.net>
Date: Fri, 08 Aug 2008 09:40:24 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <20080808.024024.205614839.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670807070859y74f529b5i60f04e0a37a01cd3@mail.gmail.com>
	<20080807.230139.220174417.davem@davemloft.net>
	<a4423d670808080231nc4d5e25q6636fe8ff090b84@mail.gmail.com>
In-Reply-To: <a4423d670808080231nc4d5e25q6636fe8ff090b84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: mikpe@it.uu.se, kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Fri, 8 Aug 2008 13:31:40 +0400

> 2008/8/8 David Miller <davem@davemloft.net>:
> > From: "Alexander Beregalov" <a.beregalov@gmail.com>
> > Date: Mon, 7 Jul 2008 19:59:04 +0400
> >
> >> I have turned off LOCKDEP and it boots properly.
> >> 2.6.26-rc9-00005-g1b40a89
> >>
> >> Mikael's config also does not contain LOCKDEP.
> >
> > I have finally reproduced the problem locally and figured out the
> > bug.
> >
> > Please try this patch:
> >
> Thanks David,  but 2.6.27-rc2-00166-gaeee90d hangs in the same way.

That patch was for you to add on top of whatever tree you
have handy.  Did you apply the patch?

That patch will fix all trees.
