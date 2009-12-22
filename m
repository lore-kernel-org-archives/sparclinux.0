From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 22 Dec 2009 00:06:26 +0000
Subject: Checking for v9v/64v capability
Message-Id: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Hi,


RPM offers the targets sparcv9v/sparc64v (which is, simply put,
cflags += -mtune=niagara).

On a sun4v, it would make sense to prefer v9v/64v packages over v9/64
packages — and the reverse on sun4u — when a package manager
considers potential candidate files for installation of a wanted
package.

But how would the package manager (apt-get/yum/zypper) decide whether 
they are on sun4v or not, without resorting to testing for 
SPARC-specific hardware itself? That is to say, I think the kernel 
should hand out this information in some way perhaps. Solaris's uname(2) 
syscall would directly return sun4[cduv], while Linux just outputs 
sparc/sparc64.


thanks,
Jan
