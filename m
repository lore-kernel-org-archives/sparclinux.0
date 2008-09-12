From: Robert Reif <reif@earthlink.net>
Date: Fri, 12 Sep 2008 00:37:13 +0000
Subject: Re: [PATCH 0/3]: sun4m timer rework, try 2
Message-Id: <48C9B9B9.8000306@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080910.235547.243605729.davem@davemloft.net>
In-Reply-To: <20080910.235547.243605729.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> Ok, let's try this again.
>
> The first two patches work to let us use the OF device driver
> layer facilities much earlier in the boot process.
>
> And then the third is the sun4m timers patch, with no changes
> from last time.
>
> Robert, let me know how it works out.
>
> Thanks!
>
>   
With all 3 and with just the first 2, I get an OBP Watchdog Reset.
