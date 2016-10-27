From: James Clarke <jrtc27@jrtc27.com>
Date: Thu, 27 Oct 2016 08:25:36 +0000
Subject: Re: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <94FE488D-75AB-4D1A-AD64-CB5B0ADF115E@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.224442.1417439049113609110.davem@davemloft.net>
In-Reply-To: <20161025.224442.1417439049113609110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

> On 27 Oct 2016, at 02:27, James Clarke <jrtc27@jrtc27.com> wrote:
> 
>> On 26 Oct 2016, at 22:02, David Miller <davem@davemloft.net> wrote:
>> 
>> From: James Clarke <jrtc27@jrtc27.com>
>> Date: Wed, 26 Oct 2016 21:05:36 +0100
>> 
>>> Thanks for this, it's now compiling. I'll let you know if it works
>>> within the next 24 hours.
>> 
>> Thanks.
>> 
>>> Before I forget, what do you think about the following patch? I know
>>> Debian used to use the 64-bit kernel for a 32-bit sparc userland, and so
>>> "Architecture: sparc" was correct, but obviously sparc64 also exists. It
>>> seems more sane to make sparc64 default to "Architecture: sparc64", with
>>> sparc users needing to override this with KBUILD_DEBARCH if they want
>>> to, rather than providing a setup that's broken out of the box for
>>> sparc64 users.
>>> 
>>> From: James Clarke <jrtc27@jrtc27.com>
>>> Date: Wed, 26 Oct 2016 20:17:10 +0100
>>> Subject: [PATCH] builddeb: Add support for sparc64
>>> 
>>> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
>> 
>> I don't know.
>> 
>> I still personally use a 32-bit userland on my sparc64 systems because
>> that is what performs the best and is what I will be using for as long
>> as I possibly can.
>> 
>> I've actually never used this target, is this for build the kernel or
>> userland components?
> 
> Yes, make pkg-deb builds kernel, firmware, headers and linux-libc packages.
> By the way, the first build I made of 4.9 (using Debian’s 4.8 config as old
> config) wouldn’t boot, since:
> 
> * sunvdc module needs _mcount
> * sunvnet module needs _mcount and count_bits
> * crc32c_sparc64 module needs _mcount and VISenter
> [* raid6_pq module needs memcpy, though that’s just for a data partition]
> 
> The workaround is not to use CONFIG_MODVERSIONS, but this wasn’t at all clear
> at first. This is because of d3867f0483, which moved these to being exported in
> their .S.
> 
> Anyway, the new kernel is running now and being stress-tested.

Hi David,
I’ve run it on the T5 and it seems to work without lockups:

[5948090.988821] vln_init: *vmap_lazy_nr is 32754
[5948090.989943] vln_init: lazy_max_pages() is 32768
[5948091.157381] TSB[insmod:261876]: DEBUG flush_tsb_kernel_range start=0000000010006000 end=00000000f0000000 PAGE_SIZE=2000
[5948091.157530] TSB[insmod:261876]: DEBUG flush_tsb_kernel_range start=0000000100000000 end=0005ffff8c000000 PAGE_SIZE=2000
[5948091.158240] vln_init: vmap_lazy_nr is caeb1c
[5948091.158252] vln_init: *vmap_lazy_nr is 0
[5948091.159311] vln_init: lazy_max_pages() is 32768
... continues on as normal ...

(again, that’s my debugging module to see how close the system is to a flush)

I can't (yet) vouch for the IIIi, but when it comes back up I’ll give it a go[1].
I'll also put it on the T1 at some point today, but it *should* also work since
it's using the same sun4v/hypervisor implementation as the T5.

Thanks,
James

[1] Not sure how long that will take...

