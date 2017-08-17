From: Meelis Roos <mroos@linux.ee>
Date: Thu, 17 Aug 2017 14:47:56 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <alpine.LRH.2.20.1708171717550.29402@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1708151742360.29628@math.ut.ee> <20170815184403.GB4099@bhelgaas-glaptop.roam.corp.google.com> <alpine.LRH.2.20.1708152321150.11510@math.ut.ee> <alpine.LRH.2.20.1708162136220.16834@math.ut.ee>
 <20170816190241.GD28977@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170816190241.GD28977@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, Linux Kernel list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>

> On Wed, Aug 16, 2017 at 09:39:08PM +0300, Meelis Roos wrote:
> > > > > I noticed that in 4.13.0-rc4 there is a new error in dmesg on my sparc64 
> > > > > t5120 server: can't allocate MSI-X affinity masks.
> > > > > 
> > > > > [   30.274284] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.00-k.
> > > > > [   30.274648] qla2xxx [0000:10:00.0]-001d: : Found an ISP2432 irq 21 iobase 0x000000c100d00000.
> > > > > [   30.275447] qla2xxx 0000:10:00.0: can't allocate MSI-X affinity masks for 2 vectors
> > > > > [   30.816882] scsi host1: qla2xxx
> > > > > [   30.877294] qla2xxx: probe of 0000:10:00.0 failed with error -22
> > > > > [   30.877578] qla2xxx [0000:10:00.1]-001d: : Found an ISP2432 irq 22 iobase 0x000000c100d04000.
> > > > > [   30.878387] qla2xxx 0000:10:00.1: can't allocate MSI-X affinity masks for 2 vectors
> > > > > [   31.367083] scsi host1: qla2xxx
> > > > > [   31.427500] qla2xxx: probe of 0000:10:00.1 failed with error -22
> > > > > 

> IIUC, that means v4.12 works and v4.13-rc4 does not, so this is a
> regression we introduced this cycle.

Yes, I understand the same.

But under some circumstances/configs it has been probematic before too. 
I could not reproduce the circumstances.

> If nobody steps up with a theory, bisecting might be the easiest path
> forward.

I finished bisecting but was not successful. The pattern was strange:
good good skip good skip good skip .... bad bad bad bad bad bad.

The first bad commit was - unrelated xen merge. Reverting this commit 
does not fix the problem.

Like at some moment it got broken by side effects (code size or 
whatever). The skips were most because of repeated on on sparc cpuidle 
code, and initially some in iommu related code. This might bend the 
results so some commits were not tested.

