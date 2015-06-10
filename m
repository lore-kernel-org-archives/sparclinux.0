From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 10 Jun 2015 07:50:06 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150610075006.GD10311@aurel32.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2015-06-09 12:02, David Miller wrote:
> From: James Y Knight <jyknight@google.com>
> Date: Tue, 9 Jun 2015 08:13:58 -0400
> 
> > Um, but my test isn't testing what is being stored to memory at
> > all. It is storing to memory and **never loading from the memory
> > after**. Why would writing FROM fp registers TO memory corrupt the
> > *registers* due to a missing memory barrier?
> 
> The memory barrier is necessary for two reasons, only one of them is
> to handle the asynchronousness of the memory operations.
> 
> The other reason is that there are strict rules for accessing the FPU
> register file around block loads and stores.
> 
> Therefore if you don't do the proper memory barriers you can get
> corrupted FPU register as well as memory contents.
> 
> And complicating things even more, what you can get away with is
> different on every single cpu variant.  That's why I really wish

So it means the userland code doesn't run the same on the various
CPU. How are we supposed to do with static binaries?

> debian didn't disable multiarch as that makes the code use the
> UltraSPARC-I/II/III memcpy, which might not be %100 kosher on
> Niagara-T1 and later.

The UltraSPARC-I/II/III memcpy code might have issues, but it clearly
works a lot better than the Niagara-T1 code on a Niagara-T1 machine.
Disabling multiarch support improves a lot the stability on these
machines.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
