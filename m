From: David Miller <davem@davemloft.net>
Date: Mon, 08 Dec 2008 09:02:30 +0000
Subject: Re: [PATCH 1/5] sparc: fix sparse warning in kernel/pmc.c
Message-Id: <20081208.010230.07413095.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1228682256-27812-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1228682256-27812-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun,  7 Dec 2008 21:37:32 +0100

> Fix following warning:
> arch/sparc/kernel/pmc.c:41:6: warning: symbol 'pmc_swift_idle'
> was not declared. Should it be static?
> 
> It was not used outside this file - make it static
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
