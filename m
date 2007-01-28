From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sun, 28 Jan 2007 12:26:55 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <Pine.LNX.4.61.0701281326060.22295@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Jan 27 2007 18:38, David Miller wrote:
>> 
>> int ret = sys_open((const char __user *)"/dev/console", O_RDWR, 0);
>> if(ret < 0)
>>   printk(KERN_WARNING "Warning: unable to open an "
>>          "initial console (%d)\n", ret);
>> 
>> I wonder what return code it will give (-EFAULT is my guess).
>
>It's not getting -EFAULT, the init task runs with set_fs(KERNEL_DS).

Ok.

>It's getting -ENOENT because no console device has registered
>itself, and therefore even if you have a /dev/console node in
>the filesystem the open will still fail.

Hm that is a little bit misleading. I'd like to see the regular -ENXIO as
happens with "all" the other block/character devices in /dev that don't have
anything associated (well, at least bcak in the days where /dev was static)


	-`J'
-- 
