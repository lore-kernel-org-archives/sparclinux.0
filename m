From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 19 Apr 2012 15:29:37 +0000
Subject: Re: [PATCH] net: filter: Just In Time compiler for sparc
Message-Id: <20120419152937.GA1120@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120416.225823.1395194623649559124.davem@davemloft.net> <20120417195716.GA26750@merkur.ravnborg.org> <20120417.164400.89608576188768018.davem@davemloft.net>
In-Reply-To: <20120417.164400.89608576188768018.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

> 
> >> +	select HAVE_BPF_JIT
> > If we sorted this block of select then the chances
> > for merge conflict would be smaller.
> > But this is not this patch to do so.
> 
> I also think we should create an arch/sparc/Kbuild for sparc
> too, just like x86 has.

I will look into both issues.
But only after the merge window to avoid conflicts.

	Sam
