From: "Fabio M. Di NItto" <fabbione@fabbione.net>
Date: Thu, 06 Jan 2011 04:35:03 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <4D254677.6010001@fabbione.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/05/2011 11:39 PM, Sam Ravnborg wrote:
> On Wed, Jan 05, 2011 at 01:09:59PM -0800, David Miller wrote:
>>
>> After commit 25edd6946a1d74e5e77813c2324a0908c68bcf9e ("sparc64: Get
>> rid of indirect p1275 PROM call buffer.")  we can't pass virtual
>> addresses >4GB to PROM calls.
>>
>> Largely this is never necessary in drivers because we have a copy of
>> the entire PROM device tree in the kernel and a set of of_*()
>> interfaces to access it.
>>
>> Unfortunately there were some lingering prom calls in the atyfb
>> driver, in particular prom_finddevice() was being called with an
>> on-stack address which could be anywhere.
>>
>> This code is actually probing for information we already have, the
>> PROM choosen console output device is stored in of_console_device so
>> all of this nasty code consolidates into a one-line comparison.
>>
>> Next we have some prom_getintdefault() calls which are trivially
>> transformed into the equivalent of_getintprop_default().
>>
>> Special thanks to Fabio, who figured out exactly where the bootup
>> was hanging.  That made this bug trivial to fix.
> 
> The patch did not fix my hang during boot.
> I have added a few prinks and I can see that the boot
> hangs here:
>                 printk(KERN_INFO "console [%s%d] enabled, bootconsole disabled\n",
>                         newcon->name, newcon->index);
>                 for_each_console(bcon) {
>                         if (bcon->flags & CON_BOOT)
>                                 unregister_console(bcon);  <<<<<<<
>                 }
> 
> We succeed to unregister "tty" but when we unregister "earlyprom" I see a hang.
> 
> So what I see is a different bug.
> 
> I did not try to persuade it further as it is getting late here.
> 
> Kernel config attached.
> 
> 	Sam

What kernel version are you running exactly? config says 2.6.36-rc7, if
so it's missing other fixes related to the console handover.

Basically, grab 2.6.37 that was released a day ago and apply the patch.

If the problem persist, please comment out the call to
unregister_console and boot with -p. That should give us enough extra
output to see where it's hanging.

Fabio
