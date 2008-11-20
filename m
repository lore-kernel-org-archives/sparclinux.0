From: David Miller <davem@davemloft.net>
Date: Thu, 20 Nov 2008 13:00:35 +0000
Subject: Re: [PATCH] sparc: combine unistd_{32,64}.h
Message-Id: <20081120.050035.62012296.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081114141050.3c2f5828.sfr@canb.auug.org.au>
In-Reply-To: <20081114141050.3c2f5828.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 14 Nov 2008 15:15:35 +1100

> On Thu, 13 Nov 2008 19:20:12 -0800 (PST) David Miller <davem@davemloft.net> wrote:
> >
> > This is going to conflict with the accept4 patch
> > Andrew is going to push tomorrow.
> > 
> > So it's a better idea to do this after Linus sucks
> > that in.
> 
> Whenever you like, just thought you might have a use for it. (and I had a
> bored moment in the linux-next build today :-))

Linus took the accept4 bits, so if you want to respin this that
would be great.
