From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 03 Feb 2005 00:55:41 +0000
Subject: Re: [PATCH] A BTFIXUP'd fix for pte_read()
Message-Id: <20050203005541.GF24805@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050202200409.GA30839@artsapartment.org>
In-Reply-To: <20050202200409.GA30839@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2 Feb 2005 14:40:19 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
>> Doing a quick doublecheck to be sure this actually applies before
>> shipping upstream. Sorry about the delay, folks.

On Wed, Feb 02, 2005 at 03:32:21PM -0800, David S. Miller wrote:
> I disagree with Tom's patch in that it puts this huge switch()
> statement inline.  The whole point of BTFIXUP_HIGH() is that it
> resolves the call to a single instruction which can be easily
> patched at runtime.
> If it's going to expand to multiple BTFIXUP_HIGH() calls and a
> switch statement, just make it a normal BTFIXUP() to a function
> and place the implementation in sun4c.c and sun4m.c

I'm on the road and people are antsy for something that builds, so
I'm rather tempted to take it for expedience and properly BTFIXUP-ize
it after 2.6.11, which appears rather imminent, since I basically
won't push anything I've written myself but not tested. What I have in
terms of remote access I've lost for want of time. There's also
something of a reluctance to resynch before 2.6.11 out of disgust for
certain changes and/or the manner in which they were merged.

Maybe I can cook something better up before my return flight while at
the airport, though I'd be glad to see spot or ahaas get done before me.


-- wli
