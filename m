From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 02 Feb 2011 09:11:30 +0000
Subject: Re: [PATCH 1/2] SPARC32: implement SMP IPIs using the generic functions
Message-Id: <4D491FC2.9030408@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Tue, 01 Feb 2011 08:41:51 +0100
>
>  
>
>>David Miller wrote:
>>
>>    
>>
>>>Yes, and this race is unique to how sparc32 remote IRQ sending works.
>>>On sparc64, for example, we send IRQs to remote cpus by writing only
>>>to local CPU registers.  So events cannot be lost and there are no
>>>chip register programming races.
>>> 
>>>      
>>>
>>But if the same CPU sends a IPI to the same receiver CPU twice when
>>the receiver has interrupts of, shouldn't that also lead to a missed
>>IPI? Perhaps the sparc64 has a FIFO of IPIs.
>>    
>>
>
>Inter-cpu interrupts have an at least 2 entry deep queue in each
>cpu's incoming interrupt vector unit.
>
>And if you overflow (which rarely happens except under extreme
>load), the cpu sends a NACK packet back, which the sender sees
>which lets the sender know it needs to resend.
>
>These vectored interrupts are processed very fast, all they do for
>the IPI case is either a cache/TLB flush or reschedule to a normal
>PIL based IRQ with a local cpu register write.
>
>Vectored interrupts on sparc64 are completely seperate from normal PIL
>level based interrupts.  When we do local_irq_disable() on sparc64,
>vectored interrupts still can arrive and be processed.
>
>They are therefore very low latency, and therefore must either perform
>some very quick task, or reschedule to a local PIL interrupt for
>more involved processing.
>  
>
Ok now I understand the arch a little better, thanks.

>  
>
>>This is already true, it can be located on any 256 Mbyte boundary. The
>>Kconfig options are only used to create the u-boot image, they do not
>>change the arch/sparc/boot/image in any way, just a matter of
>>convenience when creating the uImage similar to other architectures
>>which support u-boot.
>>    
>>
>
>Ok, this is the part I didn't understand.
>  
>
After image is built and zipped the u-boot mkimage utility is executed 
with some input parameters and the zipped image. The parameters are used 
to build a header that u-boot reads in order to understand what kind of 
image it is (filesystem, kernel etc.), kernel entrypoint and location in 
RAM the image needs to be extracted to. So typing "make ARCH=sparc 
uImage" will create an image that u-boot will understand and able to boot.

U-boot communicates with Linux using the Linux-kernel-header (head_32.S 
format), PROM-emulation, device tree and kernel command line as any 
other sparc32 boot loader.

Daniel

