From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 22 May 2009 11:02:51 +0000
Subject: Re: sparc32 boot problem (SCSI?)
Message-Id: <20090522110250.GA16151@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1608E3.6040009@earthlink.net>
In-Reply-To: <4A1608E3.6040009@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, May 21, 2009 at 10:07:31PM -0400, Robert Reif wrote:
> [42949392.780000]  sda: sda1 sda2 sda3 sda4
> [42949392.830000] sd 1:0:0:0: [sda] Attached SCSI disk
> Done.
> Begin: Mounting root file system... ...
> Begin: Running /scripts/local-top ...
> Done.
> Begin: Running /scripts/local-premount ...
> Done.

> [   16.130000]  sda: sda1 sda2 sda3 sda4
> [   16.190000] sd 1:0:0:0: [sda] Attached SCSI disk
> Done.
> Begin: Mounting root file system... ...
> Begin: Running /scripts/local-top ...
> Done.
> Begin: Waiting for root file system... ...
> Done.
> Begin: Running /scripts/local-premount ...
> Done.
> mount: Mounting /dev/sda2 on /root failed: No such device

You might want to do the generic initramfs debug steps like those
described at http://wiki.debian.org/InitramfsDebug

-- 
     2. That which causes joy or happiness.
