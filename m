From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 03 Feb 2005 06:27:41 +0000
Subject: Re: [PATCH] A BTFIXUP'd fix for pte_read()
Message-Id: <20050202222741.5284085f.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050202200409.GA30839@artsapartment.org>
In-Reply-To: <20050202200409.GA30839@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 02 Feb 2005 22:22:24 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> On Wed, 2005-02-02 at 15:32 -0800, David S. Miller wrote:
> 
> > I disagree with Tom's patch in that it puts this huge switch()
> > statement inline.  The whole point of BTFIXUP_HIGH() is that it
> > resolves the call to a single instruction which can be easily
> > patched at runtime.
> > 
> > If it's going to expand to multiple BTFIXUP_HIGH() calls and a
> > switch statement, just make it a normal BTFIXUP() to a function
> > and place the implementation in sun4c.c and sun4m.c
> 
> How about this instead?

Perfect Tom.
