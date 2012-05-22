From: David Miller <davem@davemloft.net>
Date: Tue, 22 May 2012 19:07:24 +0000
Subject: Re: [PATCH] sparc32: use the common implementation of alloc_thread_info_node()
Message-Id: <20120522.150724.1070224867657733210.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120522151123.GA10058@merkur.ravnborg.org>
	<alpine.LFD.2.02.1205221909540.3231@ionos>
In-Reply-To: <alpine.LFD.2.02.1205221909540.3231@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 22 May 2012 19:10:51 +0200 (CEST)

> On Tue, 22 May 2012, Sam Ravnborg wrote:
> 
>> >From 52d8a6d1b81a19e693a09df90275600f44293f43 Mon Sep 17 00:00:00 2001
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Tue, 22 May 2012 16:39:00 +0200
>> Subject: [PATCH] sparc32: use the common implementation of alloc_thread_info_node()
>> 
>> With sun4c removed we can fall-back to the common implementation.
>> 
>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Applied, thanks everyone.
