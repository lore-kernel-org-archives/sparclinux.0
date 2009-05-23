From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 23 May 2009 13:02:30 +0000
Subject: Re: sparc32 boot problem (SCSI?)
Message-Id: <20090523130230.GA16511@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1608E3.6040009@earthlink.net>
In-Reply-To: <4A1608E3.6040009@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, May 22, 2009 at 09:21:54PM -0400, Robert Reif wrote:
> Josip Rodin wrote:
>> You might want to do the generic initramfs debug steps like those
>> described at http://wiki.debian.org/InitramfsDebug
>>   
> I tried the steps above and I don't see any issues.  All the
> devices are in /dev, fstype returns the right info and
> /proc/modules are the same.
>
> The two significant differences in boot messages are the
> timestamps and the premount output of the bad boot
> has less output.

The removed duplication looks like an improvement to me, and so does
the fixed timestamp (the old values can't be right, assuming the core of
the old kernel doesn't actually boot for 497 days before it comes to the
root filesystem :)).

One thing that came up with one of my recent upgrades was the md subsystem
interfering with /dev/root, and that kind of a problem isn't mentioned in
the generic instructions. Does /dev/root point to the right device (same
major:minor as /dev/sda2) in your case?

-- 
     2. That which causes joy or happiness.
