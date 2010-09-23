From: David Miller <davem@davemloft.net>
Date: Thu, 23 Sep 2010 19:09:35 +0000
Subject: Re: [2.6.36-rc regression] occasional complete system hangs on
Message-Id: <20100923.120935.173861259.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <19611.34846.813757.309183@pilspetsen.it.uu.se>
In-Reply-To: <19611.34846.813757.309183@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 23 Sep 2010 19:02:22 +0200

> The 2.6.36-rc kernels do appear to be solid on a UP Ultra5, but that
> one no longer does any gcc builds or tests, only kernel builds.
> 
> Any ideas, or do I have to try to bisect this?

I've seen this too, it's some kind of deadlock obviously.

Unfortunately I haven't gotten any further than you have in the
analysis.
