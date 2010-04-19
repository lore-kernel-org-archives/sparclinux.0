From: David Miller <davem@davemloft.net>
Date: Mon, 19 Apr 2010 04:15:49 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <20100418.211549.189711537.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 16 Apr 2010 08:36:42 -0400

> On Thu, 2010-04-15 at 15:25 -0700, David Miller wrote:
>> From: Stephen Smalley <sds@tycho.nsa.gov>
>> Date: Thu, 15 Apr 2010 08:43:05 -0400
>> 
>> > Your eu-readelf output showed why SELinux is checking execmem - the data
>> > segment has flags RWE and thus a private file mapping is being created
>> > with PROT_WRITE and PROT_EXEC.  That's a problem with the compiler
>> > toolchain - report it to them please.  This was a problem with ppc32
>> > binaries before secure-plt was introduced.
>> 
>> I don't really intend to implement secure-plt any time soon on sparc
>> because there simply is no way to do it efficiently.
>> 
>> And when you talk about "toolchain issues" that all goes my way
>> anyways, so just direct such queries to me directly since I handle
>> both the kernel and toolchain bits entirely myself these days.
>> 
>> So you'll always have to deal with the PLT section on sparc having
>> write and execute permission.
> 
> Ok.  Can someone with sparc hardware try the patch I posted to see if it
> suffices?

Tom, please give Stephen's patch a test.  Thanks!
