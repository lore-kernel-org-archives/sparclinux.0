From: Peter Hurley <peter@hurleysoftware.com>
Date: Sat, 30 Nov 2013 23:04:20 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <529A6EF4.1050408@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/28/2013 11:47 AM, Meelis Roos wrote:
>>> Another strange symptom is that the problem did not happen when
>>> openpromfs is compiled in statically, not loaded as module. When loaded
>>> as module, its memory is vmalloc()ed... but that's probably too weak
>>> connection to conclude anything.
>>
>> What happens with the not-even-compile-tested debug patch below?
>
> Now I have the results of that test. It does not trigger at all during
> normal shutdown since module is not unloaded. When I unmount openpromfs
> and rmmod openpromfs, both lines are promted to dmesg. After that, the
> RED state still happens on reboot.

Ok, thanks for testing that.

The slab debugging seems a promising line of inquiry.

Regards,
Peter Hurley

