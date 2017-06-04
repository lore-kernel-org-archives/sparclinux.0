From: David Miller <davem@davemloft.net>
Date: Sun, 04 Jun 2017 20:30:42 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170604.163042.2037487368752934309.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
        <20170604.162150.706660537991026056.davem@davemloft.net>
        <d58c5980-c973-a74f-292c-f246680ec246@physik.fu-berlin.de>
In-Reply-To: <d58c5980-c973-a74f-292c-f246680ec246@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: glaubitz@physik.fu-berlin.de
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 4 Jun 2017 22:26:50 +0200

> You're the person who is most knowledgeable with the code and
> the bug seems pretty darn serious. Hence I was reporting it.

Ok, please report this again with a simple reproducable test case
and I will try to reproduce it and work on it here.

All of my testing is being done with gcc-6.3 vanilla and current
kernels, and in fact I'm doing parallel "make -j128" gcc and glibc
testsuite runs and not hitting any problems at all.

So something is definitely different from your environment and mine.
