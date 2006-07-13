From: "Eric Brower" <ebrower@gmail.com>
Date: Thu, 13 Jul 2006 17:35:32 +0000
Subject: Re: loading Debian Linux onto Sun Ultra2
Message-Id: <ec7cefb0607131035lf2dcdc1k3ed6ae3807009f5a@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060713143952.68697.qmail@web52206.mail.yahoo.com>
In-Reply-To: <20060713143952.68697.qmail@web52206.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 7/13/06, Daniel Kweh <dakweh29@yahoo.com> wrote:
> Hi,
> I tried to install debian Linux onto Ultra 2. I hit
> <Stop A> to stop the booting from default. I key in
> boot cdrom, it did tries to reboot from cdrom and
> started on reading the debian intstall cd, then it
> stops at and error and couldnt reproceed. I cant key
> anything on the system. It seems to be hang.
> this is the error
>
> Allocated 8 Megs of memory at 0x40000000 for kernel
> Loaded Kernel version 2.4.27
> Loading initial ramdisk (3041649) bytes at 0x1FC02000
> phys, 0x40C00000 virt)...
>
> inconsistent console:  input 1, output 0
> program terminated
> ok..

Your OBP settings have incompatible values for input-device and
output-device, it seems.  What does "getenv" show from the ok> OBP
prompt?  Your "input-device" and "output-device" should be compatible
(that means "input=keyboard, output=screen or both ttya or ttyb).

In a pinch, you can hold-down Stop-N during the boot process to reset
your OBP to default values (which may not be what you want depending
upon your configuration, which we know nothing about).

Thanks,

-- 
E
