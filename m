From: David Miller <davem@davemloft.net>
Date: Sun, 28 Dec 2008 04:25:52 +0000
Subject: Re: [PATCH] sparc64: use unsigned long long for u64
Message-Id: <20081227.202552.27482357.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081227092404.GA10375@uranus.ravnborg.org>
	<20081227.013712.63335017.davem@davemloft.net>
	<20081227094955.GA1355@uranus.ravnborg.org>
In-Reply-To: <20081227094955.GA1355@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, mingo@elte.hu, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, kenchen@google.com, paulus@samba.org, tglx@linutronix.de, hpa@zytor.com, linux-next@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 27 Dec 2008 10:49:55 +0100

> I have ordered a used Sun Blade 100(*) that should show up
> before new eve.
> So when I have it and it is up and running I will redo this
> patch set. That will likely take a few weeks though.

Another option, of course, is to use 64-bit cross tools
on an x86_64 system if you have access to one of those.

> (*) Any distribution recommendations? I will only use it for
>     sparc kernel development so nothing fancy...

Debian testing works fine, and that's what I'm typing this
on.
