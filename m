From: David Miller <davem@davemloft.net>
Date: Tue, 08 Jul 2008 09:33:40 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080708.023340.229070712.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 7 Jul 2008 22:54:31 +0200

> So I once again updated the patchset - they can be pulled here:
> 
>     ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc2.git master
> 
> The only change is the replacement of the patch adding -m64.
> The new commit is appended.
> Diffstat and shortlog omitted - they did not change except for appended patch.
> 
> 
> I have checked that:
> 1) We pass -m64 to gcc when building vmlinux.lds
> 2) that a defconfig builds here
> 3) that we continue to pass -m64 to gcc

Ok this is a lot better, but check headers fails.

--------------------
  CHECK   include/asm-generic/siginfo.h
/home/davem/src/GIT/sparc-next-2.6/usr/include/video/sisfb.h requires asm/ioctl.h, which does not exist in exported headers
  CHECK   include/sound/sb16_csp.h
make[3]: *** [/home/davem/src/GIT/sparc-next-2.6/usr/include/video/.check.sisfb.h] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [video] Error 2
make[2]: *** Waiting for unfinished jobs....
/home/davem/src/GIT/sparc-next-2.6/usr/include/linux/dvb/net.h requires asm/types.h, which does not exist in exported headers
/home/davem/src/GIT/sparc-next-2.6/usr/include/linux/dvb/dmx.h requires asm/types.h, which does not exist in exported headers
/home/davem/src/GIT/sparc-next-2.6/usr/include/linux/dvb/video.h requires asm/types.h, which does not exist in exported headers
--------------------

etc. etc.

Is this expected?
