From: David Miller <davem@redhat.com>
Date: Fri, 21 Oct 2011 06:56:29 +0000
Subject: Re: [PATCH 1/3] sparc32: Remove non-kernel code from memcpy
Message-Id: <20111021.025629.573905529116587577.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20111019.184415.1875111683071341626.davem@davemloft.net>
In-Reply-To: <20111019.184415.1875111683071341626.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 20 Oct 2011 17:39:48 +0200

> The kernel way is to use:
> 
> #include <linux/linkage.h>
> 
> ...
> 
> ENTRY(memcpy)
> 
> I do not see this widely used in sparc32 code - added to my todo list.

Great, thanks Sam.
