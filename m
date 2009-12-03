From: Jan Engelhardt <jengelh@medozas.de>
Date: Thu, 03 Dec 2009 21:55:29 +0000
Subject: Re: No MC sched domains
Message-Id: <alpine.LSU.2.01.0912032247460.21624@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Wednesday 2009-12-02 23:57, David Miller wrote:
>
>> the T1 is said to be multi-core, however, I am not seeing any MC sched 
>> levels in dmesg as I do on x86. Why is that?
>
>The T1 cores are repesented as SMT units.

It seems so.

/sys/devices/system/cpu/
cpu0/topology/physical_package_id:0
cpu1/topology/physical_package_id:0
cpu10/topology/physical_package_id:2
cpu11/topology/physical_package_id:2
cpu12/topology/physical_package_id:3
cpu13/topology/physical_package_id:3
cpu14/topology/physical_package_id:3
cpu15/topology/physical_package_id:3
cpu16/topology/physical_package_id:4
...

Why is this done, when they are, in fact, not multiple physical 
packages?
