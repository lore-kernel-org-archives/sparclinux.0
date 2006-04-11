From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 11 Apr 2006 21:39:46 +0000
Subject: Re: Issues with SILO 1.4.11
Message-Id: <20060411.143946.42414236.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0604101839350.3168@bobcat>
In-Reply-To: <Pine.LNX.4.63.0604101839350.3168@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <aragorn@tiscali.nl>
Date: Tue, 11 Apr 2006 23:37:43 +0200

> On Tuesday 11 April 2006 23:21, David S. Miller wrote:
> > > What are the reasons the code in second/timer.c was changed?
> > >
> > > That the sun4u_notimer support is still needed for a large class of
> > > hardware out there has been demonstrated by my tests.
> >
> > You cannot write to the %tick register on some cpu variants,
> > it can only be written by the hypervisor.
> 
> Is it possible to test for that capability being present?

Not easily but yes, but the old code was buggy in other regards as
well.  It would need to be rewritten.
