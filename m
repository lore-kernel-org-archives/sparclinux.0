From: David Miller <davem@davemloft.net>
Date: Mon, 08 Dec 2008 09:09:18 +0000
Subject: Re: [PATCH 5/5] sparc: fix sparse warnings in irq_32.c
Message-Id: <20081208.010918.17000778.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1228682256-27812-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1228682256-27812-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun,  7 Dec 2008 21:37:36 +0100

> Fix following sparse warnings:
> symbol 'static_irqaction' was not declared. Should it be static?
> symbol 'static_irq_count' was not declared. Should it be static?
> symbol 'irq_action_lock' was not declared. Should it be static?
> symbol 'unexpected_irq' was not declared. Should it be static?
> symbol 'handler_irq' was not declared. Should it be static?
> returning void-valued expression
> returning void-valued expression
> returning void-valued expression
> symbol 'init_IRQ' was not declared. Should it be static?
> 
> Warnings were fixed by addding proper declarations
> and fixing return path of a few functions.
> 
> There remains several warnings all related to the floppy driver.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.

Although the returning void-valued thing is easily my least
favorite sparse warning.  And even Linus seems to agree with
me, but nobody has done anything about it obviously :)
