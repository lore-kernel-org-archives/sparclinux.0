From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 31 Jul 2015 09:20:04 +0000
Subject: Re: Debian drops support for sparc
Message-Id: <20150731092004.GB23378@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150730140453.GA25014@ravnborg.org>
In-Reply-To: <20150730140453.GA25014@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jul 31, 2015 at 08:20:41AM +0200, Kjetil Oftedal wrote:
> So I guess what is being dropped this time around is the official support for
> 64-bit kernel + 32-bit/v8plus userland.
> 
> Then only the unofficial port of 64-bit kernel + 64-bit userland remains.

That seems a bit misleading, because I don't see what would be preventing
sparc from ultimately reappearing together with sparc64 on debian-ports.org.

Given that it already has a bunch of buildds and still has a better archive
coverage (the percentage of total packages build on sparc compared to
total), that's a fairly solid foundation.

-- 
     2. That which causes joy or happiness.
