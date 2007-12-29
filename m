From: David Miller <davem@davemloft.net>
Date: Sat, 29 Dec 2007 08:27:08 +0000
Subject: Re: 2.6.24-rc6-mm1: some section mismatches on sparc64
Message-Id: <20071229.002708.30708773.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071226.190504.20990618.davem@davemloft.net>
	<20071228232255.GB9105@does.not.exist>
	<20071229.001411.210630819.davem@davemloft.net>
In-Reply-To: <20071229.001411.210630819.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@kernel.org
Cc: errandir_news@mph.eclipse.co.uk, m.kozlowski@tuxland.pl, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 29 Dec 2007 00:14:11 -0800 (PST)

> You can't do that, the FOO_CONSOLE config options depend upon
> FOO=y.
> 
> That's why I'm not worried about this issue and it's not critical at
> all.

Adrian, if you're interested in tackling this "fun" problem,
have a look at add_preferred_console() and find a way to make
that not marked __init. (it's called by sunserial_console_match)

That's what causes this dependency chain of __init problems for the
Sun serial console drivers.

It's problematic, furthermore, because even if one could call
add_preferred_console() from a module properly, it doesn't have the
desired effect of changing init's stdin/stdout/stderr
