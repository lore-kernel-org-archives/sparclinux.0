From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 31 Jan 2005 02:27:22 +0000
Subject: Re: PCH problems on sparc-linux
Message-Id: <20050130182722.5a14e154.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5460e33305012910053fd6f3ea@mail.gmail.com>
In-Reply-To: <5460e33305012910053fd6f3ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 29 Jan 2005 19:05:16 +0100
Christian Joensson <christian.joensson@gmail.com> wrote:

> As I have understood, there is perhaps a problem with the sparc linux
> kernel related to problems with PCH in current gcc cvs trunk (since
> april 2004 it seems...)
> 
> The thread at http://gcc.gnu.org/ml/gcc/2004-11/msg00225.html suggests
> a "simple" fix... Daniel's
> http://gcc.gnu.org/ml/gcc/2004-11/msg00241.html. Did that ever get
> applied?

I've never tested it out, I lack time for any gcc development these
days.  It is the simplest candidate I've seen for a fix for this
problem.  Someone should give it a try.

