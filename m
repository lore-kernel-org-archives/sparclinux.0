From: David Miller <davem@davemloft.net>
Date: Tue, 29 May 2012 20:16:26 +0000
Subject: Re: sparc32: some more testing
Message-Id: <20120529.161626.1447672938121607760.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 29 May 2012 20:39:39 +0200

> I gues I have some challenging debugging hours waiting - but that
> will wait a little...

When diagnosing these kinds of problems, the first thing you can try
to do is make all of the TLB operations flush the entire TLB and
failing that also making all the cache operations flush the entire
cache.
