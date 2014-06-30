From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 30 Jun 2014 05:23:41 +0000
Subject: Re: problem booting kernel compiled with gcc-4.9
Message-Id: <20140630052341.GA20371@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1406261446590.16879@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1406261446590.16879@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> [   53.693569]  sda: sda1 sda2 sda3 sda4
> [   53.699149] sd 0:0:0:0: [sda] Attached SCSI disk
> [   53.910103] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
> [   54.011911] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
> [   54.136507] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
> [   54.237263] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.

Do you see the above when the kernel boots properly with the older gcc?

If not then I suggest to forward the bug report to the ext4 mailing list
(which I cannot remeber the address of - maybe fsdevel)

	Sam

> [   54.340199] devtmpfs: mounted
> [   54.451346] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
> [   54.451346] 
> [   54.571516] CPU: 1 PID: 1 Comm: init Not tainted 3.16.0-rc2-00211-gd7933ab #96
> [   54.666431] Call Trace:
> [   54.698453]  [0000000000762f8c] panic+0xb0/0x224
> [   54.759071]  [000000000045cf68] do_exit+0x948/0x960
> [   54.823123]  [000000000042cbc0] fault_in_user_windows+0xe0/0x100
> [   54.902036]  [0000000000404ad0] __handle_user_windows+0x0/0x10
> [   54.978662] Press Stop-A (L1-A) to return to the boot prom
> [   55.050713] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
> 
> 
> -- 
> Meelis Roos (mroos@linux.ee)
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