git bisect start
# good: [6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c] Linux 4.12
git bisect good 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c
# bad: [aae4e7a8bc44722fe70d58920a36916b1043195e] Linux 4.13-rc4
git bisect bad aae4e7a8bc44722fe70d58920a36916b1043195e
# good: [920f2ecdf6c3b3526f60fbd38c68597953cad3ee] Merge tag 'sound-4.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 920f2ecdf6c3b3526f60fbd38c68597953cad3ee
# skip: [af3c8d98508d37541d4bf57f13a984a7f73a328c] Merge tag 'drm-for-v4.13' of git://people.freedesktop.org/~airlied/linux
git bisect skip af3c8d98508d37541d4bf57f13a984a7f73a328c
# good: [d29cb3e45e923715f74d8a08d5c1ea996dce5a59] xfs: make _bmap_count_blocks consistent wrt delalloc extent behavior
git bisect good d29cb3e45e923715f74d8a08d5c1ea996dce5a59
# good: [fa6d095eb23a8b1aae78d221879032497f6e457f] drm/tegra: Add driver documentation
git bisect good fa6d095eb23a8b1aae78d221879032497f6e457f
# good: [37e51a7640c275999ea0c35410c42e6d896ff7fa] mm: clean up error handling in write_one_page
git bisect good 37e51a7640c275999ea0c35410c42e6d896ff7fa
# good: [4b9cdd96e7ea3dc2cd0edac67835f6f38c4f14c9] drm/omap: remove CLUT
git bisect good 4b9cdd96e7ea3dc2cd0edac67835f6f38c4f14c9
# good: [7f56c30bd0a232822aca38d288da475613bdff9b] vfio: Remove unnecessary uses of vfio_container.group_lock
git bisect good 7f56c30bd0a232822aca38d288da475613bdff9b
# good: [d7631e30434e7fcf025dd2a7cba879f203f7849b] switch compat_drm_getsareactx() to drm_ioctl_kernel()
git bisect good d7631e30434e7fcf025dd2a7cba879f203f7849b
# skip: [f991af3daabaecff34684fd51fac80319d1baad1] mqueue: fix a use-after-free in sys_mq_notify()
git bisect skip f991af3daabaecff34684fd51fac80319d1baad1
# good: [ecbb903c56745d59c301db26dd7d8b74b520eb84] NFS: Be more careful about mapping file permissions
git bisect good ecbb903c56745d59c301db26dd7d8b74b520eb84
# skip: [b49defe83659cefbb1763d541e779da32594ab10] kvm: avoid unused variable warning for UP builds
git bisect skip b49defe83659cefbb1763d541e779da32594ab10
# good: [b5ab16bf64347ebc9dbdc51a4f603511babda1e6] drm/amdgpu: properly byteswap gpu_info firmware
git bisect good b5ab16bf64347ebc9dbdc51a4f603511babda1e6
# good: [3941dae15ed90437396389e8bb7d2d5b3e63ba4a] drm_dp_aux_dev: switch to read_iter/write_iter
git bisect good 3941dae15ed90437396389e8bb7d2d5b3e63ba4a
# good: [f0d9c8924e2c33764dca0c3a4f693a345ecf6579] [media] media: imx: Add IC subdev drivers
git bisect good f0d9c8924e2c33764dca0c3a4f693a345ecf6579
# skip: [101dd590a7fa37954540cf3149a1c502c0acc524] powerpc/perf: Avoid spurious PMU interrupts after idle
git bisect skip 101dd590a7fa37954540cf3149a1c502c0acc524
# good: [eb0f0373e575822cf35949627b92533c7c41629c] drm/amdgpu: fix a typo in comment
git bisect good eb0f0373e575822cf35949627b92533c7c41629c
# skip: [3f0bd8dad0db73f5d71b355aec5ab33b374260ba] powerpc/perf: Add POWER9 alternate PM_RUN_CYC and PM_RUN_INST_CMPL events
git bisect skip 3f0bd8dad0db73f5d71b355aec5ab33b374260ba
# good: [96edd61dcf44362d3ef0bed1a5361e0ac7886a63] xen/balloon: don't online new memory initially
git bisect good 96edd61dcf44362d3ef0bed1a5361e0ac7886a63
# bad: [bc78d646e708dabd1744ca98744dea316f459497] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect bad bc78d646e708dabd1744ca98744dea316f459497
# bad: [0a2a1330d2621c7f963d9f55bb094811cc1c06b9] Merge branch 'for-4.13-part3' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect bad 0a2a1330d2621c7f963d9f55bb094811cc1c06b9
# bad: [0ce2f385119344dc620ec635e355008a9d6f8401] Merge tag 'acpi-4.13-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 0ce2f385119344dc620ec635e355008a9d6f8401
# bad: [da08f35b0f82b0a7a79f518faf8d0c0b477f91bc] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect bad da08f35b0f82b0a7a79f518faf8d0c0b477f91bc
# bad: [25f6a53799d667283d3bee29a6ac75ae3dae38dc] Merge tag 'jfs-4.13' of git://github.com/kleikamp/linux-shaggy
git bisect bad 25f6a53799d667283d3bee29a6ac75ae3dae38dc
# bad: [eeb7c41d9d7c0902accb1d481fe78d84d30c69cc] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad eeb7c41d9d7c0902accb1d481fe78d84d30c69cc
# bad: [520eccdfe187591a51ea9ab4c1a024ae4d0f68d9] Linux 4.13-rc2
git bisect bad 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9
# bad: [f47e07bc5f1a5c48ed60a8ee55352cb4b2bf4d51] Fix up MAINTAINERS file problems
git bisect bad f47e07bc5f1a5c48ed60a8ee55352cb4b2bf4d51
# bad: [a56e88ec05df50110f2bf578b6e17128f37111ed] Merge tag 'for-linus-4.13b-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect bad a56e88ec05df50110f2bf578b6e17128f37111ed
# first bad commit: [a56e88ec05df50110f2bf578b6e17128f37111ed] Merge tag 'for-linus-4.13b-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip



-- 
Meelis Roos (mroos@linux.ee)
