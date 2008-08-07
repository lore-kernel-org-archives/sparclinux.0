From: David Miller <davem@davemloft.net>
Date: Thu, 07 Aug 2008 05:53:37 +0000
Subject: Re: sparc64: build failure at sys_sparc32.c
Message-Id: <20080806.225337.73678483.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670807290138p4a666337id74fe1fa637932e4@mail.gmail.com>
	<20080803.181934.262275514.davem@davemloft.net>
	<20080804140532.GI6088@cs181140183.pp.htv.fi>
In-Reply-To: <20080804140532.GI6088@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@kernel.org
Cc: a.beregalov@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 4 Aug 2008 17:05:32 +0300

> The only platforms that do their own stuff instead of using the 
> functions from kernel/uid16.c are sparc64 and s390.
> 
> Is there any reason why sparc64 has it's own functions?

Thanks for pointing it out, I'll take advantage of those helper
routines.
