From: David Miller <davem@davemloft.net>
Date: Mon, 08 Dec 2008 09:07:27 +0000
Subject: Re: [PATCH 3/5] sparc: fix sparse warnings in traps_32.c
Message-Id: <20081208.010727.254730208.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1228682256-27812-3-git-send-email-sam@ravnborg.org>
In-Reply-To: <1228682256-27812-3-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun,  7 Dec 2008 21:37:34 +0100

> o add decalrations to entry.h for functions only used from assembler
> o add declaratiosn to kernel.h for functions only used from .c
> o removed unused functions/extern declarations
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks.
