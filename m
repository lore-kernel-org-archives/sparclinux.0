From: Ben Collins <bcollins@debian.org>
Date: Mon, 14 Feb 2005 11:23:09 +0000
Subject: Re: Too big 2.6 kernels on SS5
Message-Id: <20050214112309.GA6838@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502141245530.25663@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502141245530.25663@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Kill these config options.

> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_EXTRA_PASS=y

Pretty sure you don't need all of these framebuffers, right?

> CONFIG_FB_CG3=y
> CONFIG_FB_CG6=y
> CONFIG_FB_TCX=y

Don't need either of these.

> CONFIG_PROM_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y

Kill the 12x22, it's huge.

> CONFIG_FONT_SUN12x22=y

These can be modules, right?

> CONFIG_PACKET=y
> CONFIG_NETLINK_DEV=y

> CONFIG_INPUT_MOUSEDEV=y

> CONFIG_SOUND_GAMEPORT=y

> CONFIG_INPUT_MOUSE=y

> CONFIG_TMPFS=y
> CONFIG_RAMFS=y

Disable this, it adds a lot to the kernel.

> CONFIG_DEBUG_BUGVERBOSE=y


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
