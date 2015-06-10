From: James Y Knight <jyknight@google.com>
Date: Wed, 10 Jun 2015 14:40:58 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <E9C0987E-12F0-478A-A787-7580F335BA00@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> On Jun 10, 2015, at 5:18 AM, David Miller <davem@davemloft.net> wrote:
> 
> From: Aurelien Jarno <aurelien@aurel32.net>
> Date: Wed, 10 Jun 2015 09:50:06 +0200
> 
>> So it means the userland code doesn't run the same on the various
>> CPU. How are we supposed to do with static binaries?
> 
> Multiarch works perfectly fine in static binaries, just the same as it
> does with dynamically linked executables.
> 
> Normally static binaries do not use PLT entries, but with multiarch
> it does, so that the proper routine can be resolved at run time just
> as it would via the dynamic linker.
> 
>> Disabling multiarch support improves a lot the stability on these
>> machines.
> 
> By disabling it you are creating an even worse situation, for the
> reasons I've discussed already, plus guess what I test when I'm
> doing development?

There's really no point in arguing about enabling/disabling multiarch glibc in Debian right now... It seems clear there's a bug -- or two -- in the kernel. I'm really having trouble imagining how it could *possibly* be glibc's fault that kernel addresses are randomly appearing in the floating point registers in my test program. So, let's just figure out how to fix the problem first...

Once the reliability bug is fixed, then there will be no argument -- nobody will be against enabling the sparc multiarch routines in Debian's glibc then.

Also, given the behavior of the ASI_BLK_P stores in my test program, it seems hard to imagine that memcpy-niagara2.S could possibly be reliable, since it also uses the same "stda src, [addr] ASI_BLK_P" instruction and will run into the same random errors upon pagefault.


But separately from the reliability issue, it seems rather unfortunate that the 'default' sparcv9 and sparc64 routines aren't actually coded to the base sparcv9 standard instruction set. It seems like probably the base routines should limit themselves to normal LDX/STX or LDDF/STDF instructions, and leave things like LDBLOCKF (which the docs mark CPU-specific, and deprecated, and potentially to be removed from future chips), for when a specific processor is targeted.