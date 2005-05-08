From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 08 May 2005 18:20:50 +0000
Subject: Re: [kbuild-devel] select of non-existing I2C* symbols
Message-Id: <20050508182050.GB8182@mars.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net> <20050507144135.GL3590@stusta.de>
In-Reply-To: <20050507144135.GL3590@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Dittmer <jdittmer@ppp0.net>, spyro@f2s.com, zippel@linux-m68k.org, starvik@axis.com, wli@holomorphy.com, linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net, dev-etrax@axis.com, sparclinux@vger.kernel.org

> Shouldn't kconfig exit with an error if a not available symbol gets
> selected?
No. There are meny configurations where we select a symbol that is
only visible in some configurations.

Several possibilities exists:
1) Silently ignore SELECT SYMBOL when SYMBOL is undefined
2) Warn - as we do today
3) Error out as you suggest

Option 1) is preferable for 'make oldconfig' simply because target group
here do not care. But it would be nice to know when one do a typing
error in SELECT. So one *config target should continue to warn about it.

	Sam
