From: David Miller <davem@davemloft.net>
Date: Fri, 28 Jul 2006 11:13:59 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <20060728.041359.68038076.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607281035.k6SAZOJ3015670@harpo.it.uu.se>
In-Reply-To: <200607281035.k6SAZOJ3015670@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Fri, 28 Jul 2006 12:35:24 +0200 (MEST)

> FAULT: write(1) old_entry[e00001ffe1970f8a]
> FAULT: After, entry[e00001ffe1970f8a]
> 
> The last two lines then repeat semi-infinitely, and they
> were generated at an extremely high rate.

Thanks, this should help me find the bug.
