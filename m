From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2012 23:16:44 +0000
Subject: Re: sparc sun4c support - time to drop it?
Message-Id: <20120507.191644.1406241660359700728.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120505162104.GA14563@merkur.ravnborg.org>
In-Reply-To: <20120505162104.GA14563@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 8 May 2012 09:07:34 +1000

> Would it be possible to hide sun4c away behind a kconfig variable
> that is marked as BROKEN with a entry in the feature-removal file?
> 
> Or is that just too much work for code which has been broken for a long time.

We just want to kill all of this code off, there is zero value keeping
it around at all.

It's in the revision history if you just want to look at it, and
nobody is going to make changes that try to keep it working so letting
this stuff linger has zero value.
