From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 14 Sep 2009 11:46:43 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090914114643.GA12068@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Sep 14, 2009 at 03:24:56AM -0700, David Miller wrote:
> 1) Give me the output of /proc/cpuinfo

cpu             : TI UltraSparc IIIi (Jalapeno)
fpu             : UltraSparc IIIi integrated FPU
pmu             : ultra3i
prom            : OBP 4.11.4 2003/07/23 08:04
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0ClkTck      : 000000003bb94e80
Cpu1ClkTck      : 000000003bb94e80
MMU Type        : Cheetah+
State:
CPU0:           online
CPU1:           online

> 2) Try a UP kernel build, does it work even with all of the NMI
>    bits enabled on this machine?

Will try and report shortly.

-- 
     2. That which causes joy or happiness.
