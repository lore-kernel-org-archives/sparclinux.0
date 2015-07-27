From: Meelis Roos <mroos@linux.ee>
Date: Mon, 27 Jul 2015 11:38:49 +0000
Subject: Occasional userland crashes on sparc in 4.1.0+
Message-Id: <alpine.LRH.2.11.1507271430410.23956@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While compiling 4.2-rc3 on my test machines, I got segfaults during 
compilation on V240 and V440. Running repeated compilations encountered 
some more of these, on both 4.1.0 and 4.2-rc3.

At the first glance, no UltraSparc II machines had this but I have not 
done any more stresstesting on them.

Symptions from dmesg:

[111825.922395] as[22148]: segfault at 2424f128 ip 0000000000021f30 (rpc 0000000000050c85) sp 00000000ffcea018 error 30001 in as[10000+46000]
[76756.534860] git[20101]: segfault at 0 ip 00000000f7752448 (rpc 00000000f76e7d68) sp 00000000f6fbeef0 error 30001 in libc-2.19.so[f7668000+16a000]

These happen once per several days for continuous compilation. So they 
might be slightly older than 4.1.0.

Additionally, v240 still sees the possible irq lock inversion dependency 
as reported in https://lkml.org/lkml/2015/5/11/348 but this is probably 
not related.

-- 
Meelis Roos (mroos@linux.ee)
