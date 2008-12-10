From: David Miller <davem@davemloft.net>
Date: Wed, 10 Dec 2008 03:06:22 +0000
Subject: Re: Why need to load %%l0 register during switch_to macro
Message-Id: <20081209.190622.193725776.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <COL115-W7714A68DEBC5468C2E0AF59FFB0@phx.gbl>
In-Reply-To: <COL115-W7714A68DEBC5468C2E0AF59FFB0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob <bo-liu@hotmail.com>
Date: Wed, 10 Dec 2008 10:37:36 +0800

> I have another question about switch_to macro.
>  
> Why need to load %%l0 register during switch_to macro?
>  
> "ldd [%%sp+0x00], %%l0" 
>  
> I think load %%i6 is enough.

Read the comment about the switch_to() macro, it explains
this.  I don't see how you could miss it.

The trap return path for newly forked child tasks depend upon these
specific registers being setup a certain way.
