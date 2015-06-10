From: David Miller <davem@davemloft.net>
Date: Wed, 10 Jun 2015 18:02:50 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150610.110250.1634796446687407507.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 10 Jun 2015 11:33:14 +0200

> On 2015-06-10 02:18, David Miller wrote:
>> > Disabling multiarch support improves a lot the stability on these
>> > machines.
>> 
>> By disabling it you are creating an even worse situation, for the
>> reasons I've discussed already, plus guess what I test when I'm
>> doing development?
> 
> How could it be worse? With the Niagara T1 memcpy routines, the machine
> is not usable, as the processes crashes regularly with a segmentation
> fault. With the default sparc v9 memcpy routines, the machine becomes
> usable.

I do not think this will happen with current kernel and glibc and
all the bug fixes I've been doing over the past few years.
