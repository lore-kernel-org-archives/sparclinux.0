From: David Miller <davem@davemloft.net>
Date: Wed, 10 Dec 2008 08:54:21 +0000
Subject: Re: Why need to load %%l0 register during switch_to macro
Message-Id: <20081210.005421.120975422.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <COL115-W7714A68DEBC5468C2E0AF59FFB0@phx.gbl>
In-Reply-To: <COL115-W7714A68DEBC5468C2E0AF59FFB0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob <bo-liu@hotmail.com>
Date: Wed, 10 Dec 2008 16:00:03 +0800

> I have read it , but aslo couldn't understand. 
>  
> I didn't found where the trap return path use the l0/l1 register, in which file?
>  
> I am just a newbie. SOrry for troubling you!

That would be arch/sparc/kernel/entry.S:ret_from_fork

Actually, it seems that depenency applies to the way
this code was along time ago and the reliance on %l0
and %l1 no longer exists.
