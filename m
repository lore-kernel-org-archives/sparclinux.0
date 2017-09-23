From: David Miller <davem@davemloft.net>
Date: Sat, 23 Sep 2017 16:53:28 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170923.095328.1477618247086498374.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sat, 23 Sep 2017 08:14:41 +0200

> On 09/23/2017 03:35 AM, David Miller wrote:
>> It was part of the opensolaris sources, I ported it locally myself
>> so that it would build and work on Linux.
>> 
>> I do not know where you can download it, and I'm probably not allowed
>> to redistribute my modified version of the sources.
> 
> So, you are eagerly defending the use of /dev/mdesc and claim there is
> no need for anyone to have a sysfs interface because people can use tools
> like mdlint only to disclose later that mdlint not available anywhere
> because it is effectively proprietary.
> 
> OK.

The tool is quite easy to write.  Would you like me to write such a
tool in a day or two?  It would look very similar to what the mdesc
sysfs kernel patch looked like, in fact much of the code would look
identical.

The problem with the Linux/sparc port is resources, I'm the only
maintainer and I devote all of the spare time I have for kernel patch
review.

I know you really want to prove me wrong, and that this is very
important to you for some reason.
