From: David Miller <davem@davemloft.net>
Date: Sun, 14 Mar 2010 22:06:38 +0000
Subject: Re: klibc sparc sockets foo
Message-Id: <20100314.150638.125553888.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100314161159.GA23007@stro.at>
In-Reply-To: <20100314161159.GA23007@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Well, on sparc32 we implement sys_socketcall() and on sparc64 we don't
and instead provide the direct system calls for things like that.

What's the trouble?
