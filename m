From: David Miller <davem@davemloft.net>
Date: Tue, 01 Aug 2006 05:42:35 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <20060731.224235.19784785.davem@davemloft.net>
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
> FAULT: write(1) old_entry[e00001ffe1970f8a]
> FAULT: After, entry[e00001ffe1970f8a]
> 
> The last two lines then repeat semi-infinitely, and they
> were generated at an extremely high rate.

It looks like the TSB is never updated.

Do you have CONFIG_HUGETLB_PAGE disabled by chance?
I bet that's part of what helps trigger this bug.

Meanwhile I think I know what's wrong, I'll let you
know when I have a fix to test out.

Thanks a lot.
