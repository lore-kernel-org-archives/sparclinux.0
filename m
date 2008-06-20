From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 20 Jun 2008 22:22:33 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <Pine.LNX.4.64.0806201819430.25997@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080620.142034.30884440.davem@davemloft.net>
 <Pine.LNX.4.64.0806201723120.14221@engineering.redhat.com>
 <20080620.144424.168785883.davem@davemloft.net> <20080620.144736.224107106.davem@davemloft.net>
In-Reply-To: <20080620.144736.224107106.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com

On Fri, 20 Jun 2008, David Miller wrote:

> From: David Miller <davem@davemloft.net>
> Date: Fri, 20 Jun 2008 14:44:24 -0700 (PDT)
>
>> I agree on both counts.  Although I'm curious what the average stack
>> frame sizes look like on x86_64 and i386, and also how this area
>> appears on powerpc.
>
> I also one to mention in passing that another thing we can do to
> help deep call stack sizes is to make call chains more tail-call
> friendly when possible.

... and remove -fno-optimize-sibling-calls?:

Makefile:
ifdef CONFIG_FRAME_POINTER
KBUILD_CFLAGS   += -fno-omit-frame-pointer -fno-optimize-sibling-calls
else
KBUILD_CFLAGS   += -fomit-frame-pointer
endif

--- maybe it could be better to remove it, instead of some inlining that I 
made. Or do you see a situation when for debugging purpose, user would 
want -fno-optimize-sibling-calls?

Mikulas
