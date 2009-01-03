From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 05:32:08 +0000
Subject: Re: [PATCH 2/4] sparc: fix warnings in userspace header byteorder.h
Message-Id: <20090102.213208.223714841.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1230849630-22482-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1230849630-22482-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu,  1 Jan 2009 23:40:28 +0100

> Fix following warnings in byteorder.h:
> 
> byteorder.h:4: include of <linux/types.h> is preferred over <asm/types.h>
> byteorder.h:9: leaks CONFIG_SPARC32 to userspace where it is not valid
> byteorder.h:13: leaks CONFIG_SPARC64 to userspace where it is not valid
> byteorder.h:14: found __[us]{8,16,32,64} type without #include <linux/types.h>
> byteorder.h:47: leaks CONFIG_SPARC64 to userspace where it is not valid
> 
> - changed to use include <linux/types.h> as suggested
> - use preprocessor defined symbols to distingush between 32 and 64 bit
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
