From: Nawab Ali <alin@ececs.uc.edu>
Date: Mon, 19 Jan 2004 18:23:29 +0000
Subject: TLB miss handler code
Message-Id: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
I have a Sun Ultra-10 running Debian woody. I need to modify the TLB miss
handler code. Basically everytime there is a TLB miss, I'm trying to log
the new PTE that is brought into the TLB.

I know that SPARC machines handle TLB refills in software. Can someone
please point me to the TLB miss handler code(which file???) in the linux
kernel(2.4.24)??? I'm a bit lost here.

Any help would be greatly appreciated.

Thanx.
nawab


