From: Josh Grebe <josh@brokedown.net>
Date: Wed, 08 Mar 2006 02:54:21 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <440E475D.3000805@brokedown.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:

>I don't understand what is going on with this, Linux doesn't
>do anything special in this area.
>
>Whatever is provided in the "available" property of the
>"/memory" OBP device tree node, we will use.
>
>So you need to double check what's going on here.  Because
>the only sensible explanation is that OBP isn't providing
>all of your ram in that property when it should, but that
>does not jive with Solaris doing the right thing because
>Solaris gets the available memory information the same
>exact way.
>  
>

Hi Dave,

I'll try to keep it short, hopefully I don't miss anytying important.

Sun Fire V240, No Keyboard
Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.17.1, 2048 MB memory installed, Serial #56597527.
Ethernet address 0:3:ba:5f:9c:17, Host ID: 835f9c17.

This box has 4 sticks of 512M ram. Each CPU has 4 slots. Sun 
documentation claims the box is NUMA. Kernel is 2.6.15-gentoo-r7.

OBP's ls shows the following relevant devices:
f0067474 memory-controller@1,0
f0067150 SUNW,UltraSPARC-IIIi@1,0
f0067014 memory-controller@0,0
f00668d0 SUNW,UltraSPARC-IIIi@0,0
f00405c4 virtual-memory
f003ffa8 memory@m0,0


With 2 sticks per CPU:
1} ok cd /memory
{1} ok .properties
reg                      00000000 00000000 00000000 40000000
                         00000010 00000000 00000000 40000000
available                00000010 3f000000 00000000 00ea0000
                         00000010 00000000 00000000 3effe000
                         00000000 00000000 00000000 40000000
name                     memory

Bootling linux with debug bootmem:
bootmem_init: Scan pavail, init_bootmem(min[0], bootmap[81f990], 
max[81ff77])
free_bootmem(pavail:0): base[0] size[40000000]
free_bootmem(pavail:1): base[1000000000] size[3effe000]
free_bootmem(pavail:2): base[103f000000] size[e9e000]
free_bootmem(pavail:3): base[103fea0000] size[10000]
free_bootmem(pavail:4): base[103fee0000] size[6000]
free_bootmem(pavail:5): base[103feea000] size[4000]
reserve_bootmem(kernel): base[103f000000] size[31e960]
reserve_bootmem(bootmap): base[103f320000] size[103ff0]

Kernel says:
[   11.912574] Memory: 1488528k available (2064k kernel code, 704k data, 
136k init) [fffff80000000000,000000103feee000]

Full dmesg log: http://dev.gentoo.org/~squash/v240-2.txt

Now, I put all 4 sticks on cpu 0.
{1} ok cd /memory
{1} ok .properties
reg                      00000010 00000000 00000000 40000000
                         00000012 00000000 00000000 40000000
available                00000012 3f000000 00000000 00ea0000
                         00000012 00000000 00000000 3effe000
                         00000010 00000000 00000000 40000000
name                     memory

bootmem_init: Scan pavail, init_bootmem(min[800000], bootmap[91f990], 
max[91ff77])
free_bootmem(pavail:0): base[1000000000] size[40000000]
free_bootmem(pavail:1): base[1200000000] size[3effe000]
free_bootmem(pavail:2): base[123f000000] size[e9e000]
free_bootmem(pavail:3): base[123fea0000] size[10000]
free_bootmem(pavail:4): base[123fee0000] size[6000]
free_bootmem(pavail:5): base[123feea000] size[4000]
reserve_bootmem(kernel): base[123f000000] size[31e960]
reserve_bootmem(bootmap): base[123f320000] size[23ff0]

[    2.734391] Memory: 2004600k available (2064k kernel code, 704k data, 
136k init) [fffff80000000000,000000123feee000]

Full dmesg log: http://dev.gentoo.org/~squash/v240.txt



It would appear that grouping all 4 sticks to cpu0 now gives me the full 
2G in the box. Yay!

Thanks,

Josh

