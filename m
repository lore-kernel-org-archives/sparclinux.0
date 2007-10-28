From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 28 Oct 2007 19:51:42 +0000
Subject: install target in the kernel makefiles
Message-Id: <20071028195142.GA16129@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Is there any reason why the kernel makefiles don't support the 'install'
target on sparc, just like they do on x86(_64)? The standard installkernel(8)
wrapping works fine.

I posted this question a while ago to the debian-sparc list[1] and
Martin Habets replied with a fairly trivial patch[2], but saying it
was not accepted upstream. Can it be accepted now, please? :)

-- 
     2. That which causes joy or happiness.

[1] http://lists.debian.org/debian-sparc/2007/04/msg00005.html
[2] http://lists.debian.org/debian-sparc/2007/04/msg00015.html
