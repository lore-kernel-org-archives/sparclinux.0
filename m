From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 18 Aug 2005 09:29:59 +0000
Subject: Re: [PATCH 1/2] Enable magic SysRq key on SunZilog serial console
Message-Id: <20050818092959.GA10886@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20050817205345.GA9337@palantir8>
In-Reply-To: <20050817205345.GA9337@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 17, 2005 at 02:26:09PM -0700, David S. Miller wrote:
> > -		if (uart_handle_sysrq_char(&up->port, ch, regs))
> > +		if (ch && uart_handle_sysrq_char(&up->port, ch, regs))
> 
> uart_handle_sysrq_char() does the "if (ch)" check, you don't
> need to add it here, that's superfluous.

Problem is, uart_handle_sysrq_char() still resets port->sysrq when called
with a 0 character.
During my testing it always first got called with a 0 character value
after I send a break. The actual command key I pressed always got ignored
as a result (and just got displayed to the screen).

Could this be a bug in uart_handle_sysrq_char()? The impact of a fix there
would be much wider and thus scares me. I do not know why I always see at
least one 0 character after sending a break. Could be a sunzilog thing,
could be a sparc thing, could be happening with all uart chips. I just don't
know how widespread this behaviour is.

Thanks for the feedback,
-- 
Martin
