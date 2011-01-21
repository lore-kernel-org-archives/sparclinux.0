From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 21 Jan 2011 23:03:11 +0000
Subject: Re: [RFC PATCH 0/5] sparc64: drop deprecated irq features
Message-Id: <20110121230311.GA29639@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110121222451.GA29468@merkur.ravnborg.org> <20110121.145527.219749753.davem@davemloft.net>
In-Reply-To: <20110121.145527.219749753.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org

On Fri, Jan 21, 2011 at 02:55:27PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 21 Jan 2011 23:24:51 +0100
> 
> > Sam Ravnborg (5):
> >       sparc64: fix direct access to irq_desc
> >       sparc: in handler_irq() rename irq parameter to pil
> >       sparc64: all pointers to irq_handler_data renamed to handler_data
> >       sparc64: use {get,set}_irq_data for handler_data
> >       sparc64: use up-to-data genirq functions
> 
> I did a sanity build and boot of these changes against Linus current
> tree and it seems to work fine on my Niagara-2+ machine.

Thanks!
I will repost an updated serie when I have tested it locally too.

	Sam
