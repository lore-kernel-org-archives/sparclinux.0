From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 28 Nov 2016 20:40:34 +0000
Subject: Re: Build regressions/improvements in v4.9-rc7
Message-Id: <CADxRZqzUnJr-FavZkc6RypHk+A6yO2BLxqJHRtdKhBCbWBDYWw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1480343257-26723-1-git-send-email-geert@linux-m68k.org> <CAMuHMdXQ1--skMHOW1HLtCeeeGR4PqkYLHh8rVukPU=V8u4fQg@mail.gmail.com>
In-Reply-To: <CAMuHMdXQ1--skMHOW1HLtCeeeGR4PqkYLHh8rVukPU=V8u4fQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

On Mon, Nov 28, 2016 at 5:29 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Nov 28, 2016 at 3:27 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v4.9-rc7[1] to v4.9-rc6[3], the summaries are:
>>   - build errors: +10/-4
>
>   + /home/kisskb/slave/src/drivers/scsi/qlogicpti.c: error: passing
> argument 3 of 'dma_alloc_coherent' from incompatible pointer type
> [-Werror=incompatible-pointer-types]:  => 813:9, 822:9
>   + /home/kisskb/slave/src/sound/sparc/dbri.c: error: passing argument
> 3 of 'dma_zalloc_coherent' from incompatible pointer type
> [-Werror=incompatible-pointer-types]:  => 2538:6
>
> sparc64-allmodconfig
>
>> [1] http://kisskb.ellerman.id.au/kisskb/head/e5517c2a5a49ed5e99047008629f1cd60246ea0e/ (all 267 configs)
>> [3] http://kisskb.ellerman.id.au/kisskb/head/9c763584b7c8911106bb77af7e648bef09af9d80/ (all 267 configs)

I'm unable to compile kernel as well, bisected in between 4.9-rc7
(bad) and 4.9-rc6 (good):

$ git bisect start
... (compile iterations)
$ git bisect  good
d30a6b84df00128e03588564925dc828a53e6865 is the first bad commit
commit d30a6b84df00128e03588564925dc828a53e6865
Author: Tushar Dave <tushar.n.dave@oracle.com>
Date:   Fri Oct 28 10:12:45 2016 -0700

    sparc64: Enable 64-bit DMA

    ATU 64bit addressing allows PCIe devices with 64bit DMA capabilities
    to use ATU for 64bit DMA.

    Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
    Reviewed-by: chris hyser <chris.hyser@oracle.com>
    Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 abde3a8ed14eebe2b73645787b570ba41310530c
be19f6854a06402f2b629b7b7b46babcbbc6f516 M      arch

$ git bisect log
git bisect start
# bad: [e5517c2a5a49ed5e99047008629f1cd60246ea0e] Linux 4.9-rc7
git bisect bad e5517c2a5a49ed5e99047008629f1cd60246ea0e
# good: [9c763584b7c8911106bb77af7e648bef09af9d80] Linux 4.9-rc6
git bisect good 9c763584b7c8911106bb77af7e648bef09af9d80
# bad: [ded9b5dd205ef04aa095c3b731c635b201191a59] Merge branch
'perf-urgent-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad ded9b5dd205ef04aa095c3b731c635b201191a59
# good: [3f0ae05d6fea0ed5b19efdbc9c9f8e02685a3af3] rtnl: fix the loop
index update error in rtnl_dump_ifinfo()
git bisect good 3f0ae05d6fea0ed5b19efdbc9c9f8e02685a3af3
# bad: [8e5bfa8c1f8471aa4a2d30be631ef2b50e10abaf] sched/autogroup: Do
not use autogroup->tg in zombie threads
git bisect bad 8e5bfa8c1f8471aa4a2d30be631ef2b50e10abaf
# bad: [e6b5f1be7afe1657c40c08082c562b1a036a54c1] config: Adding the
new config parameter CONFIG_PROVE_LOCKING_SMALL for sparc
git bisect bad e6b5f1be7afe1657c40c08082c562b1a036a54c1
# good: [31f077dc7dffd4a444932a9fe7fe84d9c7b90b73] sparc64: Initialize
iommu_map_table and iommu_pool
git bisect good 31f077dc7dffd4a444932a9fe7fe84d9c7b90b73
# bad: [d30a6b84df00128e03588564925dc828a53e6865] sparc64: Enable 64-bit DMA
git bisect bad d30a6b84df00128e03588564925dc828a53e6865
# good: [f08978b0fdbf37d3c91efb60a20bdee3ba8f59c6] sparc64: Enable
sun4v dma ops to use IOMMU v2 APIs
git bisect good f08978b0fdbf37d3c91efb60a20bdee3ba8f59c6
# first bad commit: [d30a6b84df00128e03588564925dc828a53e6865]
sparc64: Enable 64-bit DMA
