From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 08 Jun 2005 19:04:12 +0000
Subject: Re: ipt_recent && spamd (!?) && kernel panic
Message-Id: <20050608.120412.74744495.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87oeahuwt3.fsf@pumba.bayour.com>
In-Reply-To: <87oeahuwt3.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Turbo Fredriksson <turbo@swe.net>
Date: Wed, 08 Jun 2005 09:34:00 +0200

> I'm not exactly sure WHERE the problem is (the panic mentions
> spamd - spamassassin daemon), but I can't see what that can
> do to cause this:

The crash clearly shows that it's a bzero() call made by the
match() function in ipt_recent.c of the kernel.

What ipt_recent rules do you have loaded?
