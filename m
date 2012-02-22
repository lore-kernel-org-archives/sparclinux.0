From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Wed, 22 Feb 2012 18:22:36 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <4F45326C.3000408@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202130942030.1488@math.ut.ee> <20120213080618.GA11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202131119040.1488@math.ut.ee> <20120213214623.GJ11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202162151030.16208@math.ut.ee> <alpine.SOC.1.00.1202201109260.467@math.ut.ee> <20120220170603.GC7836@mtj.dyndns.org> <alpine.SOC.1.00.1202210030530.11350@math.ut.ee> <20120221010537.GA15898@dhcp-172-17-108-109.mtv.corp.google.com> <alpine.SOC.1.00.1202220213180.4171@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202220213180.4171@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Meelis Roos <mroos@linux.ee>
Cc: Tejun Heo <tj@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, sam@ravnborg.org, "David S. Miller" <davem@davemloft.net>

On 22/02/2012 00:36, Meelis Roos wrote:
>> Meelis, can you please apply the following patch before&  after the
>> offending commit, boot with "memblock=DEbug" added as kernel param and
>> post the boot log?  The patch will generate some offset warnings after
>> the commit but should work fine.
>
> Before the commit (v3.2-rc3-75-g0ee332c): memblock1.gz (attached)
> After the commit (v3.2-rc3-76-g7bd0b0f): memblock2.gz (attached)
>
Its a long time since I regularly had to worry about SPARC boxes (not)=20
booting so may be the difference between virtual & physical addresses=20
but I notice that some of the addresses in the register dump have=20
non-zero values in the upper 32 bits but the memblock values have zero=20
in the upper half.


memblock reserved: ADD [0x0000007fcc0a40-0x0000007fcc0a4e] node 1
memblock reserved: add [0x0000007fcc0a40-000000007fcc0a4e] node 1 @767

But a similar address in the registers has fffff800 in there.

o4: fffff8007fcc0a4d

I know that there are a number of explanations why things would be=20
different (32 bit acesses etc) but it could explain things plus we would=20
be talking 64 bit addresses in the kernel.

Just a thought.

Richard


> In addition, a third type of sparc machines breaks in a third way - V210
> and V240 just hang after telling
>
> console [tty0] enabled, bootconsole disabled
>
> and before calibrating the delay loop. Bisect has led to the same commit.
>
