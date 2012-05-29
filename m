From: David Miller <davem@davemloft.net>
Date: Tue, 29 May 2012 23:31:32 +0000
Subject: Re: sparc32: some more testing
Message-Id: <20120529.193132.1915732195109514955.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marcel van Nies <morcles@gmail.com>
Date: Wed, 30 May 2012 01:28:31 +0200

> I could actually bisect it down to this:
> 
> commit 4d14a459857bd151ecbd14bcd37b4628da00792b
> Author: David S. Miller <davem@davemloft.net>
> Date:   Thu Dec 10 23:32:10 2009 -0800
> 
>     sparc: Stop trying to be so fancy and use __builtin_{memcpy,memset}()

I suspect the previous code was hiding cache aliasing effects and thus
cache handling bugs by using the Hypersparc optimized page copy block
op.
