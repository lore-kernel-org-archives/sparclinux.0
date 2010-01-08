From: David Miller <davem@davemloft.net>
Date: Fri, 08 Jan 2010 08:03:37 +0000
Subject: Re: [PATCH] SPARC: use helpers for rlimits
Message-Id: <20100108.000337.255400791.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1262791479-26594-1-git-send-email-jslaby@suse.cz>
	<1262791479-26594-5-git-send-email-jslaby@suse.cz>
In-Reply-To: <1262791479-26594-5-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jslaby@suse.cz
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>
Date: Wed,  6 Jan 2010 16:24:33 +0100

> Make sure compiler won't do weird things with limits. E.g. fetching
> them twice may return 2 different values after writable limits are
> implemented.
> 
> I.e. either use rlimit helpers added in
> 3e10e716abf3c71bdb5d86b8f507f9e72236c9cd
> or ACCESS_ONCE if not applicable.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Applied, thanks Jiri.
