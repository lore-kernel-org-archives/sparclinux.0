From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 05 Dec 2015 09:59:56 +0000
Subject: Re: [V2 PATCH] sparc64/gup: check address scope legitimacy
Message-Id: <20151205095956.GA21826@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1448490684-17171-1-git-send-email-yang.shi@linaro.org>
 <1448491543-17946-1-git-send-email-yang.shi@linaro.org>
 <20151203203809.GA15235@ravnborg.org>
 <5660C0D4.8050800@linaro.org>
In-Reply-To: <5660C0D4.8050800@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shi, Yang" <yang.shi@linaro.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linaro-kernel@lists.linaro.org

> >access_ok() always returns 1.
> 
> Thanks for pointing it out. And, I didn't notice that gup is just built for
> SPARC64. I though it is built by both 64 bit and 32 bit.
> 
> A follow-up question, is there any reason to just have sparc specific fast
> gup for 64 bit not for 32 bit?
I do not know - sorry.

> >>@@ -203,6 +206,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
> >>  	addr = start;
> >>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
> >>  	end = start + len;
> >>+	if (end < start)
> >>+		goto slow_irqon;
> >
> >end can only be smaller than start if there is some overflow.
> >See how end is calculated just the line above.
> >
> >This looks like a highly suspicious change.
> 
> I'm supposed this is used to protect the overflow. I copied the code from
> other arch. Actually, every arch has this except sparc.
The the other archs are likely confused as well - there is most
likely some history behind that can be found if digging a little.

The code is not present in the generic version.

	Sam
