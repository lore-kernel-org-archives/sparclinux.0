From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 17 Apr 2007 08:09:29 +0000
Subject: 2.6.21-rc7 now works with gcc-4.2.0
Message-Id: <200704170809.l3H89T8M016248@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David,

Your patch to remove the broken sys32_ipc stub eliminated
the hang I reported (using hdparm on a kernel compiled
with gcc-4.2.0).

Thanks.

/Mikael
