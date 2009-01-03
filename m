From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 05:31:24 +0000
Subject: Re: [PATCH 1/4] sparc: fix warning in userspace header jsflash.h
Message-Id: <20090102.213124.227457512.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1230849630-22482-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1230849630-22482-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu,  1 Jan 2009 23:40:27 +0100

> Fix following warnings in jsflash.h:
> 
> jsflash.h:11: include of <linux/types.h> is preferred over <asm/types.h>
> jsflash.h:24: found __[us]{8,16,32,64} type without #include <linux/types.h>
> 
> Fixed by changing the include to <linux/types.h>
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
