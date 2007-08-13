From: David Miller <davem@davemloft.net>
Date: Mon, 13 Aug 2007 01:59:44 +0000
Subject: Re: Sun4c interrupt controller - Sun4d relevance
Message-Id: <20070812.185944.132927373.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46BF2A25.9090900@netunix.com>
In-Reply-To: <46BF2A25.9090900@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 12 Aug 2007 21:58:08 +0100 (BST)

> Lawers may disagree :).

It is a very serious issue.

Even if the specific bits you are examining might be "not care",
there are side effects to contamination on your part in the long
term.

Let's say, for example, that you notice that Solaris does something
clever in their VFS layer while you happen to be scanning around
the sun4c code.  Sun has patented this technique.

Next, you (several months later) add a refinement to the Linux VFS
layer that subconsciously incorporates some of these techniques.

Sun launches legal action against Linux distribution vendors because
of the tainted code.

This is a very obvious example, but much less obvious scenerio's are
possible.  Therefore the only safe course of action is "don't do it".

It is very dangerous to even read the Solaris code, in any form, in
order to prevent from becomming tainted.

The only "safe" way I am aware of to handle this issue is to do clean
room transfer of information.  Which means one person reads the
Solaris code, then writes a document explaining in detail how the chip
is programmed without copying any source code from the Solaris tree
whatsoever.

A second person, reads the document written by the first person,
and then writes the Linux changes solely based upon that document.

The first person is tainted and cannot every be the implementer of
any code on the Linux side.

Mark and others, I've very seriously concerned about this and I think
I need to take the safe course of action and not accept any further
Sparc32 low-level changes from you guys since you have publicly stated
that you've read the Solaris code and thus are tainted already.

Sorry :-(  I really had high hopes for you with the sparc32 port
Mark, but you blew it by taking this legal risk that I want the
sparc32 port to be no part of.

I've spent 10+ years carefully avoiding this thorny legal issue,
and I'm not going to toss that much work down the drain by taking
a risk in this area.

It would have been entirely sufficient to work on and fix lowlevel
bugs by experimentation and also using the BSD sparc32 ports and
drivers as a reference.
