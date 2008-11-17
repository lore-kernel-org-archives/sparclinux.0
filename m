From: David Miller <davem@davemloft.net>
Date: Mon, 17 Nov 2008 04:09:03 +0000
Subject: Re: [PATCH 8/8] sparc,sparc64: unify mm/
Message-Id: <20081116.200903.205964056.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1226866704-6485-8-git-send-email-sam@ravnborg.org>
In-Reply-To: <1226866704-6485-8-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 21:18:24 +0100

> - move all sparc64/mm/ files to arch/sparc/mm/
> - commonly named files are named _64.c
> - add files to sparc/mm/Makefile preserving link order
> - delete now unused sparc64/mm/Makefile
> - sparc64 now finds mm/ in sparc
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Also applied, thanks a lot Sam.
