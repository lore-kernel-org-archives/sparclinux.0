From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 27 Apr 2010 15:34:30 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <4BD70406.6070004@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/16/2010 08:36 AM, Stephen Smalley wrote:
> On Thu, 2010-04-15 at 15:25 -0700, David Miller wrote:
>> From: Stephen Smalley <sds@tycho.nsa.gov>
>> Date: Thu, 15 Apr 2010 08:43:05 -0400
>>
>>> Your eu-readelf output showed why SELinux is checking execmem - the data
>>> segment has flags RWE and thus a private file mapping is being created
>>> with PROT_WRITE and PROT_EXEC.  That's a problem with the compiler
>>> toolchain - report it to them please.  This was a problem with ppc32
>>> binaries before secure-plt was introduced.
>>
>> I don't really intend to implement secure-plt any time soon on sparc
>> because there simply is no way to do it efficiently.
>>
>> And when you talk about "toolchain issues" that all goes my way
>> anyways, so just direct such queries to me directly since I handle
>> both the kernel and toolchain bits entirely myself these days.
>>
>> So you'll always have to deal with the PLT section on sparc having
>> write and execute permission.
> 
> Ok.  Can someone with sparc hardware try the patch I posted to see if it
> suffices?

Apologies for the delay. Your patch does not suffice.

With your patch applied, this is the result:

