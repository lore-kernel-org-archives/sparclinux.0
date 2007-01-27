From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sat, 27 Jan 2007 16:53:05 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <Pine.LNX.4.61.0701271738470.22295@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>On Sat, 2007-01-27 at 17:05 +0100, Jan Engelhardt wrote:
>> On Jan 27 2007 09:37, Tom 'spot' Callaway wrote:
>> >> 
>> >> int ret = sys_open((const char __user *)"/dev/console", O_RDWR, 0);
>> >> if(ret < 0)
>> >>   printk(KERN_WARNING "Warning: unable to open an "
>> >>          "initial console (%d)\n", ret);
>> >> 
>> >> I wonder what return code it will give (-EFAULT is my guess).
>> >
>> >Warning: unable to open an initial console (-2)
>> >-ENOENT ?
>> >/dev/console is definitely inside the nfsroot that I'm mounting...
>> 
>> In case you are using initramfs/initrd, make it available there too.
>
>I'm not. Everything is compiled in. I'm running make image, then
>elftoaout arch/sparc64/boot/image, and booting the a.out kernel over
>tftp.

Please try adding this before sys_open...

  /* this sys_open never succeeds, hence sys_close is not needed */
  ret = sys_open((const char __user *)"/dev", O_RDWR, 0);
  printk(KERN_WARNING "Unable to open /dev (%d)\n", ret);

And tell us the error code.

  * either it's EISDIR
  * or ENOENT

in either case, more digging is needed, and if it means writing a namespace
walker [ls -Rl] ;-)


	-`J'
-- 
