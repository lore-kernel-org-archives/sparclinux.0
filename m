From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 17 Aug 2005 21:26:09 +0000
Subject: Re: [PATCH 1/2] Enable magic SysRq key on SunZilog serial console
Message-Id: <20050817.142609.51436194.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050817205345.GA9337@palantir8>
In-Reply-To: <20050817205345.GA9337@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 17 Aug 2005 21:53:45 +0100

> This patch against 2.6.10 enables the Magic SysRq commands on a SunZilog
> serial console.
> SysRq is activated by sending a BREAK. Send a command within 5 seconds.

This patch had a problem.

> -		if (uart_handle_sysrq_char(&up->port, ch, regs))
> +		if (ch && uart_handle_sysrq_char(&up->port, ch, regs))

uart_handle_sysrq_char() does the "if (ch)" check, you don't
need to add it here, that's superfluous.
