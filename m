From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 06 Nov 2008 10:18:52 +0000
Subject: Re: tty warning
Message-Id: <20081106101852.429f4a6c@lxorguk.ukuu.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20081106152421.a9cf964f.sfr@canb.auug.org.au>
In-Reply-To: <20081106152421.a9cf964f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, "William L. Irwin" <wli@holomorphy.com>, sparclinux@vger.kernel.org

On Thu, 6 Nov 2008 15:24:21 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Alan,
> 
> A sparc allmodconfig build gives these warnings:

Blame Dave, although its a bit unfair as the Sparc32 does some weirdness
that the compiler didn't use to be smart enough to complain about and is
actually valid for sparc32 at least.

Alan
