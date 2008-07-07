From: David Miller <davem@davemloft.net>
Date: Mon, 07 Jul 2008 11:01:26 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <20080707.040126.178187777.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080620.162135.203810660.davem@davemloft.net>
	<a4423d670806201636n4f3d107bk290ed831eb5eefb4@mail.gmail.com>
	<a4423d670807070219s2dd43aaia29713f5076ecd0d@mail.gmail.com>
In-Reply-To: <a4423d670807070219s2dd43aaia29713f5076ecd0d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Mon, 7 Jul 2008 13:19:05 +0400

> Hi David
> 
> Is it possible to add some debug code to understand what is going on?

What do you want me to add?  The thing hangs and we have no idea
where since there are no messages on the console and the hang
happens before we have any kind of console output.

Why do you think I haven't been able to fix this yet?

Besides I'm too busy with some networking stuff to work at
all on this at the moment, so folks will just need to be
patient or do the grunt work of debugging this themselves.