dracut: Mounted root filesystem /dev/mapper/vg_apollo-lv_root
dracut: Loading SELinux policy
type04 audit(1272381939.416:2): enforcing=1 old_enforcing=0
auidB94967295 sesB94967295
type03 audit(1272381940.696:3): policy loaded auidB94967295
sesB94967295
dracut: Switching root
type00 audit(1272381942.195:4): avc:  denied  { execmem } for
pid55 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
tcontext=system_u:system_r:consoletype_t:s0 tclass=process
type00 audit(1272381942.245:5): avc:  denied  { execmem } for
pid59 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
tcontext=system_u:system_r:consoletype_t:s0 tclass=process
type00 audit(1272381942.315:6): avc:  denied  { execmem } for
pid60 comm="hostname" scontext=system_u:system_r:hostname_t:s0
tcontext=system_u:system_r:hostname_t:s0 tclass=process
type00 audit(1272381942.356:7): avc:  denied  { execmem } for
pid50 comm="readahead-colle"
scontext=system_u:system_r:readahead_t:s0
tcontext=system_u:system_r:readahead_t:s0 tclass=process
type00 audit(1272381942.376:8): avc:  denied  { execmem } for
pid63 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process
type00 audit(1272381942.385:9): avc:  denied  { execmem } for
pid65 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
tcontext=system_u:system_r:consoletype_t:s0 tclass=process
type00 audit(1272381942.396:10): avc:  denied  { execmem } for
pid68 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
tcontext=system_u:system_r:consoletype_t:s0 tclass=process
type00 audit(1272381942.466:11): avc:  denied  { execmem } for
pid77 comm="restorecon" scontext=system_u:system_r:setfiles_t:s0
tcontext=system_u:system_r:setfiles_t:s0 tclass=process
udev: starting version 145
e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
e1000e: Copyright (c) 1999-2008 Intel Corporation.
0000:08:00.0: eth0: (PCI Express:2.5GB/s:Width x4) 00:14:4f:d4:8a:5a
0000:08:00.0: eth0: Intel(R) PRO/1000 Network Connection
0000:08:00.0: eth0: MAC: 0, PHY: 4, PBA No: ffffff-0ff
0000:08:00.1: eth1: (PCI Express:2.5GB/s:Width x4) 00:14:4f:d4:8a:5b
0000:08:00.1: eth1: Intel(R) PRO/1000 Network Connection
0000:08:00.1: eth1: MAC: 0, PHY: 4, PBA No: ffffff-0ff
0000:09:00.0: eth2: (PCI Express:2.5GB/s:Width x4) 00:14:4f:d4:8a:5c
0000:09:00.0: eth2: Intel(R) PRO/1000 Network Connection
0000:09:00.0: eth2: MAC: 0, PHY: 4, PBA No: ffffff-0ff
0000:09:00.1: eth3: (PCI Express:2.5GB/s:Width x4) 00:14:4f:d4:8a:5d
0000:09:00.1: eth3: Intel(R) PRO/1000 Network Connection
0000:09:00.1: eth3: MAC: 0, PHY: 4, PBA No: ffffff-0ff
__ratelimit: 24 callbacks suppressed
type00 audit(1272381946.637:20): avc:  denied  { execmem } for
pid32 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process
type00 audit(1272381946.637:21): avc:  denied  { execmem } for
pid33 comm="restorecon" scontext=system_u:system_r:setfiles_t:s0
tcontext=system_u:system_r:setfiles_t:s0 tclass=process
type00 audit(1272381946.654:22): avc:  denied  { execmem } for
pid34 comm="plymouth" scontext=system_u:system_r:plymouth_t:s0
tcontext=system_u:system_r:plymouth_t:s0 tclass=process
type00 audit(1272381946.687:23): avc:  denied  { execmem } for
pid37 comm="hostname" scontext=system_u:system_r:hostname_t:s0
tcontext=system_u:system_r:hostname_t:s0 tclass=process
device-mapper: multipath: version 1.1.0 loaded
type00 audit(1272381947.536:24): avc:  denied  { execmem } for
pid85 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process
type00 audit(1272381947.546:25): avc:  denied  { execmem } for
pid87 comm="restorecon" scontext=system_u:system_r:setfiles_t:s0
tcontext=system_u:system_r:setfiles_t:s0 tclass=process
type00 audit(1272381947.556:26): avc:  denied  { execmem } for
pid90 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process
type00 audit(1272381947.566:27): avc:  denied  { execmem } for
pid91 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process
type00 audit(1272381947.566:28): avc:  denied  { execmem } for
pid92 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process
type00 audit(1272381947.576:29): avc:  denied  { execmem } for
pid93 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process
Adding 35241968k swap on /dev/mapper/vg_apollo-lv_swap.  Priority:-1
extents:1 across:35241968k
__ratelimit: 123 callbacks suppressed
type00 audit(1272381951.656:71): avc:  denied  { execmem } for
pid55 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
tcontext=system_u:system_r:consoletype_t:s0 tclass=process
type00 audit(1272381951.726:72): avc:  denied  { execmem } for
pid61 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
tcontext=system_u:system_r:consoletype_t:s0 tclass=process
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
type00 audit(1272381952.934:73): avc:  denied  { execmem } for
pid41 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process
type00 audit(1272381952.996:74): avc:  denied  { execmem } for
pid50 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
tcontext=system_u:system_r:consoletype_t:s0 tclass=process
type00 audit(1272381953.146:75): avc:  denied  { execmem } for
pid57 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
tcontext=system_u:system_r:consoletype_t:s0 tclass=process
type00 audit(1272381953.246:76): avc:  denied  { execmem } for
pid61 comm="sshd" scontext=system_u:system_r:sshd_t:s0-s0:c0.c1023
tcontext=system_u:system_r:sshd_t:s0-s0:c0.c1023 tclass=process
type00 audit(1272381953.286:77): avc:  denied  { execmem } for
pid68 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
tcontext=system_u:system_r:consoletype_t:s0 tclass=process
type00 audit(1272381953.456:78): avc:  denied  { execmem } for
pid77 comm="sendmail" scontext=system_u:system_r:sendmail_t:s0
tcontext=system_u:system_r:sendmail_t:s0 tclass=process
type00 audit(1272381953.464:79): avc:  denied  { execmem } for
pid78 comm="plymouth" scontext=system_u:system_r:plymouth_t:s0
tcontext=system_u:system_r:plymouth_t:s0 tclass=process
type00 audit(1272381953.506:80): avc:  denied  { execmem } for
pid82 comm="restorecon" scontext=system_u:system_r:setfiles_t:s0
tcontext=system_u:system_r:setfiles_t:s0 tclass=process
__ratelimit: 21 callbacks suppressed
type00 audit(1272381957.135:88): avc:  denied  { execmem } for
pid40 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process
type00 audit(1272381957.135:90): avc:  denied  { execmem } for
pid41 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process
type00 audit(1272381957.135:91): avc:  denied  { execmem } for
pid38 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process
type00 audit(1272381957.135:92): avc:  denied  { execmem } for
pid43 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process
type00 audit(1272381957.135:89): avc:  denied  { execmem } for
pid39 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process
type00 audit(1272381957.135:93): avc:  denied  { execmem } for
pid42 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process
init: tty4 main process (1938) terminated with status 127
init: tty4 main process ended, respawning
init: tty5 main process (1939) terminated with status 127
init: tty5 main process ended, respawning
init: tty2 main process (1940) terminated with status 127
init: tty2 main process ended, respawning
init: tty3 main process (1941) terminated with status 127
init: tty3 main process ended, respawning
init: tty1 main process (1942) terminated with status 127
init: tty1 main process ended, respawning
init: tty6 main process (1943) terminated with status 127
init: tty6 main process ended, respawning
type00 audit(1272381957.145:94): avc:  denied  { execmem } for
pid44 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process
type00 audit(1272381957.145:95): avc:  denied  { execmem } for
pid45 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process
type00 audit(1272381957.145:96): avc:  denied  { execmem } for
pid46 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process
type00 audit(1272381957.145:97): avc:  denied  { execmem } for
pid47 comm="mingetty" scontext=system_u:system_r:getty_t:s0
tcontext=system_u:system_r:getty_t:s0 tclass=process

Init trails off and the system never goes anywhere.

~spot
