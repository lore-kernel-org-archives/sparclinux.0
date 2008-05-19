From: Meelis Roos <mroos@linux.ee>
Date: Mon, 19 May 2008 06:32:47 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.SOC.4.64.0805190928030.10879@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Should I redo the bisect without restricting to drivers/usb/host?
> 
> That would be a good idea.  After all, we have no proof that the lockup 
> was caused by a change to the USB code.

Hmph. Complete now but I may have bisected for another bug since most 
"bad" bisects hung before even showing any USB-related messages - during 
udev startup with no messages or just after libata startup with no 
further messages.

The new results are not promising either - this time it finished with
[62be1f71677c53d5e51223807a06ac9052f49b0f] [GFS2] fix assertion in log_refund()

So maybe a timing or layout triggered bug somewhere instead? :(

And here is git-bisect log - any ideas on narrowing it down further - 
like retesting the "good" values or something like that?

git-bisect start
# bad: [f74d505b58d36ceeef10e459094f0eb760681165] Merge git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-inttypes
git-bisect bad f74d505b58d36ceeef10e459094f0eb760681165
# good: [4b119e21d0c66c22e8ca03df05d9de623d0eb50f] Linux 2.6.25
git-bisect good 4b119e21d0c66c22e8ca03df05d9de623d0eb50f
# bad: [1bfcd361461f25be7d6d180a8da30d02bc124046] [ALSA] soc - corgi - Fix checkpatch warnings
git-bisect bad 1bfcd361461f25be7d6d180a8da30d02bc124046
# bad: [7cea51be4e91edad05bd834f3235b45c57783f0d] security: fix up documentation for security_module_enable
git-bisect bad 7cea51be4e91edad05bd834f3235b45c57783f0d
# good: [9e9abecfc0ff3a9ad2ead954b37bbfcb863c775e] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86
git-bisect good 9e9abecfc0ff3a9ad2ead954b37bbfcb863c775e
# good: [fda31d7d4b5a9c663ac3ed1ba244018a88deecaf] x86: kgdb build fixgit-bisect good fda31d7d4b5a9c663ac3ed1ba244018a88deecaf
# bad: [eddeb0e2d863e3941d8768e70cb50c6120e61fa0] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394-2.6
git-bisect bad eddeb0e2d863e3941d8768e70cb50c6120e61fa0
# good: [2309e9e040fe29469fb85a384636c455b62fe525] ocfs2/net: Add debug interface to o2net
git-bisect good 2309e9e040fe29469fb85a384636c455b62fe525
# good: [16c5f06f15ad4e5a5d6e90b78ffb1ac14319e445] [GFS2] fix GFP_KERNEL misuses
git-bisect good 16c5f06f15ad4e5a5d6e90b78ffb1ac14319e445
# good: [2ed0f181f0d18d2f565bfbd259fe33d53769f72b] firewire: fw-ohci: refactor probe, remove, suspend, resume
git-bisect good 2ed0f181f0d18d2f565bfbd259fe33d53769f72b
# good: [1dadff71d6356ebb804c3f4f1d3049247e16111c] firewire: replace static ROM cache by allocated cache
git-bisect good 1dadff71d6356ebb804c3f4f1d3049247e16111c
# good: [25b1c3d8889f982ebc6c7b996cfc7fa5f1dce533] firewire: fix synchronization of gap counts
git-bisect good 25b1c3d8889f982ebc6c7b996cfc7fa5f1dce533
# bad: [e675349e2bdbfb661fa0d8ff2441b4cf48fb7e48] Merge branch 'upstream-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2
git-bisect bad e675349e2bdbfb661fa0d8ff2441b4cf48fb7e48
# bad: [ef38ff9d372d4fe69e415370939a0f1fb5783af1] Merge git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-nmw
git-bisect bad ef38ff9d372d4fe69e415370939a0f1fb5783af1

-- 
Meelis Roos (mroos@linux.ee)
