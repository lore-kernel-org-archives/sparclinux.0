From: Ben Collins <bcollins@debian.org>
Date: Mon, 17 May 2004 14:32:36 +0000
Subject: Re: initrd testing
Message-Id: <20040517143236.GJ1286@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 17, 2004 at 07:50:44AM -0700, Patrick Morris wrote:
> boot:
> Allocated 8 Megs of memory at 0x40000000 for kernel
> Uncompressing image...
> Loaded kernel version 2.4.26
> Loading initial ramdisk (1477459 bytes at 0x10C00000 phys, 0x40C00000 
> virt)...
> Remapping the kernel... Done
> Booting Linux

Ok, that looks correct. Now the question is why isn't the kernel doing
the right thing.

Do the cdrom images have bootmem debug enabled in the kernels? If so,
I'd like to see what bootmem-debug says about the pages it is reserving
for the initrd.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
