From: "David S. Miller" <davem@redhat.com>
Date: Sun, 20 Jun 2004 19:41:25 +0000
Subject: Re: New SILO (was Re: [SOLVED] Take 3: sparc64 CDs work?)
Message-Id: <20040620124125.4db065cb.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040620170821.GA19634@phunnypharm.org>
In-Reply-To: <20040620170821.GA19634@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 20 Jun 2004 13:08:22 -0400
Ben Collins <bcollins@debian.org> wrote:

> I suspect that in the long run, I really need to make it so that the
> initrd gets lower memory precendence over the kernel. The kernel itself
> can be loaded anywhere for sparc64, even in 64-bit address ranges.
> 
> But for now, I am about to release SILO 1.4.6 to atleast make this less
> of a mystery on systems where it fails.

I have a better idea, remove the 32-bit limitation.

Create a new HdrS version, add a new member at the end of the bootloader
header area "sparc_ramdisk_image64", set it to ~0 by default, if the
bootloader sets it to some non-~0 value, we use it instead of the
32-bit limited sparc_ramdisk_image value.
