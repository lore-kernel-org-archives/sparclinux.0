From: David Miller <davem@davemloft.net>
Date: Wed, 24 Aug 2011 19:53:42 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110824.125342.2297190793716816872.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Wed, 24 Aug 2011 15:50:53 -0400

> On Mon, Aug 22, 2011 at 05:36:02PM -0700, David Miller wrote:
> 
>> Unfortunately we need the very first crash message that happens, but
>> even your first snapshot is after other crashes have occurred.
>> 
>> You'll need to build a kernel with CONFIG_BOOT_PRINTK_DELAYED enabled
>> and then you can boot with boot_delay=xxx (where "xxx" is something
>> like 100, it's in milliseconds) to slow down the message printing so
>> that you can capture the first message cleanly.
> 
> OK, I've attached several images of the kernel panic w/ boot_delay to
> the bug:
> 
> https://bugzilla.kernel.org/show_bug.cgi?idA522

Thanks I'll take a look at this soon.
