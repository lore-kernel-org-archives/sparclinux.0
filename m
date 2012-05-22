From: David Miller <davem@davemloft.net>
Date: Tue, 22 May 2012 15:20:42 +0000
Subject: Re: Linux on sparc v7
Message-Id: <20120522.112042.1924772806883698561.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4FBA4DBC.9070609@gaisler.com>
In-Reply-To: <4FBA4DBC.9070609@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 22 May 2012 08:28:24 +0200

> On 05/21/2012 06:16 PM, Sam Ravnborg wrote:
>> On Mon, May 21, 2012 at 04:14:20PM +0200, Daniel Hellstrom wrote:
>>> Hello Dave,
>>>
>>> I am trying to catch up on what has been happening lately with the
>>> sparc
>>> port. Have the latest patches removed support for SPARC V7 CPUs?
>> Yes. The sun4c were the only users of v7 so today we tell gcc to
>> generate v8
>> code. This imply support for muldiv&  friends.
>>
>> > From the sparc Makefile:
>>
>>      KBUILD_CFLAGS  += -mcpu=v8
> 
> Does this mean that if we change it to mcpu=v7 or mcpu=cypress (or
> removing mcpu=v8) the kernel can still be run on a V7 CPU? Or have
> software routines for making V8 mul/div operations on a V7 CPU been
> removed so that V7 CPUs can't run Linux regardless of compiler option?

The kernel will never run on a v7 cpu ever again, as we've removed
support for the sun4c architecture completely.
