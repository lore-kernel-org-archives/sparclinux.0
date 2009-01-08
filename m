From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 08 Jan 2009 19:50:57 +0000
Subject: make ARCH=sparc allmodconfig => 64BIT=y
Message-Id: <20090108195057.GB1308@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After the patch that added a 64BIT menu I cannot
generate a 32 bit allmodconfig.

I have not yet deeply looked at it but I assume this is
because "64 bit" is a visible menu when we have
arch equa sparc and then allmodconfig set it to
the highest value (=y).

x86 does this a bit different:

i386 => 32 bit
x86_64 => 64 bit
x86 => 64 bit (IIRC)

But we do not want three arch options for sparc so
maybe we just have to live with that
  make ARCH=sparc allmodconfig

results in a 64 bit kernel.


What I do locally is that I created a file:

echo "CONFIG_64BIT=n" > 64bit
make ARCH=sparc allmodconfig KCONFIG_ALLCONFIGdbit

This gives me an allmodconfig for 32 bit.

	Sam
