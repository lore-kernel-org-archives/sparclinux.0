From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 03 Feb 2005 00:52:46 +0000
Subject: Re: [PATCH] A BTFIXUP'd fix for pte_read()
Message-Id: <20050202165246.1a3c87b9.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050202200409.GA30839@artsapartment.org>
In-Reply-To: <20050202200409.GA30839@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2 Feb 2005 16:55:41 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Wed, 2 Feb 2005 14:40:19 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Wed, Feb 02, 2005 at 03:32:21PM -0800, David S. Miller wrote:
> > I disagree with Tom's patch in that it puts this huge switch()
> > statement inline.  The whole point of BTFIXUP_HIGH() is that it
> > resolves the call to a single instruction which can be easily
> > patched at runtime.
> > If it's going to expand to multiple BTFIXUP_HIGH() calls and a
> > switch statement, just make it a normal BTFIXUP() to a function
> > and place the implementation in sun4c.c and sun4m.c
> 
> I'm on the road and people are antsy for something that builds, so
> I'm rather tempted to take it for expedience and properly BTFIXUP-ize
> it after 2.6.11, which appears rather imminent, since I basically
> won't push anything I've written myself but not tested.

No objection to using it as a short-term fix.
