From: David Miller <davem@davemloft.net>
Date: Wed, 05 Jan 2011 02:49:07 +0000
Subject: Re: [PATCH v3 00/10] sparc: unify piggyback - and fix tftpboot.img
Message-Id: <20110104.184907.193697203.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110104213800.GA14732@merkur.ravnborg.org>
In-Reply-To: <20110104213800.GA14732@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Tue, 04 Jan 2011 22:16:56 +0000

> On Tue, 2011-01-04 at 22:38 +0100, Sam Ravnborg wrote:
>>         "console [tty0] enabled, bootconsole disabled"
>> 
>> So I did not reach the point where it try to mount 
>> the appended image.
>> Any hints what is wrong is appreciated!
>> [I guess I have the wrong framebuffer driver - but I do not know which
>> is the right one] 
> 
> You might need the PGX64 framebuffer driver for the 'Blade 100.

The onboard graphics chip is ATI mach64, not PGX64.
