From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 18:12:16 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.111216.1484064271734965147.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 19:42:25 +0200

> On 09/19/2017 07:33 PM, David Miller wrote:
>> The kernel has no business having all of the details of how to
>> interpret binary property values, what they mean, what the
>> most reasonable way is to format them, etc.
> 
> So, you basically disagree with all the other subsystem maintainers?

If /dev/mdesc didn't exist, we could further delve into the details
of this situation.

But it's there, for years, and it already provides the information
that userspace needs.

>> That's userspace.
>> 
>> Sparc users already make use of special tools such as 'prtconf'
>> and 'mdlint' already exists and works just fine.
> 
> Tools that probably haven't been touched for ages. Like with SILO,
> the world has moved on to more modern tools.

Tools that work only need so many bug fixes and feature additions.

What bug in prtconf are you aware of that I haven't fixed?

What patch submitted to me for SILO or prtconf have I ignored and
not given feedback to or applied straight away?
