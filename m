From: David Miller <davem@davemloft.net>
Date: Sat, 26 Feb 2011 07:02:19 +0000
Subject: Re: [PATCH 4/5] sparc32,sun4m: percpu and global register
Message-Id: <20110225.230219.104055054.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1298234400-22378-4-git-send-email-sam@ravnborg.org>
In-Reply-To: <1298234400-22378-4-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Feb 2011 21:39:59 +0100

> entry.S access percpu + global data defined in
> sun4m_irq.c - so move the types to irq.h.
> This makes sparse happy and allow us to utilize
> asm-offsets later.
> 
> Also updated a few comments in the sun4m_irq.c file.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
