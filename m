From: Ben Collins <bcollins@debian.org>
Date: Thu, 29 Jan 2004 20:18:53 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040129201853.GM532@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 29, 2004 at 02:13:21PM -0600, Mustafa Hussein wrote:
> Hi Ben,
> I tried to boot a ~4.1MB  2.6.2-rc2  image using second.b version 1.4.2 that I 
> compiled overnight. Here is what I got:
> 
> SILO version 1.4.2
> boot: linux2.6.2-rc2
> Allocated 8 megs of memory at 0x40000000 for kernel
> Uncompressing image ...
> Loaded kernel version 2.6.2 ...
> Remapping the kernel ... done
> 

Can you boot with "linux2.6.2-rc2 -p", so we can see where it really
stops?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
