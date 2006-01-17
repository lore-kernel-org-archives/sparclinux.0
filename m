From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 17 Jan 2006 23:19:10 +0000
Subject: Re: [SPARC64]: Eliminate race condition reading Hummingbird STICK
Message-Id: <20060117.151910.98654666.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1137452706.9208.109.camel@duncow>
In-Reply-To: <1137452706.9208.109.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 16 Jan 2006 23:05:06 +0000

> [SPARC64]: Eliminate race condition reading Hummingbird STICK register
> 
> Ensure a consistent value is read from the STICK register by ensuring
> that both high and low are read without high changing due to a roll
> over of the low register.
> 
> Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>

It's so sad that I spent such an enormous amount time specifically
trying to get this sequence right and yet still messed it up!

Nice job Richard, I'll apply your patch and submit it to -stable
as well.

Thanks a lot.
