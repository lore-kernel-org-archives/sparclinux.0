From: David Miller <davem@davemloft.net>
Date: Sat, 12 Jan 2013 23:28:54 +0000
Subject: Re: [PATCH] sparc: remove __devinit, __devexit annotations
Message-Id: <20130112.152854.1540849291376424424.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130101150233.GA16318@merkur.ravnborg.org>
In-Reply-To: <20130101150233.GA16318@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 1 Jan 2013 16:02:33 +0100

> __devinit, __devexit annotations are nops - so drop them.
> Likewise for __devexit_p.
> 
> Adjusted alignment of arguments when needed.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.
